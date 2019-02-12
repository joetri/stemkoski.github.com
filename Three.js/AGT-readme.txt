AGT rabbithole rendering.

Wanted to have you guys take a look before I go too far down the 3D rabbithole.

I think the three dimensional rendering and ability to manipulate the scene (click and drag your mouse on the scene, roll the mousewheel forward and back, try firefox if chrome not cooperating) make the data more accessible in some ways.  If you want to look at the 131 Degree mark, rotate the scene to focus on that.  If you want to look at the lower oxygen levels, spin the scene to focus on that.  The "blending" of the temps between zones is clear.

This is a simple proof of concept treatment.  If you like the looks of this and the way it operates, I can go forward in this vein and add more variables, etc.  If it's all too much, I won't push this any further (even though I love three.js and 3D visualization).

This scene is cluttered and doesn't show a lot of variables, but I hope it does show trends clearly.  Some simple observations I make from the data rendered are

	* Bays 1 and 4 have lots of O2
	* Bay 2 has low O2 levels
	* There are similar patterns with temp and O2 levels rising and flattening
	* We're above the 131 degree mark
	 
The data raises a lot of questions.  I've pulled data every 75 seconds to generate the scene.  Is that too often for the sampling?  Does it make sense to have the 4 bays displayed together?  Is the 3D treatment perhaps more useful to engineers?  Is the temp in a bay the last temp reading in that bay?  There are artifacts in the data due to the sampling system: the temps "blending" between bays are not actually a temp anywhere in a pile, but only in the air exchange system.

JG 12 Feb 2019.
