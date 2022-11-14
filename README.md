# Inverse Kinematic

Name: Nilei Pan

x500: pan00128

Name:ZiRui Chen

x500: Chen6713

## Features

#### Multi-arm IK

<img src=".\multiarm.gif" alt="multiarm" style="zoom:50%;" />
<img src=".\wheelChairMan.gif" alt="wheelChair" style="zoom:100%;" />
#### Joint Limit

Shown below,  First one is when joint limit applied. Second one is when there is no joint limit in effect,

<img src=".\withlimit.gif" alt="withlimit" style="zoom:50%;" />

<img src=".\nolimit.gif" alt="nolimit" style="zoom:50%;" />

#### Re-rooting

Gif below show the arm constantly re-root itself in order to move towards the chest

<img src=".\reroot.gif" alt="reroot" style="zoom:50%;" />

### Part2

Fabrik implemented for part2, they behave mostly identical but with huge implementation difference which  I will list below.

<img src=".\fabrik.gif" alt="fabrik" style="zoom:50%;" /><img src=".\ccd.gif" alt="ccd" style="zoom:50%;" />

1. As shown in the gif above, CCD is implemented with joint acceleration cap which I did in capping the angular velocity change. But since Fabrik has no explicit joint, I couldn't find a proper way to do the similar effect.
2. Re-root, Fabrik looks exactly the same, but much easier than CCD. In CCD, I need to re-calculate each angle for each joint. While I can just swap the joint position and be done with it, with little extra work that to draw each arm part in a reverse way.
3. Joint limit, Fabrik is harder and much more work than CCD where CCD can just cap the angle diff and result angle directly. Fabrik need to calculate the angle using dot product between two arm parts connected to this joint and based on how much this current angle violate the limit, rotate back cur-limit angle.



### Art contest

<img src=".\art.PNG" alt="art" style="zoom:50%;" />

A heart by multi-arm

### Tools and Library used:
No tools and libraies are used besides what's provided to us.
