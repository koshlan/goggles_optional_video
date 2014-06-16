// June 15, 2015 // Remake the Code in more resusable form (Next time need to learn how to bring in polygons from illustrator so that you don't have to code every shape)
import ddf.minim.*;
AudioPlayer player;
Minim minim;//audio context

// Frame Size Should Be Some Multiple of HD (1920  1080) Same Resolution 
// This specify the frame size all other locations should be based on frame_width, frame_height so that everything can be scaled when necessary by simply changing HDfactor
int HDfactor = 3;
int frame_width = 1920/HDfactor;
int frame_height = 1080/HDfactor;

// Say 60 fps , this is the default but we might want to change it for video. All timing should be based on multiples of fps so if we have to change this later we can easily.
int fps = 60;
int duration = 10;
int total_frames = fps*10;

// Color Pallete
// All Colors Should Be Specified Here.
int background_color = 220; // background
int white_color = 250; // white color (i.e. eye balls)
int black_color = 000; // black color (i.e. pupils)
int mycolor_i = 0; // This is a iterable color position which can be ramped up

// Later on various counters are requiured that are initialized now.
int count_frame = 0; // simple integer count to count each frame
float rotation_count = 1;  // simple count use to 
float fly_count = 1; // count used to move object 
float theta = 0;

// Sound Control // For Now Sounds Are Enabled with (1), as soon as they are played they are changed to 0 so that they are only played once within the draw()
int sound_1 = 1;
int sound_2 = 1;
int sound_3 = 1;

// Animation Control //
// Right Eye Animation Move (x-axis only)
float start_point = ((frame_width/2)-(frame_width/8)/2.3);//((frame_width/2)-(frame_width/8)/2.3);
float final_point_x = ((frame_width/2)+(frame_width/8)/2.3);
float current_point_x =(frame_width/2)-(frame_width/8)/2.3;
float acceleration = .00001;

// Constant Shapes Defined As Functions
void display_microphone() {
  fill(black_color);
  rectMode(CENTER);
  rect((frame_width/2), 1.5*(frame_width/8), 1.75*(frame_width/8), 2.25*(frame_width/8),(frame_width/5)); // Microphone
}

void display_left_eye(float theta){
  // theta is the angle of rotation for the inner rectangle 
  // Eye + Pupil + Rectangle 
  fill(white_color);
  ellipse((frame_width/2)-(frame_width/8)/2.3, (frame_width/8), (frame_width/8), (frame_width/8)); // Eye
  fill(black_color);
  ellipse((frame_width/2)-(frame_width/8)/2.3, (frame_width/8), (frame_width/8)/1.5, (frame_width/8)/1.5); //Pupil
  fill(white_color);
  translate((frame_width/2)-((frame_width/8)/2.3),(frame_width/8)-((frame_width/8)/12)+5);
  rectMode(CORNER);
  rotate(theta); //theta = count-13*PI/12
  rect(0,-(frame_width/128),(frame_width/8)/2.5,(frame_width/8)/6); // Rectangle 
  //translate(-1*((frame_width/2)-((frame_width/8)/2.3)),-1*((frame_width/8)-((frame_width/8)/12)+5));
  //rotate(-1*theta);
}

void display_right_eye(){
  translate(0,0);
  rotate(0);
  fill(white_color);
  ellipse((frame_width/2)+(frame_width/8)/2.3, (frame_width/8), (frame_width/8), (frame_width/8)); // Eye
  fill(black_color);
  ellipse((frame_width/2)+(frame_width/8)/2.3, (frame_width/8), (frame_width/8)/1.5, (frame_width/8)/1.5); //Pupil
}

void display_movable_right_eye(float x_pos){
  translate(0,0);
  rotate(0);
  fill(white_color);
  ellipse(x_pos, (frame_width/8), (frame_width/8), (frame_width/8)); // Eye
  fill(black_color);
  ellipse(x_pos, (frame_width/8), (frame_width/8)/1.5, (frame_width/8)/1.5); //Pupil
}

