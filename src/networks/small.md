# Small Network

For small events, such as those consisting of a main competition space
with adjacent pits, the Gizmo's FMS Auxiliary Network may be all you
actually need.  This is the "Infrastructure Network" that you are
prompted about in the setup screens, and is broadcast at 5Ghz from the
field radios.  This is in a different band than any of the robots and
will not interfere with them.  In general though you should still try
to plug in any laptops that you intend to use.  The FMS network port
(port 2) on the scoring table box is the source of this network, and
you can get additional ports by connecting a dumb/unmanaged ethernet
switch to this port if required.

This kind of network is suitable for cases where you just need a
little network, and you don't need it to be particularly advanced.

Visually, this is what this network looks like:

```d2
stb : Scoring Table Box
fb : Field Box
sl : Scoring Computer
gfms : FMS Workstation
sw : Ethernet Switch
int : Internet

stb -> int : Ethernet (Port 1)
stb -> fb : Ethernet (Ports 3-5)
stb -> sw : Ethernet (Port 2)
sw -> gfms : Ethernet
sw -> sl : Ethernet
```

Its quick, its using equipment you already have, and it can supply a
modest event with all the services that are required and then some.
The Gizmo FMS network is also a good starting place to determine what
youre requirements are, since it gives you enough to get started and
determine what else you might require.
