# Cameras

Usually you'll want to stream a live video feed in addition to any
pre-recorded content.  To do this, you'll need at least one camera.
There are broadly two choices here, depending on whether you have a
network or not.  Cameras that connect directly to the streaming
computer, and cameras that are accessed over the network.

> [!WARNING]
>
> Streaming video to the internet that includes the faces of minors is
> a legally thorny subject.  Make sure that you do due diligence if
> any of your camera angles will capture students, and ensure that
> people locally know that you are streaming and its clearly
> communicated which parts of the floor are in-frame.

## Directly Connected Cameras

Directly connected cameras are, as the name implies, directly
connected to the machine handling your stream.  There are several
choices here.

Most of these kinds of devices will attach using USB, and USB is an
extremely strange standard if you look too closely.  In general the
following rules apply:

  * Each camera will use about 200 MBit/s of bandwidth.
  * Each USB controller can supply *at most* 480 MBit/s of bandwidth.
  * There can be *at most* 7 USB Hubs in a chain, and hubs show up in
    far more places than you might expect (the cables below are
    technically 1 port hubs).

### USB Webcams

The humble USB Webcam is a great choice for a first camera to stream
with.  More modern cameras made by Logitech feature the standard
1/4-20 tripod interface to enable mounting the camera on a tripod or
grip, and since this is a standard thread, you can always just put a
1/4" 20 thread per inch bolt through some wood if you want to mount a
camera directly to the field.

In particular, [this one](https://www.amazon.com/dp/B01LXCDPPK)
provides an impressive resolution, has the mounting hole, and features
very good auto-focus.  It does not like being on the end of a long
cable though, so keep that in mind.

USB webcams can usually be extended by using USB extension cables, as
long as the cable is an "active" cable.  These cables usually have at
least one "lump" in them, and are about 40' long.  I have used
[these](https://www.amazon.com/dp/B0777MR56X) and found them to work
pretty well.  If plugged directly into a computer, or using a powered
external hub, its possible to chain 2 of them together, though beware
reliability issues when stacking USB cables in this fashion.

### USB Capture Cards

USB Capture Cards allow you to ingest video from a source that doesn't
plug in via USB, but instead uses some more specialized video
connector.  In my streaming systems, I currently use two different
kinds of capture cards.

#### Magewell HDMI

[Manufacturer Site](https://www.magewell.com/products/usb-capture-hdmi-gen-2)

This is a dongle that shows up as a monitor to anything plugged into
it.  The video is then captured and converted into a pseudo-camera
device that's presented to the computer on the USB side.  I use
several of these to allow ingesting presentations, powerpoints, and
feeds from specialized media devices.

#### Magewell SDI

[Manufacturer Site](https://www.magewell.com/products/usb-capture-sdi-gen-2)

SDI is a specialist format for passing around high-resolution
broadcast video with audio embedded.  This uses special cables,
special adapters, and you start needing to understand a lot more video
production concepts to use SDI.  Where SDI is valuable is that many
professional production companies work with it, and it is often the
easiest compatible standard for a company to export the video from
their systems to yours with.

## Network Cameras

Network cameras are by and large a product of the security world.
Networked surveilance cameras can be had quite inexpensively, and in
the last few years have become extremely high resolution.  I use
Reolink RLC-510A cameras with an adapter base to fit them onto a
tripod mount.  These cameras are approximately 4k resolution, with a
very slight fish-eye lensing.  While I could remove the fish-eye lens,
its also possible to remove the effect digitally since I'm re-framing
the feed to 1080p.  This downsampling makes the non-linear pixel
density less of an issue.

Network cameras are a great choice if you already have a network since
they usually will use Power Over Ethernet (PoE) meaning you only need
one cable to carry signal and data.  Ethernet cables can also be up to
300 feet, providing much more flexibility in placement for these
cameras.

