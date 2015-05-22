NBSPlayer
=========

Minecraft NBS Player.  
Compatible with:

[Versions <= 3.0 **ONLY**]  
ComputerCraft + RichardG's MiscPeripherals OR [Computronics](http://mc.shinonome.ch/doku.php?id=wiki:computronics)

[Versions >= 4.0]  
ComputerCraft + [Computronics](http://mc.shinonome.ch/doku.php?id=wiki:computronics)

Installing
----------
Put all the files in .minecraft/saves/%name%/computer/%id%/.  
You may be able to put them in a subfolder but I did not test that, so use at your own risk!  
Once you're done, just run "playnbs.lua <enable colors> <path to file> <monitor side (can be modem)> <noteblock side (must be modem)>"!

Example Setup
-------------
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

<!-- actual values:
20.0
10.0
6.666666666666667
5.0
4.0
3.3333333333333335
2.857142857142857
2.5
2.2222222222222223
2.0
1.8181818181818181
1.6666666666666667
1.5384615384615385
1.4285714285714286
1.3333333333333333
1.25
1.1764705882352942
1.1111111111111112
1.0526315789473684
1.0 -->

Please note that those are base speeds only, as the ATS (Beta) adds support for more speeds...

Minecraft Sound System Limits
-----------------------------
Minecraft's Sound System has 2 limits:

1. Minecraft's Sound System has a 2 octave limit... There's no **easy** way to change this...
2. Minecraft is set up to only allow 16 simultaneous sounds, that means songs with more than 16 simultaneous note blocks will skip a few notes. Being near mobs will also skip notes.

Donate
------
We currently accept Dogecoin donations.
To donate dogecoins, send them to DEMXiwXBDKRRrYB7fio9LM3eL9WwXX7fXb
