public class Arm{
    //Root
    Vec2 root;

    //Upper Arm
    float upper_arm_length; 
    float upper_arm_width;
    float upper_arm_angle; //Shoulder joint
    Vec2 elbow;

    //Lower Arm
    float lower_arm_length;
    float lower_arm_width;
    float lower_arm_angle; //Elbow joint
    Vec2 wrist;

    //Hand
    float palm_length;
    float palm_width;
    float palm_angle; //Wrist joint
    Vec2 finger_joint;

    //finger
    float finger_length;
    float finger_width;
    float finger_angle; //finger joint
    Vec2 finger_tip;
    
    boolean rerooted;
    float max_reach;
    
    Vec2 picking_part;
    Pickable picked;
    boolean carrying;

    Vec2 target;
    boolean targetSet;
    Pickable box;
    public Arm(Vec2 r){
        root = r;
        upper_arm_length = 100;
        upper_arm_width = 20;
        upper_arm_angle = 0.3;

        lower_arm_length = 80;
        lower_arm_width = 20;
        lower_arm_angle = 0.3;

        palm_length = 50;
        palm_width = 20;
        palm_angle = 0.3;

        finger_length = 40;
        finger_width = 10;
        finger_angle = 0.3;
        
        max_reach = upper_arm_length + lower_arm_length + palm_length + finger_length;
        
        targetSet = false;

        carrying = false;
        rerooted = false;
        fk();
    }
    
    public void fk(){
        elbow = new Vec2(cos(upper_arm_angle)*upper_arm_length,sin(upper_arm_angle)*upper_arm_length).plus(root);
        wrist = new Vec2(cos(upper_arm_angle+lower_arm_angle)*lower_arm_length,sin(upper_arm_angle+lower_arm_angle)*lower_arm_length).plus(elbow);
        finger_joint = new Vec2(cos(upper_arm_angle+lower_arm_angle+palm_angle)*palm_length,sin(upper_arm_angle+lower_arm_angle+palm_angle)*palm_length).plus(wrist);
        finger_tip = new Vec2(cos(upper_arm_angle+lower_arm_angle+palm_angle+finger_angle)*palm_length,sin(upper_arm_angle+lower_arm_angle+palm_angle+finger_angle)*palm_length).plus(finger_joint);
    }
    
    public void reroot(){
        println("re rooted");
        rerooted = !rerooted;
        float old_finger = finger_angle;
        float old_palm = palm_angle;
        float old_lower = lower_arm_angle;
        float old_upper = upper_arm_angle;

        Vec2 temp = new Vec2(root.x,root.y);
        root = finger_tip;
        finger_tip = root;

        temp = new Vec2(elbow.x,elbow.y);
        elbow = finger_joint;
        finger_joint = temp;
        float len_temp = upper_arm_length;
        float width_temp = upper_arm_width;
        
        

        upper_arm_length = finger_length;
        upper_arm_width = finger_width;
        upper_arm_angle = old_finger + old_palm + old_lower + old_upper - (float)Math.PI;
        //upper_arm_angle %= 2*(float)Math.PI;
        finger_length = len_temp;
        finger_width = width_temp;

        len_temp = lower_arm_length;
        width_temp = lower_arm_width;

        lower_arm_length = palm_length;
        lower_arm_width = palm_width;
        lower_arm_angle = -old_finger;

        //lower_arm_angle %= 2*(float)Math.PI;
        palm_length = len_temp;
        palm_width = width_temp;
        palm_angle = -old_palm;
       // palm_angle %= 2*(float)Math.PI;
        
        finger_angle = -old_lower;
        //finger_angle %= 2*(float)Math.PI;
        upper_arm_angle %= 2*(float)Math.PI;
        lower_arm_angle %= 2*(float)Math.PI;
        palm_angle %= 2*(float)Math.PI;
        finger_angle %= 2*(float)Math.PI;
    }
    public void solveCCD(float dt, Vec2 goal){
        
        float radCap = 0.75 * (float)Math.PI/180.0;
        
        
        Vec2 startToGoal, startToEndEffector;
        float dotProd, angleDiff;
        
         //Update finger joint
        startToGoal = goal.minus(finger_joint);
        startToEndEffector = finger_tip.minus(finger_joint);
        dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
        dotProd = clamp(dotProd,-1,1);
        angleDiff = acos(dotProd);
        
        // cap change of angle to 30
        if(angleDiff > radCap){
             angleDiff = radCap; 
        }else if(angleDiff < -radCap){
             angleDiff = -radCap;
        }
          
        if (cross(startToGoal,startToEndEffector) < 0)
            finger_angle += angleDiff * dt;
        else
            finger_angle -= angleDiff * dt;
        /*TODO: finger joint limits here*/
        fk(); //Update link positions with fk (e.g. end effector changed)

        
        //Update wrist joint
        startToGoal = goal.minus(wrist);
        startToEndEffector = finger_tip.minus(wrist);
        dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
        dotProd = clamp(dotProd,-1,1);
        angleDiff = acos(dotProd);
        
        // cap change of angle to 30
        if(angleDiff > radCap){
             angleDiff = radCap; 
        }else if(angleDiff < -radCap){
             angleDiff = -radCap;
        }
        if (cross(startToGoal,startToEndEffector) < 0)
            palm_angle += angleDiff * dt;
        else
            palm_angle -= angleDiff * dt;
            
        // /*TODO: Wrist joint limits here*/
        // if(palm_angle > 1.5708){
        //     palm_angle = 1.5708; 
        // }else if(palm_angle < -1.5708){
        //     palm_angle = -1.5708;
        // }
        fk(); //Update link positions with fk (e.g. end effector changed)
        
        
        
        //Update elbow joint
        startToGoal = goal.minus(elbow);
        startToEndEffector = finger_tip.minus(elbow);
        dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
        dotProd = clamp(dotProd,-1,1);
        angleDiff = acos(dotProd);
        
        // cap change of angle to 30
        if(angleDiff > radCap){
             angleDiff = radCap; 
        }else if(angleDiff < -radCap){
             angleDiff = -radCap;
        }
        if (cross(startToGoal,startToEndEffector) < 0)
            lower_arm_angle += angleDiff * dt;
        else
            lower_arm_angle -= angleDiff * dt;
        fk(); //Update link positions with fk (e.g. end effector changed)
        
        
        //Update shoulder joint
        startToGoal = goal.minus(root);
        if (startToGoal.length() < .0001) return;
        startToEndEffector = finger_tip.minus(root);
        dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
        dotProd = clamp(dotProd,-1,1);
        angleDiff = acos(dotProd);
        
        // cap change of angle to 30
        if(angleDiff > radCap){
             angleDiff = radCap; 
        }else if(angleDiff < -radCap){
             angleDiff = -radCap;
        }
        if (cross(startToGoal,startToEndEffector) < 0)
            upper_arm_angle += angleDiff * dt;
        else
            upper_arm_angle -= angleDiff * dt;
        /*TODO: Shoulder joint limits here*/
        if(upper_arm_angle > 1.5708){
            upper_arm_angle = 1.5708; 
        }
        if(upper_arm_angle < 0){
            upper_arm_angle = 0; 
        }
        fk(); //Update link positions with fk (e.g. end effector changed)
        float rtod = 180.0/(float)Math.PI;
        
        println(angleDiff);
        println("Angle 0:",upper_arm_angle * rtod,"Angle 1:",lower_arm_angle * rtod,"Angle 2:",palm_angle * rtod, "Angle 3:",finger_angle * rtod);
    }
    
