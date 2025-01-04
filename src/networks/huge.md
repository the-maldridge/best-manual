# Huge Network

Sometimes you need to go big.  Either by choice or requirements,
building a huge network is not for the faint of heart, and this is
firmly the territory where you need an actual network engineer who
knows what they're doing to save you from peril and expensive
mistakes.  A large network will be characterized by the raw
throughput, physical scale, and vast array of services and
requirements that it fulfills.  For this network example, we'll dive
deep into how the Texas BEST network is put together.

Texas BEST is a championship-scale event supporting more than 85 teams
across 3 divisions and a rookie bowl, as well as various other
functions such as a mascot dance off, robot parade, and high
production environment.  The Texas BEST network is also installed into
a historically protected fairground which has functionally no
infrastructure of its own.  Close coordination with event media and
AT&T is required to pull off a successful deployment.  The network
depicted here supports several key requirements:

  * Total aggregate throughput in excess of 5Gbit/s.  This is the
    fastest service that AT&T reasonably delivers to the Fair Park
    Colleseum.

  * Extremely low latency spans for use by the media production
    company.  These spans support passing production video and audio
    between various points and must support an entry-to-exit latency
    not more than 1.1 milliseconds with a maximum allowable jitter of
    100 microseconds.

  * Interconnect with the Gizmo FMS network.  The Gizmo FMS network
    must become a seamless part of the main event network to enable
    remote debugging from the production suite, as well as access to
    screens that exist solely within the Gizmo network's ecosystem at
    terminals not physically connected to the FMS network.

  * Team connectivity.  The fair park pavilion is old.  There is no
    standing infrastructure and cellular service is spotty.  As a
    result the event provides wifi to teams in the pit areas to enable
    access to debugging resources, online document suites, and other
    resources the team may need quick access to while in their pits.

  * Remote access.  At times it is necessary to provide a means of
    remote access to members of the BRI software development team to
    advise in the event of a non-nominal event occuring in some
    component of the BRI-managed software stack.  This is usually
    facilitated by a screen sharing session, but can also be
    facilitated by a secure RDP session or SSH depending on the system
    in question and the preferences of the remote engineer being
    connected in.

  * Host a myriad of internal applications.  At a championship-scale
    event with an external media company, the network provides not
    only a large number of additional compositing resources, but
    file-shares for media assets and other resources.  Running an HA
    pair of scoring servers requires additional infrastructure as well
    which must be hosted on-site.

  * Quick deploy and un-deploy to avoid the total time we're in the
    space without access to the internet, as well as to support the
    various other systems and services that have to be deployed on top
    of the network.

This results in a few derived requirements:

  * The network needs to be VLAN aware, and use sophisticated
    firewalls to protect the various security zones.

  * The Gizmo FMS is capable of dynamic routing via BGP, so the event
    core must be able to act as a private BGP Peer.

  * A robust application serving system must be available.

  * The physical scale and unique power architecture of the fair park
    mandates the use of an optical core network.

This network is too large to fit in a single diagram, so we'll break
it down into smaller parts:

```d2
prodsuite : Production Suite {
    demarc : AT&T Demarcation Router
    core0 : Core Router
    sw0 : Core Switch
    srv : Application Server
    ap : Access Point

    gs : Game Servers {
        style.multiple: true
    }

    sw1 : Media Switch
    stream : Stream Encoder

    demarc -> core0 : 5GBaseT
    core0 -> sw0 : 2x1GBaseT (MLAG)
    sw0 -> srv : 2x1GBaseT (MLAG)
    sw0 -> ap : 1GBaseT (PoE)
    sw0 -> sw1 : 1GBaseT
    sw0 -> gs : 1GBaseT
    sw0 -> stream: 1GBaseT
}

pits : Pit Area
score : Scoring Area

prodsuite.core0 -> pits : 1000BaseSX
prodsuite.core0 -> score : 1000BaseSX
```

In the production suite the equipment in the above diagram is
connected to a large Uninteruptible Power Supply (UPS).  This ensures
that not only is the power on, but any dips or excursions in voltage
are covered prior to reaching the compute equipment in the room.

The core router used, for reference, is a Mikrotik CCR2004-1G-12S+2XS.
This is a 25Gbit/s capable core router with 12 10Gbit/s optical
interfaces.  Though there is no need to go as fast as 25Gbit/s, the
important thing to consider is this router has sufficient memory to
sustain enough NAT sessions to supply wifi to teams.  The number of
NAT sessions is estimated to be 15 per device across 350 devices to
produce a pessimistic estimate.  The core switch, similarly
substantial, is an HPE 2350 PoE switch.  This provides a good density
of PoE enabled ports, while still supporting a fat-pipe architecture
for its backplane.

