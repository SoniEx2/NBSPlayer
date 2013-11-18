NBSPlayer
=========

ComputerCraft NBS player

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
Base speeds supported:

20TPS  
10 TPS  
7\.67 TPS  
5 TPS  
4 TPS  
3\.33 TPS  
2\.85 TPS  
2\.5 TPS  
2\.22 TPS  
2 TPS  
1\.82 TPS  
1\.67 TPS  
1\.54 TPS  
1\.43 TPS  
1\.33 TPS  
1\.25 TPS  
1\.18 TPS  
1\.11 TPS  
1\.05 TPS  
1 TPS

Please note that those are base speeds only, as the ATS adds support for more speeds...

Minecraft Sound System Limits
-----------------------------
Minecraft's Sound System has 2 limits:

1. Minecraft's Sound System has a 2 octave limit... There's no **easy** way to change this...
2. Minecraft is set up to only allow 16 simultaneous sounds, that means songs with more than 16 simultaneous note blocks will skip a few notes. Being near mobs will also skip notes.
(PS: Feel free to bug Dinnerbone about this... He won't do it... This program doesn't use Minecraft in the way it was intended to be used...)