    public void moveTo(Vec2 goal){
        target = new Vec2(goal.x,goal.y);
        targetSet = true;
    }
    
    public void drawArm(){
        fill(234,176,152);
        pushMatrix();
        translate(root.x,root.y);
        rotate(upper_arm_angle);
        rect(0, -upper_arm_width/2, upper_arm_length, upper_arm_width);
        popMatrix();
        
        pushMatrix();
        translate(elbow.x,elbow.y);
        rotate(upper_arm_angle+lower_arm_angle);
        rect(0, -lower_arm_width/2, lower_arm_length, lower_arm_width);
        popMatrix();
        
        pushMatrix();
        translate(wrist.x,wrist.y);
        rotate(upper_arm_angle+lower_arm_angle+palm_angle);
        rect(0, -palm_width/2, palm_length, palm_width);
        popMatrix();

        pushMatrix();
        translate(finger_joint.x,finger_joint.y);
        rotate(upper_arm_angle+lower_arm_angle+palm_angle+finger_angle);
        rect(0, -finger_width/2, finger_length, finger_width);
        popMatrix();
    }
    public void setBox(Pickable b){
        box = b;
    }
    
    public void update(float dt){
        if(carrying == false){
            println(box.pos.x);
            Vec2 rootToBox = box.pos.minus(root);
            if(box.pointInBox(finger_tip) == true){
                carrying = true;
                box.picker = this;
                box.picked = true;
                rerooted = true;
                box.rerootRecord = rerooted;
            }
            else if(rootToBox.length() < max_reach){
                fk();
                solveCCD(dt,box.pos);
            }else{
                fk();
                solveCCD(dt,box.pos);
                
                Vec2 rootToTip = finger_tip.minus(root).normalized();
                if(dot(rootToBox.normalized(),rootToTip) > 0.95){
                    reroot();
                }
              
            }
        }
        else if(targetSet == true){
            Vec2 rootToGoal = target.minus(root);
            Vec2 boxToGoal = target.minus(box.pos);
            Vec2 fingerToGoal = target.minus(finger_tip);
            if(rootToGoal.length() < max_reach){
                println("length: ", fingerToGoal.length());
                println("box to goal: ", boxToGoal.length());
                if(carrying && fingerToGoal.length() < boxToGoal.length()){
                    reroot();
                    fk();
                    solveCCD(dt,target);
                }else{
                    fk();
                    solveCCD(dt,target);
                }
                
            }else{
                fk();
                solveCCD(dt,target);
                
                Vec2 rootToTip = finger_tip.minus(root).normalized();
                if(dot(rootToGoal.normalized(),rootToTip) > 0.95){
                    reroot();
                }
            }
            
            //reroot();
        }
        drawArm();
    }
}