The media switch is a ruggedized Netgear small office switch since it
needs to actually sit with the production equipment.  The access
points used are Aruba Instant in a mix of 225 and 315 hardware,
depending on deployed location.

Needless to say, all of this equipment is VLAN aware and supports
policy based L3 routing and switching.  This is a critical requirement
to be able to keep various security zones isolated and to prioritize
latency sensitive traffic.  The VLANs in use are carefully coordinated
against the Gizmo FMS pools to enable the Gizmo FMS router to make use
of a layer 2 trunk for interconnection back to the core router.

The production suite maintains the core network, which feeds two
smaller footprints on the main arena floor.  The simpler of the two is
in the pit area:

```d2
pits : Pit Area {
    switch : Ethernet Switch
    aps : Access Points {
        style.multiple: true
    }
    lookups : Score Review Terminal {
        style.multiple: true
    }

    switch -> aps : 1GBaseT (PoE)
    switch -> lookups : 1GBaseT
}

prodsuite : Production Suite
prodsuite -> pits.switch : 1000BaseSX
```

Connectivity in the pit area is characterized by 2 key use cases.  For
personal device connectivity, multiple access points are strategically
deployed around the pits to ensure good connectivity and balance
across the deployed radios.  These access points require power to
operate, which is supplied from the pit area switch via PoE.

The second connectivity provided to the pit area is in the form of
computers that may be used to review scorecards.  These computers are
located at a designated table and have limited access to the scoring
logistics VLAN since they need to be able to directly communicate with
the game servers.  Students may at any time recall a scorecard from
these machines to review their progress or determine if a further
inquiry is required.

The final area with concentrated network access is in the immediate
game area.  Most of this infrastructure is located at a row of tables
set back from the fields where scorekeeping staff, production
management, and key game personel sit.

```d2
game : Game Area {
    switch : Ethernet Switch
    fms : Gizmo FMS
    ap: Access Point

    scoretops : Score Access Terminals {
        style.multiple: true
    }

    switch -> fms : DAC (Peering Trunk)
    switch -> ap : 1GBaseT (PoE)
    switch -> scoretops : 1GBaseT
}
prodsuite : Production Suite
prodsuite -> game.switch : 1000BaseSX
```

The network footprint in the immediate game area is characterized by 3
key users.  The simplest are wireless users roaming through the
immediate area of the game field.  These users transparently roam to
the access point near the field, which is operating at 5Ghz to
maintain band isolation against other equipment in the immediate field
area.  The access point is located physically with the field area
switch, and is supplied with power via a PoE connection from the field
area switch.

The second use case served at the field area is game scoring.  This
can be either score entry or score lookup (the scoring servers are
back in the production suite).  This is just a connection from some
laptops to ports on the access switch that are connected to the
scoring logistics VLAN.  Its important to guard these ports and not
provision this VLAN everywhere, so the game field area switch is
really the only place that has several of these ports in a
not-fully-consumed configuration.  This is done as a choice to have
more capacity than is required and avoid the need to adjust switch
configs on-site.

The final consumer of network in the field area is the Gizmo FMS
itself.  This is, for clarity, the entire FMS and its associated
functionality, but to simplify for this discussion, the FMS is
considered to be the Scoring Table Box as that's the only point at
which the two networks touch.  Since the Scoring Table Box is a router
in its own right, we have to use some additional techniques to
interconnect it to the rest of the network.  On Gizmo routers that
have an SFP cage, the cage is configured as a switch trunk port with
all the Gizmo's VLANs present on it.  This means that we can just
connect the SFP on the FMS router to a free SFP on the scoring area
switch using a Direct Attach Cable (DAC) and with some careful
planning the VLAN that allows the two routers to peer is present on
the switch as one of the tagged VLANs.  This peering is made using a
BGP session, which allows the core router and the FMS router to
dynamically exchange information about what traffic each one is
responsible for.

This last part is getting into some fairly advanced networking, and
most events won't ever need to care about it.  We do this at Texas
BEST to make it possible to treat both the Gizmo FMS and our existing
event network as one large system without having to keep track of
which network things are actually plugged in to.  Security is
maintained by a set of zone-based firewalls applied at the core router
back at the production suite, which is the only place that its
possible to hop from one security zone to another.
