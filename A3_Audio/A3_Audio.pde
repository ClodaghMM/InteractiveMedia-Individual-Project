//minim class and features
//beads class and resources

//need to achieve the following steps. 
//get audio in
//record it
//output it. 

import ddf.minim.*;
import ddf.minim.ugens.*;

//VARIABLES
AudioInput in;
AudioRecorder r;
boolean recorded;
Minim minim;
FilePlayer fp;

void setup() {
  //set up the recording functionality. 
  
  size(512, 200);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  r = minim.createRecorder(in, "userInput.mp3");
  
  textFont(createFont("Arial", 12));
}

void draw() {
  background(0);
  
  if(r.isRecording()) {
    text("Now recording, press the r key to stop recording.", 5, 15);
  }
  
  if(!recorded)
  {
    text("Press r key to start recording.", 5, 15);
  }
  
   else if ( fp == null )
  {
    text("Press the s key to save the recording to disk and play it back in the sketch.", 5, 15);
  }
}


void keyReleased() {
    if ( !r && key == 'r' ) 
  {
    if ( r.isRecording() ) 
    {
      r.endRecord();
      r = true;
    }
    else 
    {
      recorder.beginRecord();
    }
  }
  if ( fp == null && recorded && key == 's' )
  {
    fp = new FilePlayer( r.save() );
}
}
