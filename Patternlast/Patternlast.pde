/**
 * Patterns. 
 * 
 * Move the cursor over the image to draw with a software tool 
 * which responds to the speed of the mouse. 
 */
 int r = 250; int g = 250; int b = 0;
 char col;
 int gg = 0;
 boolean up = true, down = true;
float inc = 0, op = 100;
int enX, enX2;
boolean breakLine = true;

 
 
void setup()
{
  size(940, 760);
  //fullScreen();
  smooth();
  background(0);
}

void keyPressed(){
  col = key;
}


void draw() 
{

colorEllipse(mouseX, mouseY, pmouseX, pmouseY, col );
}



void colorEllipse(int x, int y, int px, int py, char variable) {
  if(gg >= 0 && up == true && down== false){
            gg += 8;
    }else if(gg <= 248 && up== false && down == true){
            gg -= 8;
    }if(gg==0){
      up= true;
      down = false;
    }else if(gg==248){
      up = false;
      down = true;
    }
    
    if(r > 0 && g == 250 ){
          b+=10;
          r -= 10;
        }else if(g > 0 && b== 250){
          r+= 10;
          g -= 10;
        }else if(b > 0 && r== 250){
          g += 10;
          b -= 10;
       }
  
  //color parameter
  if ((variable == 'a') || (variable == 'A') ){
    ////CHANGE B/N
    ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill (gg, gg, gg);
      ellipse(x, y, speed1, speed1);
  
  }else if((variable == 'b') || (variable == 'B') ){
    ////CHANGE BLUE
    ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill (gg, 255, 255);
      ellipse(x, y, speed1, speed1);
  
  }else if((variable == 'r') || (variable == 'R') ){
   ////CHANGE RED
   ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill (255, gg, 255);
      ellipse(x, y, speed1, speed1);
  
  }else if((variable == 'd') || (variable == 'D') ){
   ////DELETE
   ///

      fill (0,0, 0);
      ellipse(width/2, height/2, width*2, height*2);
  
  }else if((variable == 'y') || (variable == 'Y') ){
    ////chage YELLOW
    ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill (255, 255, gg);
      ellipse(x, y, speed1, speed1);
  
  }else if((variable == 'g') || (variable == 'G') ){
    ///GREEN
    ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill (175, 255, gg);
      ellipse(x, y, speed1, speed1);
  
  }else if((variable == 'z') || (variable == 'Z') ){
    //boolean on = true, off = false;
    
    ///DROPUP CIRCLE-LINES
    ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill(r, g, b);
      ellipse(x, y, speed1, speed1);
      
      for(int wr =0; wr < height*2; wr++){
           ellipse(x, y++, speed1, speed1);
      }
  }else if((variable == 'x') || (variable == 'X') ){

    
    ///DROPDOWN CIRCLE-LINES
    ///
      float speed1 = abs(x-px) + abs(y-py);
      noStroke();
      fill (r, g, b);
      ellipse(x, y, speed1, speed1);
      
      for(int wr =0; wr < height; wr++){
           ellipse(x, y -= 1, speed1, speed1);
      }
  }else if ((variable == 'q') || (variable == 'Q')){
    ////BACK TO DEFAULT
    ///      
      float speed = abs(x-px) + abs(y-py);
      noStroke();
      fill(r, g, b);
      ellipse(x, y, speed, speed);
      
  
  }else if ((variable == 's') || (variable == 'S')){
    ////BREAK LINE
    ///      
    breakLine = true;
      enX = mouseX;
      enX2 = mouseX;

        fill(r,g,b, op);
        rect(enX + inc, 0, inc, height);
        rect(enX - inc*2, 0, inc, height);
        
        fill(0,0,0);
        rect(enX2 + inc/100, 0, inc/100, height);
        rect(enX2-inc/50, 0, inc/100, height);
        inc += 5.2;
        op -= 0.5;
        
      if(op== 0.0){
        op = 100.0;
        inc = 0;
 
      }

      
  
  }else{
      ////DEFAULT DEFAULT
      
      float speed = abs(x-px) + abs(y-py);
      noStroke();
      fill (r, g, b);
      ellipse(x, y, speed, speed);
  
  }
}