//Currently houses audio files

import beads.*;
import java.util.Arrays; 

color fore = color(255, 59, 59); //change the colour to be a red
color back = color(0, 0, 0); //change the background to be black 

String audioFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/InteractiveMedia_Individual_Project/Audio Files/New Recording 3.mp3";
//String audioFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/InteractiveMedia_Individual_Project/Audio Files/24096__acclivity__henry5.mp3";
String environmentFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/InteractiveMedia_Individual_Project/Audio Files/128291__garyq__cafeteria.mp3";
String musicFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/InteractiveMedia_Individual_Project/Audio Files/378665__frankum__red-hard-lead-techno-house.mp3";

GranularSamplePlayer player;
AudioContext ac;
Gain g = new Gain(2, 1);
Envelope rate = new Envelope(1);


void setup() {
  try{
  player = new GranularSamplePlayer(SampleManager.sample(musicFile));
  }
  catch(Exception e){
    println(e);
  }
  ac = AudioContext.getDefaultContext();
  g.addInput(player);
  ac.out.addInput(g);
  ac.start();
}

void draw() {
  loadPixels();
  //set the background
  Arrays.fill(pixels, back);
  //scan across the pixels
  for(int i = 0; i < width; i++) {
    //for each pixel work out where in the current audio buffer we are
    int buffIndex = i * ac.getBufferSize() / width;
    //then work out the pixel height of the audio data at that point
    int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) * height / 2);
    //draw into Processing's convenient 1-D array of pixels
    vOffset = min(vOffset, height);
    pixels[vOffset * width + i] = fore;
  }
  updatePixels();
  
  if(key == 'p') {
    changePitch();
  }
  
}

void changePitch() { //play around the with distortion to sound less grating? Maybe a seperate file loaded in
  rate = new Envelope(ac, 4);
  rate.addSegment(1, 5);
  //rate.addSegment(2, 0.5, -90);
  player.setPitchEnvelope(rate);
}
