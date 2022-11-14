public class MultiArm{
    Arm left;
    Arm right;
    Vec2 root;
    int rootLen;
    public MultiArm(Vec2 r, int len){
        root = r;
        rootLen = len;
        left = new Arm(new Vec2(r.x,r.y),-1.0,1.3);
        left.palm_limit_floor = -4.71239;
        left.palm_limit_ceil = -1.5708;
        left.upper_arm_limit_floor = -3.14159;
        left.upper_arm_limit_ceil = -1.5708;
        right = new Arm(new Vec2(r.x,r.y),01.0,-0.3);
        
        right.upper_arm_limit_floor = -1.5708;
        right.upper_arm_limit_ceil = 1.5708;
        right.palm_limit_floor = -1.5708;
        right.palm_limit_ceil = 1.5708;
    }
    
    public void update(float dt){
        left.updateNoreroot(dt,new Vec2(mouseX,mouseY));
        right.updateNoreroot(dt,new Vec2(mouseX,mouseY));
    }
    
    public void drawMult(){
       left.drawArm();
       right.drawArm();
       rect(root.x-10,root.y,20,rootLen);
    }
}
