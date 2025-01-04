# Networks

There are many reasons to consider running a network for a BEST
Robotics competition.  You may want to locate scoreboards further from
your scoring table than video cables allow.  You may want to use
direct-entry digital scoring, or make use of your network to connect
judgest with PCSM in a different room.  You may just want to browse
memes while waiting on a team to find the field despite being paged 5
times already.

Whatever the reason, there are some considerations to make when
running a network for BEST:

  * Will you use the venue/house network?
  * Will this network be internet connected?
  * Who's equipment will be used? (Own vs. Rent)
  * Will general volunteers have access?
  * Will you provide connectivity to your teams?
  * What applications will you use on your network?

We'll go through each of these points, and then look at two possible
network architectures that you can use depending on the size of your
event.

## Venue and House Networks

As a general rule, you should not be using the venue or "house"
network.  Unless you personally are the IT that owns and operates that
network (and even then you should really have BEST in a partition for
*so many* reasons) you should not use the house network.  This is
because the house network is configured for the needs of the
organization that owns and operates it, not BEST.  This usually means
that point-to-point connectivity is disabled or heavily filtered,
addresses are not static or arranged for quick adjacency, and there
may be other traffic or users present on the network.

The one thing you can use the house network for reliably is a WAN or
Internet connection.  This puts the untrusted network on the other
side of a firewall from all BEST things, and makes the request to the
venue much simpler.  If you want to get internet from your venue, the
magic request is usually a hard-line network connection supplied with
DHCP, and with port-security disabled since you'll be providing a
downstream router.  Some venues will initially question the use of a
downstream router, it is important to explain the unique technical
challenges of BEST Robotics, the need for strict control of access to
the network, and the ability to rigorously test everything days and
weeks in advance of your game-day.  If your network is sufficiently
portable, you may even wind up bringing it with you to your practice
or exhibition days, something that would be impossible to do with a
specific venue's network.

## Will You Have Internet?

Internet connectivity is extremely handy to have, and can make it much
easier to retrieve materials from the BRI file manager, allow you to
publish scores in real time, or allow you to use OSM for retrieval of
advancement inputs.

Internet should always be supplied on a cable or network hardline.
Generally you'll be connecting to an existing network and not provided
directly with a public address, so you'll be stacking NATs.  This is
not ideal, but is comletely workable in most venues.  Coordinate with
venue IT to ensure you won't have the same address space on each side
of your NAT.

## Who's Equipment Will Be Used?

The complexity of most BEST events far exceeds that of the humble
linksys router.  Therefore, you'll need to gain access to some more
suitable equipment.  Later in this document you'll learn how to use
the Gizmo FMS in a mode that provides you with a robust network for
scoring and similar functions, but if you want a network that spans a
large physical campus (such as a high school with courtyards) you'll
need some more hardware.  Consider carefully whether this is a prudent
investment, or if it would be better to solicit either a donation
in-kind from an IT firm, or find a volunteer who may "rent" you this
equipment on a daily basis.

To put down some ballpark figures, the network equipment used to run
Dallas BEST which covers a single large Gymnasium and 2 classrooms is
approximately $250 invested across a substantial router, selection of
cables, access point, and a nice case to protect the equipment.
Moving up in scale, Capital BEST which in most years spans 2 Gyms, 3
Classrooms, a large Cafeteria space and usually a large lecture hall
makes use of a substantial amount of equipment and cable, on the order
of $2000 in equipment total.  At the large end, Texas BEST which
lights up service in the Texas Fair Park Collesium makes use of
roughly $15k in network equipment, cable, and the associated hardware
to transport, deploy, and crucially un-deploy over such a large
footprint.

Do not underestimate these costs, but also understand that the largest
cost is always the human one.  BEST is an all-volunteer organization,
and having hardware does you no good without skilled volunteers to
understand the unique challenges that BEST poses, and our stringent
requirements for success.  You should expect that a skilled engineer
who can provide their services commercially will run in the
$250-$300/hr range.  Many are willing to donate their time since BEST
is on a mission that resonates with many industry professionals, but
be aware the effort being asked of your volunteers.


