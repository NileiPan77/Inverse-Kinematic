public class Pickable{
     Vec2 pos;
     float w;
     float h;
     boolean rerootRecord;
     boolean picked;
     Arm picker;

     public Pickable(Vec2 p, float w1, float h1){
         pos = new Vec2(p.x,p.y);
         w = w1;
         h = h1;

     }
     boolean pointInBox(Vec2 pointPos){
         if(pos.x < pointPos.x && pointPos.x < pos.x+w &&
            pos.y < pointPos.y && pointPos.y < pos.y + h){
               return true;
         }
         return false;
    }
     public void update(){
         if(picked){

                if(picker.rerooted == true){
                    pos = picker.finger_tip;
                }else{
                    pos = picker.root; 
                }
               
         }
        image(chest,pos.x-20, pos.y-20,70,70);
        //rect(pos.x,pos.y,w,h);
     }
}
