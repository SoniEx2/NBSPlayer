NBSPlayer
=========

Minecraft NBS Player.  
Compatible with:

[Versions <= 3.0 **ONLY**]  
ComputerCraft + RichardG's MiscPeripherals OR [Computronics](http://mc.shinonome.ch/doku.php?id=wiki:computronics)

[Versions >= 4.0]  
OpenComputers + [Computronics](http://mc.shinonome.ch/doku.php?id=wiki:computronics)

Installing
----------
Put all the files in .minecraft/saves/%name%/computer/%id%/.  
You may be able to put them in a subfolder but I did not test that, so use at your own risk!  
Once you're done, just run "playMonitor <enable colors> <path to file>"!

Setup
-----
Place down a computer.  
On top of that computer, place down a monitor. (either color or black & white)  
Below that computer, place down a wired modem, and connect your Iron Note Blocks to that modem.

Supported speeds
----------------
There are 20 base speeds supported, 10 of them are supported in vanilla, 8 of them are "perfect floats":  
(Bold are "perfect floats", vanilla speeds include repeater delay)

**20**  
**10** - 1  
6\.67  
**5** - 2  
**4**  
3\.33 - 3  
2\.86  
**2\.5** - 4  
2\.22  
**2** - 4+1  
1\.82  
1\.67 - 4+2  
1\.54  
1\.43 - 4+3  
1\.33  
**1\.25** - 4+4  
1\.18  
1\.11 - 4+4+1  
1\.05  
**1** - 4+4+2

Please note that those are base speeds only, as the ATS (Beta) adds support for more speeds...

Minecraft Sound System Limits
-----------------------------
Minecraft's Sound System has 2 limits:

1. Minecraft's Sound System has a 2 octave limit... There's no **easy** way to change this...
2. Minecraft is set up to only allow 16 simultaneous sounds, that means songs with more than 16 simultaneous note blocks will skip a few notes. Being near mobs will also skip notes.
(PS: Feel free to bug Dinnerbone about this... He won't do it... This program doesn't use Minecraft in the way it was intended to be used...)