## Who Will Have Access?

Having a network opens up the question of who will have access to it.
In general your scorekeepers will need to have access, but may not
themselves need to know network passwords or access codes.  You can
simply pre-provision computers for them to use, or input these keys
yourself.

In the author's experience, its usually okay to permit trusted
volunteers to have access to the network, though usually this is
accompanied by a short lecture (<20 seconds) about not sharing this
access and being careful.  If you intend to have general volunteers on
the network, it is important to ensure that your scoring manager
instances are secured using strong passwords, that your Gizmo FMS is
protected by firewalls, and that you still be selective in how you
actually provide volunteers with access.

If you intend to provide teams with access, it is imperative that they
be isolated to a distinct VLAN and if possible distinct VRF.  Teams
must be considered untrusted actors on your network that represent and
imminent security threat.  While it is unlikely that any team would
intentionally do harm, this is a risk you simply cannot afford to
take, and can defend against without substantial effort.

When your network is receiving internet from your host venue, its a
good idea to double check if there are any strings attached to the use
of the host venue's internet.  Many academic institutions receive
their internet connections from vendors that put restrictions on how
they can be used, and as a downstream consumer, you must abide by
these restrictions if applicable.  This can restrict out of the gate
who has access, as many universities and schools will request you to
have only "mission critical" entities on the network.  Fortunately
such places usually also provide a guest network for your attendees to
use.

## What Applications Will Be Available?

The entire point of having a network is to enable various applications
to be used across multiple computers.  There are several applications
that are in common use across BEST, and some less common.  Here are
some of the most common and things you may need to consider:

  * PC Scoring Manager (PCSM) and Pi Scoring Manager (PiSM) - These
    are the meat and potatoes of the robot game.  They run locally and
    provide services directly onto the network.  It is important for
    these services to be protected by strong passwords.  Consider
    sourcing a dedicated computer for running the scoreboard, or run
    it as part of an approved and validated architecture, such as the
    hub-in-a-box architecture.

  * Pitman - This paperless pit management application is meant to
    assist with check-in, machine compliance, and general pit
    management.  It is a web application that can be accessed from
    either a computer or tablet connected to your network.  It should
    be protected by a strong password per its operating instructions,
    but isn't necessarily as critical as the scoring system itself.

  * PCSMPages - This is an add-on service which provides additional
    web-pages for PCSM that are designed to support video production
    work.  They are designed to be luma-keyed into other scenes and
    provide lower thirds with team information, as well as a paginated
    scoreboard.  These pages can be open to the network as they do not
    contain any sensitive information.

  * Matchclock - Matchclock is a dedicated clock display that plays
    start of match, end of match, and a 30 second warning sound.  It
    is designed for video production work and can be luma-keyed into a
    larger source view or displayed on dedicated displays.  Most
    deployments of matchclock provide a tablet or other device for the
    head referee to use to start the match clock, so that a seperate
    position of timekeeper is not required.

  * Gizmo FMS - This Gizmo FMS itself is a substantial consumer of
    network services, which is why it contains its own network.  Its
    mentioned here to call out that the robot control networks that
    teams connect to using the cables at the driver's positions should
    always be treated as seperate and for that purpose only.  The FMS
    provides an auxiliary network that can be used for non-robot
    concerns, and this is the only network that should be used for
    such concerns.

  * Open Broadcast Studio (OBS) - OBS is a standard tool in the
    toolbox of anyone looking to stream video to the internet.  This
    is a free software tool that takes in cameras, various media
    sources, an even web-pages and allows you to switch between them,
    composite them into scenes, and then stream the entire thing out
    to the internet for viewers who can't make your event in person.
    Setting up and using OBS are well beyond the scope of this
    document, but OBS can be economically setup by using PoE Security
    Cameras which can be very economically sourced.  Being network
    security cameras, they obviously need a network.  Its generally
    not necessary to take any special precautions while using
    something like OBS on your network, but if you intend to work at
    extremely high resolutions (4k or greater), carefully consider if
    this bandwidth usage will impact other applications.
