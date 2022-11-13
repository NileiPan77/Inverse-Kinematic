public class Human{
    Vec2 startPos;
    Arm leftHand;
    Arm rightHand;
    // Arm leftFoot;
    // Arm rightFoot;
    boolean leftHandBool = false;
    boolean rightHandBool = false;
    // Pickable box1;//left foot
    // Pickable box2;//right foot
    Vec2 bodyPos;
    public Human(Vec2 Pos){
        startPos = Pos;
        leftHand = new Arm(new Vec2(startPos.x,startPos.y));
        rightHand = new Arm(new Vec2(startPos.x+60,startPos.y));
        // leftFoot = new Arm(new Vec2(startPos.x,startPos.y+160));
        // rightFoot = new Arm(new Vec2(startPos.x+60,startPos.y+160));
        // box1 = new Vec2(startPos.x,startPos.y+160);
        // box2 = new Vec2(startPos.x+60,startPos.y+160);
        // box1 = new Pickable(new Vec2(startPos.x,startPos.y+200),50,50);
        // box2 = new Pickable(new Vec2(startPos.x+60,startPos.y+200),50,50);
        

    }
    void drawHuman(){
    
        fill(234,176,152);
        pushMatrix();
        translate(startPos.x+30,startPos.y-30);
        circle(0,0,60);
        // rect(0,0, 60, 160);
        popMatrix();

        pushMatrix();
        translate(startPos.x,startPos.y);
        rect(0,0, 60, 160);
        popMatrix();
        pushMatrix();
        translate(startPos.x+30,startPos.y+220);
        circle(0,0,120);
        // rect(0,0, 60, 160);
        popMatrix();

    
        // box2.update();
        // box1.update();
        // rightFoot.setBox(box2);
        // leftFoot.setBox(box1);
        if(box.pos.minus(rightHand.root).length()<rightHand.max_reach-10){
            rightHandBool = true;
        }
        if(box.pos.minus(leftHand.root).length()<leftHand.max_reach-10){
            leftHandBool = true;
        }
        if(rightHandBool &&leftHandBool){
            rightHand.setBox(box);

            leftHand.setBox(box);
            // rightHand.picked = box;
            // box.picker = rightHand;
            // box.picked = true;
            // rightFoot.update(1);

            // }else{
            // leftFoot.update(1);
            rightHand.update(1);
            leftHand.update(1);
        }else{
            // rightHand.setBox(box1);
            // leftHand.setBox(box2);
            // rightHand.setBox(box);

            // leftHand.setBox(box);
            rightHand.drawArm();
            leftHand.drawArm();
        }
        

        // }
    }
    public void setPos(Vec2 newpos){
        startPos = newpos;
        leftHand.root = newpos;
        leftHand.fk();
        leftHand.solveCCD(1,box.pos);
        rightHand.root = new Vec2(startPos.x+60,startPos.y);
        rightHand.fk();
        rightHand.solveCCD(1,box.pos);
        rightHand.setBox(box);

        leftHand.setBox(box);
        // leftHand = new Arm(new Vec2(startPos.x,startPos.y));
        // rightHand = new Arm(new Vec2(startPos.x+60,startPos.y));
        // leftHand.rerooted = true;
        // rightHand.rerooted = true;
    }
    // void moveTo(Vec2 target){
    //     if(rightFootBool){
    //         if(target.x!=0){
    //             box2 = new Pickable(new Vec2(target.x,target.y),50,50);
    //         }
            
    //         println(box2.pos);
    //         rightFootBool = false;
    //         leftFootBool = true;
    //         // box2.pos.x=box2.pos.x+target.x;
    //         println(box2.pos.x);
    //         rightFoot.setBox(box2);
    //         leftFoot.setBox(box1);
    //         rightFoot.moveTo(target);
    //         // leftFoot.moveTo(target);
    //         leftFoot = new Arm(new Vec2(rightFoot.root.x+60,rightFoot.root.y));
    //         rightFoot = new Arm(new Vec2(leftFoot.root.x-60,leftFoot.root.y));
    //         leftFoot.setBox(box2);
    //         rightFoot.setBox(box1);
    //         startPos.x=startPos.x+60;

            
            
    //         // rightFoot.moveTo(target);
    //         // leftFoot.moveTo(leftFoot.root);
    //     }else{
    //         if(target.x!=0){
    //         box1 = new Pickable(new Vec2(target.x,target.y),50,50);
    //         }

    //         rightFootBool = true;
    //         leftFootBool = false;
    //         // box1.pos.x=box1.pos.x+target.x;
    //         rightFoot.setBox(box2);
    //         leftFoot.setBox(box1);
    //         // leftFoot.moveTo(target);
    //         // leftFoot.moveTo(target);
    //         // rightFoot.moveTo(rightFoot.root);
    //     }
        // drawHuman();
    // }

}
