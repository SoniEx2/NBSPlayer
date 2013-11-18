NBSPlayer
=========

ComputerCraft NBS player

Supported speeds
----------------
If 20 = 5\*2\*2, then we can get the following values:

20 TPS (20 / 1)  
10 TPS (20 / 2)  
5 TPS (20 / 2\*2)  
4 TPS (20 / 5)  
2.5 TPS (20 / 2\*2\*2)  
2 TPS (20 / 5\*2)  
1.25 TPS (20 / 2\*2\*2\*2)
1 TPS (20 / 5\*2\*2)

Please note that those are base speeds only, as the ATS adds support for more speeds...

Minecraft Sound System Limits
-----------------------------
Minecraft is set up to only allow 16 simultaneous sounds, that means songs with more than 16 simultaneous note blocks will skip a few notes. Being near mobs will also skip notes.
(PS: Feel free to bug Dinnerbone about this... He won't do it... This program doesn't use Minecraft in the way it was intended to be used...)
