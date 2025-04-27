# Computers

To stream any kind of content, you will need a computer to run your
stream encoder on.  In addition to the computer, you'll need a typical
set of peripherals, such as monitors, keyboard and mouse, UPS battery
backup (strongly recommended), and any other devices you want to use
with the computer.

You can use a laptop to stream with, but unless you are using a fairly
high performance laptop, or a portable workstation class machine, you
will encounter issues with how much load video processing puts on the
system.  For these reasons, its recommended to use a system designed
for desktop use.  For very large events with an extremely large number
of dynamic media sources, a full size desktop PC with powerful GPU is
required.  To get started, more modest hardware is perfectly
acceptable.

## Mini PCs

You can start streaming your events easily with modest mini-PC
hardware.  These are machines that occupy a market segment between
laptops and small desktops.  They usually use high-grade laptop
components, but feature more peripherals and substantially better
thermal design.

A great place to find these is on Amazon's renewed hardware listings.
These listings feature the computer itself, a keyboard, mouse, and
usually an assortment of Bluetooth and Wifi adapters.

The computers discussed below are ones I have personally used, and can
vouch for.

> [!NOTE]
>
> I run exclusively Linux based systems, so all of my performance
> numbers and experiences are in that context.  Linux typically has
> lower standby resource usage than Microsoft Windows, so you should
> consider buying higher-spec hardware if you intend to use Windows
> with it.

### Lenovo Thinkcentre m73 Tiny

[Amazon Listing](https://www.amazon.com/dp/B07V6ZNQZY)

This is a very small machine made by Lenovo.  These can drive dual
monitors, and feature discrete USB controllers which allows for using
more USB webcams.  While very inexpensive, these are older machines
now, and will become outmoded as newer video codecs become available
that are not supported by hardware.

### HP Elitedesk 800

[Amazon Listing](https://www.amazon.com/dp/B08KSGKHVS)

This is a higher spec machine than the Lenovo, and costs more as a
result.  It features still more USB controllers, and the DisplayPort
supports multi-stream capability, which allows you to drive 3 monitors
with an adapter [like this one](https://www.amazon.com/dp/B0BF41V4C2).
With one display on VGA and additional displays on DP its possible to
have a two monitor setup for controlling the system and additionally
driving a projector locally with the same content that is going out to
the internet.

### Asus Expertcenter PN64-E1

[Amazon Listing](https://www.amazon.com/dp/B0BFWJJTG9)

> [!NOTE]
>
> This is my current workhorse machine for streaming.  If you've seen
> an official BRI, BTR, Capitol BEST or Dallas BEST stream between
> 2022 and 2025, this machine ran that stream.  My version was built
> out to max spec, whereas the Amazon link above is the standard SKU.

This is a much more powerful machine, suitable for working at 4k
resolution and featuring Intel QuickSync technology for
hardware-assisted encoding.  This means the machine can offload
computationally intensive tasks to specialized hardware rather than
running such tasks on the CPU.  I pair this machine with addditional
peripherals, and make use of its ability to drive two local displays
for editing, and then casting out additional content to local
projectors and venue video distribution hardware.

## Raspberry Pi

You can run OBS on Linux, and in turn on a Raspberry Pi.  This is a
great way to maintain identical hardware everywhere if you're already
using Raspberry Pi hardware for the Gizmo FMS.

### Raspberry Pi 500

[PiShop Listing](https://www.pishop.us/product/raspberry-pi-500-us-main-unit-only/)

The Raspberry Pi 500 is an all-in-one style wedge-PC.  This ARM based
computer has sufficient power to run a respectable stream, but don't
expect to be able to run more than 1-2 cameras and 1-2 browser
sources.  Static images and pre-recorded media are functionally free,
so you can run as much of that as you want on any hardware.
