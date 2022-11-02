//LIBRARIES
import beads.*;
import java.util.*;

//VARIABLES
RecordToSample recordToSample;
AudioContext ac;
Gain g = new Gain(1, 2);
SamplePlayer player;
Boolean recorded;
Boolean manipulate = false;
String audio;
float rotate = 0;
ArrayList<String> inputs = new ArrayList<String>();
Hashtable<String, String> envelopeVals = new Hashtable<>();

String userInput;
String envelopeInput; 

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
  
  //if(manipulate == true) {
  //  synthesiser();
  //}
   
  if(recorded == true && manipulate == true & key == 'p')
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
    manipulate = true;
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  
  if(manipulate = true) 
  {
    synthesiser();
  }
}

//void play() {
//  audio = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/A3_Audio/test.wav";
//  player = new SamplePlayer(SampleManager.sample(audio));
//  ac.out.addInput(g);
//  g.addInput(player);
//}

void synthesiser() {
  background(255);
  text("How would you like to modfify the sound?", 5, 15); 
  text("Following options are: (Press e to continue)", 5, 25);
  text("r for rate", 5, 35);
  
  if(key == 's') {
    userInput = "s";
      inputs.add(userInput);
      text("How do you want to modify the rate?", 5, 45);
  }
   if(key == 'm' & userInput == "s") {
     text("Medium value for rate", 5, 55);
      envelopeInput = "m";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
    }
   if (key == 'g') {
    println("manipulating audio");
    audioManipulation(inputs,envelopeVals);
  }   
}

//void createSphere() {
//  rotate(rotate*0.02);
//  translate(width/2, height/2);
//  //noStroke();
//  sphere(175);
//  rotate++;
//}
