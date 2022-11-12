//Inverse Kinematics
//CSCI 5611 IK [Solution]
// Stephen J. Guy <sjguy@umn.edu>

/*
INTRODUCTION:
Rather than making an artist control every aspect of a characters animation, we will often specify 
key points (e.g., center of mass and hand position) and let an optimizer find the right angles for 
all of the joints in the character's skelton. This is called Inverse Kinematics (IK). Here, we start 
with some simple IK code and try to improve the results a bit to get better motion.

TODO:
Step 1. Change the joint lengths and colors to look more like a human arm. Try to match 
        the length ratios of your own arm/hand, and try to match your own skin tone in the rendering.

Step 2: Add an angle limit to the wrist joint, and limit it to be within +/- 90 degrees relative
        to the lower arm.
        -Be careful to put the joint limits for the wrist *before* you compute the new end effoctor
         position for the next link in CCD

Step 3: Add an angle limit to the shoulder joint to limit the joint to be between 0 and 90 degrees, 
        this should stop the top of the arm from moving off screen.

Step 4: Cap the acceleration of each joint so the joints can only update slowly. Try to tweak the 
        acceleration cap to be different for each joint to get a good effect on the arm motion.

Step 5: Try adding a 4th limb to the IK chain.


CHALLENGE:

1. Go back to the 3-limb arm, can you make it look more human-like. Try adding a simple body to 
   the scene using circles and rectangles. Can you make a scene where the character picks up 
   something and moves it somewhere?
2. Create a more full skeleton. How do you handle the torso having two different arms?

*/
// Arm left = new Arm(new Vec2(600,0));
// Arm right = new Arm(new Vec2(640,0));
Human skeleton = new Human(new Vec2(150,200));

Pickable box = new Pickable(new Vec2(320,240), 50,50);
// Pickable box1 = new Pickable(new Vec2(420,340), 50,50);
void setup(){
  size(640,640);
  surface.setTitle("Inverse Kinematics [CSCI 5611 Example]");
//   left.picked = box;

}

void draw(){

    background(250,250,250);
    
//     left.update(1);
    box.update();
//     box1.update();
//     right.update(1);
    skeleton.drawHuman();
}

void mousePressed(){
    if(mouseButton == LEFT){
        // skeleton.moveTo(new Vec2(mouseX, mouseY));

        // right.moveTo(new Vec2(mouseX, mouseY));
        }
//     }else if(mouseButton == RIGHT){
//         skeleton.moveTo(new Vec2(mouseX, mouseY));
//     }
}
void keyPressed(){

}
float cross(Vec2 a, Vec2 b){
  return a.x*b.y - a.y*b.x;
}

float clamp(float f, float min, float max){
  if (f < min) return min;
  if (f > max) return max;
  return f;
}
