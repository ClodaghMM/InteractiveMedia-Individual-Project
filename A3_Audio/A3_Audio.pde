//LIBRARIES
import beads.*;


//VARIABLES
RecordToSample recordToSample;
AudioContext ac;
Gain g = new Gain(1, 2);
SamplePlayer player;
Boolean recorded;
String audio;
float rotate = 0;
char[] inputs;


void setup() {
  
  //setting up the UI
  size(500, 800);
  background(255);
  textFont(createFont("Arial", 12));
  fill(#080707);
  
  //setting up beads recording. Using Kurt's code from Teams  
  ac = AudioContext.getDefaultContext();
  Sample outputSample = new Sample(5000); //sample to store in memory
  recordToSample = new RecordToSample(outputSample, RecordToSample.Mode.FINITE);
  recordToSample.addInput(ac.getAudioInput());
  ac.out.addDependent(recordToSample);
  recorded = false;
}

void draw() {
   
  if(!recorded)
    {
    text("Press r key to start recording.", 5, 15);
    }
    
  if(recorded == false && key == 'r')
  {
    text("Now recording, click on the mouse to stop recording.", 5, 25);
    ac.start();
  }
  
  if(recorded == true & key == 'p')
  {
   ac.start();
  } 
}

void mousePressed() {
  recordToSample.clip();//stop recording
  try {//write to sketch path
    recordToSample.getSample().write(sketchPath("test.wav"), AudioFileType.WAV);
    text("Recording Saved.", 5, 35);
    recorded = true;
    ac.stop();
    
    synthesiser();
    //play();
    
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

void play() {
  audio = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/A3_Audio/test.wav";
  player = new SamplePlayer(SampleManager.sample(audio));
  ac.out.addInput(g);
  g.addInput(player);
}

void synthesiser() {
  background(255);
  text("How would you like to modfify the sound?", 5, 15); 
  if(key == 's')
  {
    inputs.add('s');
  }
  
  //ask user for input and store in array.
  //what keys do we want to use? 
  // = rate
  // pitch
  //overlap with frequency
  //cochlear mode - defaults to a bunch of keys
}

//void createSphere() {
//  rotate(rotate*0.02);
//  translate(width/2, height/2);
//  //noStroke();
//  sphere(175);
//  rotate++;
//}
