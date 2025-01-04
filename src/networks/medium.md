# Medium Network

For larger events such as those that supply private network
connectivity to judges rooms, volunteer spaces, and other ancilliary
areas, a more substantial network is required.  This network will be
larger in 2 dimensions: the services that are offered and the physical
footprint.

To enable more services to be offered, its time to add a small form
factor server that's not a laptop.  This will live with the core
router and switching equipment.  For logistics reasons, its
recommended to set this equipment up wherever your pit administration
area is since that's usually the first area that's up and the last
area to come down.  An SFF PC chassis running a basic Linux is a good
choice for an event server since all applications that you may wish to
deploy to it are available as Docker containers.  Do not be scared by
it being called a "server".  This just refers to it being a dedicated
machine that has no monitor and that nobody sits in front of.  Once
you configure the applications you want, there really isn't any
additional configuration to be applied.

To be physically larger is just a matter of adding more ethernet
switches, more wireless access points, and more cable.  When running
more than one access point, its a good idea to use a managed access
point which can coordinate device roaming, otherwise you'll see issues
when a device is in range of more than one access point and it cannot
firmly consider one to be a better signal.  If running a fully
external network from the FMS, you should use externally managed
access points.  Aruba Instant access points are a good choice for this
and can be had on ebay for little money.  These access points
self-host their control plane on whatever access point boots up first,
and provide an intuitive web interface for configuration.

Let's look at the Capitol BEST network and the various components:

```d2

pits : Pit Area {
  core : Core Router
  csw : Core Switch
  optimux : Optical Switch
  apps : Application Server

  phone : Phone (x110)
  tel : Telephone Switch
  ap : Root Access Point

  core <-> csw : 1GBaseT
  core <-> optimux : 1GBaseT (PoE)
  core <-> tel : 1GBaseT Peering

  csw <-> ap : 1GBaseT (PoE)
  csw <-> phone : 1GBaseT (PoE)
  csw <-> apps : 1GBaseT
}

game : Field Area {
  fms : FMS Router (Scoring Box)
  switch : Scoring Table Switch
  ap : Access Point
  phone : Phone (x111)

  camera : IP Cameras {
    style.multiple: true
  }
  obs : Streaming Computer

  switch <-> fms : 1GBaseT (Peering SFP1)
  switch <-> ap : 1GBaseT (PoE)
  switch <-> phone : 1GBaseT (PoE)
  switch <-> camera : 1GBaseT (PoE)
  switch <-> obs : 1GBaseT
}

judges : Judges Room {
  switch : Judges Room Switch
  ap : Access Point
  phone : Phone (x112)
  conf : Conference Phone (x130)

  switch <-> ap : 1GBaseT (PoE)
  switch <-> phone : 1GBaseT (PoE)
  switch <-> conf : 1GBaseT (PoE)
}

pits.optimux <-> game.switch : 1000BaseSX
pits.optimux <-> judges.switch : 1000BaseSX
```

Not pictured are several wireless belt-pack phones, various laptops
connected in various locations, and the entire Gizmo FMS network that
is behind the Gizmo router.

There are several things worth calling out in this network:

  * Phones!  Capitol BEST makes use of a private telephone network to
    quickly and efficiently communicate point to point.  We have both
    fixed phones and wireless phones for key staff.  Usually we'll
    equip the pit admin, hub director and head referee with phones
    directly.  This allows, for example, the head referee to
    effortlessly contact the pits without leaving the field.  The
    phones are something that work well for Capitol BEST, but do not
    work for everyone and take some training to use.

  * Several links are optical.  Each of the links above that's listed
    as 1000BaseSX is an optical fiber.  We use these fibers since they
    can go up to 1600 meters without additional hardware, whereas
    ethernet tops out at 100 meters.  While that's 300 feet (approx.)
    keep in mind that many schools in the Texas Hill Country have
    large courtyards, and a single courtyard can be in excess of 300'
    across.

  * Several links are referenced as `Peering`.  These links are
    router-to-router links where we've configured the routers on each
    side to be aware of each other so that their address space is
    directly accessible.  If you don't know what this means don't
    worry, its an optimization that helps us to coordinate this larger
    network.

This is a network that did not spring into existence overnight.  Years
of optimization, evaluation, and figuring out what does and doesn't
work went into this architecture, and its extremely tightly aligned
with the way that the team behind Capitol BEST works.
