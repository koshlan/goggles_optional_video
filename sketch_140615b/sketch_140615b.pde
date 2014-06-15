import ddf.minim.*;
AudioPlayer player;
Minim minim;//audio context

// Frame Size Should Be Some Multiple of HD (1920  1080) Same Resolution 
int HDfactor = 3;
int frame_width = 1920/HDfactor;
int frame_height = 1080/HDfactor;
// Lets Consider The Length of the Animation
// Say 60 fps , this is the default but we might want to change it for video
int fps = 60;
int duration = 10;
int total_frames = fps*10;
int count_frame = 0;


// Color Pallete
// background
int background_color = 220;
int white_color = 250;
int black_color = 000;
int mycolor_i = 0;
void setup(){
  frameRate(fps);
  size(frame_width,frame_height);
  noStroke();
}

float count = 1;
float fly_count = 1;

// Right Eye Animation Move
float start_point = (320-(72/2.3));
float final_point = (320+(72/2.3));
float current_point_x =(320-(72/2.3));
float acceleration = .00001;
// Part 1 Static Starting Point 
// Part 2 Slow Wind
// Part 3 Click
//count_frame = count_frame + 1;
//  if (count_frame < fps*1){
//  }else if (count_frame < fps*1){
//  }else if (count_frame < fps* 2{
//  }

int sound_1 = 1;
int sound_2 = 1;
int sound_3 = 1;

void draw(){
  count_frame = count_frame + 1;
  if (sound_1 == 1){
    minim = new Minim(this);
    player = minim.loadFile("polaroid-camera-film-cartridge-load-01.mp3", 2048);
    player.play();
    sound_1 = 0;
  }
  if (count_frame < fps*2){
    background(background_color);
    fill(black_color);
    rectMode(CORNER);
    rect(320-72, 72/2.5, 2*72, 2.5*72,125); // Microphone
    fill(white_color);
    ellipse(320-72/2.3, 72, 82, 82); // Eye
    fill(black_color);
    ellipse(320-72/2.3, 72, 72/1.5, 72/1.5); // Pupil
    //rotate(count);
    fill(white_color);
    translate(320-(72/2.3),72-(72/12)+5);
    rotate(count-13*PI/12);
    rect(0,-5,72/2.5,72/6); // Rectangle 
  }else if (count_frame < fps*4){
    count = count + .01;
    background(background_color);
    fill(black_color);
    rectMode(CORNER);
    rect(320-72, 72/2.5, 2*72, 2.5*72,125); // Microphone
    fill(white_color);
    ellipse(320-72/2.3, 72, 82, 82); // Eye
    fill(black_color);
    ellipse(320-72/2.3, 72, 72/1.5, 72/1.5); // Pupil
    //rotate(count);
    fill(white_color);
    translate(320-(72/2.3),72-(72/12)+5);
    rotate(count-13*PI/12);
    rect(0,-5,72/2.5,72/6); // Rectangle 
  }else if (count_frame < fps*5){
    count = count + .01;
    if (sound_2 == 1){
    minim = new Minim(this);
    player = minim.loadFile("camera-winding-lever-03.mp3", 2048);
    player.play();
    sound_2 = 0;
  }
    background(background_color);
    fill(black_color);
    rectMode(CORNER);
    rect(320-72, 72/2.5, 2*72, 2.5*72,125); // Microphone
    acceleration = 1.3 * acceleration;
    if (current_point_x + .5 < final_point){
        if (current_point_x + acceleration < final_point){
          current_point_x = current_point_x + .5 + acceleration;
        } else if (current_point_x + .5 < final_point){
          current_point_x = current_point_x + .5 ;
        } else {
          current_point_x = final_point;
      }
    }
    print(current_point_x);
    fill(white_color);
    ellipse(current_point_x, 72, 82, 82); // Eye Left// Eye Right
    fill(black_color);
    ellipse(current_point_x, 72, 72/1.5, 72/1.5); // Pupil Right
    fill(white_color);
    ellipse(320-72/2.3, 72, 82, 82); // Eye Left
    fill(black_color);
    ellipse(320-72/2.3, 72, 72/1.5, 72/1.5); // Pupil Left
    fill(white_color);
    translate(320-(72/2.3),72-(72/12)+5);
    rotate(count-13*PI/12);
    rect(0,-5,72/2.5,72/6); // Rectangle 
   }else if (count_frame < fps*8){
     if (sound_3 == 1){
       minim = new Minim(this);
       player = minim.loadFile("arrested.mp3", 2048);
       player.play();
       sound_3 = 0;
     }
    background(background_color);
    fill(black_color);
    rect(320-72, 72/2.5, 2*72, 2.5*72,125);
    
    
    // Microphone stand
  //  noFill();
  //  stroke(0);
  //  arc(320, 140,72*2.3, 72.*2.3, 0, PI);
  //  arc(320, 145,72*2.4, 72.*2.4, 0, PI);
    
    noStroke();
    fill(white_color);
    ellipse(320-72/2.3, 72, 82, 82);
    ellipse(320+72/2.3, 72, 82, 82);
    // Green Eye
    fill(0,mycolor_i,80);
    if (mycolor_i < 140){
      mycolor_i = mycolor_i + 3;
    }
    ellipse(320+72/2.3, 72, 72/1.5, 72/1.5);
    // Pupil
    fill(black_color);
    ellipse(320+72/2.3, 72, 72/2.8, 72/2.8);
    ellipse(320-72/2.3, 72, 72/1.5, 72/1.5);
    
    fill(white_color);
    rect(320-(72/2.5),72-(72/12),72/2.5,72/6);
    
    textSize(32);
    fill(black_color);
    textAlign(CENTER, BOTTOM);
    text("Goggles Optional", frame_width/2, frame_height-(frame_height/8));
    
    fill(0,mycolor_i,80);
    textSize(20);
    textAlign(CENTER, BOTTOM);
    text("video",  frame_width/2, frame_height - (frame_height/16));
  }
    
    
    
    
}  

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