void display_green_pupil(int my_color){
  translate(0,0);
  rotate(0);
  fill(0,my_color,80);
  ellipse((frame_width/2)+(frame_width/8)/2.3, (frame_width/8), (frame_width/8)/1.5, (frame_width/8)/1.5);
  fill(black_color);
  ellipse((frame_width/2)+(frame_width/8)/2.3, (frame_width/8), (frame_width/8)/2.5, (frame_width/8)/2.5);
}



// Setup
void setup(){
  frameRate(fps); // set fps
  size(frame_width,frame_height); // set dimensions
  noStroke(); // set stroke preference
}



// OVERALL CONTROL STRUCTURE IS A SERIES OF IF Statements that move forward in time.
// Part 1 Static Starting Point 
// Part 2 Slow Wind
// Part 3 Click
//count_frame = count_frame + 1;
//  if (count_frame < fps*1){
//  }else if (count_frame < fps*1){
//  }else if (count_frame < fps* 2{
//  }

void draw(){
  count_frame = count_frame + 1;
  // LAUNCH SOUND 1 
  if (sound_1 == 1){
    minim = new Minim(this);
    player = minim.loadFile("polaroid-camera-film-cartridge-load-01.mp3", 2048);
    player.play();
    sound_1 = 0;
  }
  
  if (count_frame < fps*2){
    background(background_color);
    //fill(black_color);
    display_microphone();
    theta = rotation_count-13*PI/12;
    display_left_eye(theta);
  }else if (count_frame < fps*4){
    rotation_count = rotation_count + .01;
    background(background_color);
    display_microphone();
    theta = rotation_count-13*PI/12;
    display_left_eye(theta);
  }else if (count_frame < fps*5){
    rotation_count = rotation_count + .01;  
    if (sound_2 == 1){
      minim = new Minim(this);
      player = minim.loadFile("camera-winding-lever-03.mp3", 2048);
      player.play();
      sound_2 = 0;
    }
    
    background(background_color);
    display_microphone();
    
    /// THIS BLOCK HANDLES ACCELERATING MOTION BUT SHOULD BE BUILT INTO ITS OWN MODULE OUTSIDE THE ANIMATION IN LATER VERSION
    acceleration = 1.4 * acceleration;
    if (current_point_x + .5 < final_point_x ){
        if (current_point_x + acceleration < final_point_x ){
          current_point_x = current_point_x + .5 + acceleration;
        } else if (current_point_x + .5 < final_point_x ){
          current_point_x = current_point_x + .5 ;
        } else {
          current_point_x = final_point_x ;
        }
      }
    
    display_movable_right_eye(current_point_x);
    theta = rotation_count-13*PI/12;
    display_left_eye(theta); 
   
  }else if (count_frame < fps*20){
    if (sound_3 == 1){
       minim = new Minim(this);
       player = minim.loadFile("Old-Film_Projector.mp3", 2048);
       //player = minim.loadFile("arrested.mp3", 2048);
       player.play();
       sound_3 = 0;
    }
    background(background_color);
    display_microphone();
    display_movable_right_eye(current_point_x);
    display_green_pupil(mycolor_i);
    textSize(32);
    fill(black_color);
    textAlign(CENTER, BOTTOM);
    text("Goggles Optional", (frame_width/2), frame_height-(frame_height/8));
    fill(0,mycolor_i,80);
    textSize(20);
    textAlign(CENTER, BOTTOM);
    text("video",  frame_width/2, frame_height - (frame_height/16));
    
    
    theta = 0; //rotation_count-13*PI/12;
    display_left_eye(theta); 
    // COLOR LOOP
   
    if (mycolor_i < 140){
      mycolor_i = mycolor_i + 3;
      
    } else if (mycolor_i == 140){
      mycolor_i = mycolor_i - int(10*random(-2,10));   
    } else if (mycolor_i > 140){
      mycolor_i = mycolor_i - 1;
    }
    
    
  }  
}  
  

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
