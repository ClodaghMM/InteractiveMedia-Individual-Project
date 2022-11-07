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
Boolean play;
Boolean pitchModified = false;
Boolean rateModified = false;
char prevKey;
Boolean recordedStart = false;
Boolean start = false;
Boolean displayChoice = false;

color sphereColor;
color prevColor;
String state;


String audio;
float n = cos(frameCount*0.01)*300;
ArrayList<String> inputs = new ArrayList<String>();
Hashtable<String, String> envelopeVals = new Hashtable<>();
Hashtable<String, String> envelopeKeys = new Hashtable<>();


String userInput;
String envelopeInput; 

//Variables for FFT for the signal
color fore = color(255, 102, 204);
color back = color(0,0,0);

//Visual inputs

void setup() {
  
  //setting up the UI
  sphereColor = #DE9A9A;
  prevColor = #080707;
  size(500, 800, P3D);
  
  background(#080101);
  fill(#4D4848);
  rect(0, 0, width, height);
  circle(width/2, 15, 25);
  fill(#555050); 
  rect(30, 30, width-50, height-75);
  circle(width/2, 15, 10);
  
  //background(255);
  textFont(createFont("Arial", 12));
  fill(prevColor);
  
  //setting up beads recording. Using Kurt's code from Teams  
  ac = AudioContext.getDefaultContext();
  ac_coch = AudioContext.getDefaultContext();
  Sample outputSample = new Sample(5000); //sample to store in memory
  recordToSample = new RecordToSample(outputSample, RecordToSample.Mode.FINITE);
  recordToSample.addInput(ac.getAudioInput());
  ac.out.addDependent(recordToSample);
  recorded = false;
  
  envelopeKeys.put("l", "Low Value");
  envelopeKeys.put("m", "Medium Value");
  envelopeKeys.put("h", "High Value");
  
}

void draw() {
  fill(sphereColor);
  float n = cos(frameCount*0.01)*300;
  ellipse(250, 250, n, n);
  fill(255);
  
   
  if(!recorded && recordedStart == false)
    {
    text("Press r key to start recording.", 40, 550);
    recordedStart = true;
    }
    
  if(recorded == false && key == 'r' && start == false)
  {
    text("Now recording, click on the mouse to stop recording.", 40, 565);
    ac.start();
    start = true;
  }
   
  if(recorded == true && manipulate == true & key == 'p')
  {
    if(inputs.contains("f")){
      ac_wp.start();
      ac.start();
    }
    else {
    ac.start();
    }
  }
}

void mousePressed() {
  recordToSample.clip();//stop recording
  
  if(recorded == false) {
  try {//write to sketch path
    recordToSample.getSample().write(sketchPath("test.wav"), AudioFileType.WAV);
    text("Recording Saved.", 40, 580);
    recorded = true;
    ac.stop();
    manipulate = true;
    changeColor("r");
  
  }
  catch (IOException e) {
    e.printStackTrace();
    }  
  }
  
  if(manipulate = true) 
  {
    synthesiser();
    
  }
}

void synthesiser() {
  if(displayChoice == false)
  {
  text("How would you like to modfify the sound? Please press a key and click the mouse", 40, 595); 
  text("Following options are:", 40, 610);
  text("s for rate", 40, 625);
  text("t for pitch", 40, 640);
  text("f for frequency", 40, 655);
  //text("c for cochlear", 40, 665);
  displayChoice = true;
  }
  
  if(key == 's') {
    userInput = "s";
      inputs.add(userInput);
      text("How do you want to modify the rate?", 40, 670);
  }
  
  if(key == 'l' & userInput == "s" && rateModified == false) {
      envelopeInput = "l";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      rateModified = true;
      changeColor(userInput);
      showChoice(envelopeInput);
    }
    
   if(key == 'm' & userInput == "s" && rateModified == false) {
      envelopeInput = "m";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      rateModified = true;
      changeColor(userInput);
      showChoice(envelopeInput);
    }
    
    if(key == 'h' & userInput == "s" && rateModified == false) {
      envelopeInput = "h";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      rateModified = true;
      changeColor(userInput);
      showChoice(envelopeInput);
    }
    
   if(key == 't') {
    userInput = "t";
      inputs.add(userInput);
      text("How do you want to modify the pitch?", 40, 685);
  }
  if(key == 'l' & userInput == "t" && pitchModified == false) {
      envelopeInput = "l";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      pitchModified = true;
      changeColor(userInput);
      showChoice(envelopeInput);
      showChoice(envelopeInput);
    }
    
    if(key == 'm' & userInput == "t" && pitchModified == false) {
      envelopeInput = "m";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      pitchModified = true;
      changeColor(userInput);
      showChoice(envelopeInput);
    }
    
    if(key == 'h' & userInput == "t" && pitchModified == false) {
      envelopeInput = "h";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      pitchModified = true;
      showChoice(envelopeInput);
    }
  
  
  if(key == 'f') {
    userInput = "f";
    text("This will add an additional tone to the wave", 5, 690);
    inputs.add(userInput);
    envelopeVals.put(userInput, "l");
  }
  
  if(key == 'l' & userInput == "f") {
      envelopeInput = "l";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      changeColor(userInput);
      showChoice(envelopeInput);
    }
    
    if(key == 'm' & userInput == "f") {
      envelopeInput = "m";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      changeColor(userInput);
      showChoice(envelopeInput);
  }
    
    if(key == 'h' & userInput == "f") {
      envelopeInput = "h";
      println("Envelope Input added");
      envelopeVals.put(userInput, envelopeInput);
      changeColor(userInput);
      showChoice(envelopeInput);
  }
    
    if(key == 'c') {
      inputs.clear();
      envelopeVals.clear();
      userInput = "c";
      inputs.add(userInput);
      text("Cochlear Mode selected. Please press g", 40, 670);
    }
    
   if (key == 'g') {
    text("Processing Selections. Press p to play", 40, 705);
    audioManipulation(inputs,envelopeVals);
    changeColor("g");
  }   
}

void showChoice(String envelopeInput) {
  String choice;
  
  System.out.println(envelopeKeys);
  
  for(int i = 0; i < inputs.size(); i++)
  {
  choice = inputs.get(i);
  print(choice);
    
  switch(choice) 
  
  {
    case "t":
    text("Pitch Modified: " + " " + envelopeKeys.get(envelopeInput), 300, 700);                                
    break;
    
    case "s":
    text("Rate Modified: " + " " + envelopeKeys.get(envelopeInput), 300, 715);
    break;
    
    case "f":
    text("Frequency Modified" + envelopeKeys.get(envelopeInput), 300, 730);
    break;
  }
  }
}

void changeColor(String state) {
  switch(state)
  {
    case "r":
    sphereColor = #C43333;
    prevColor = #DE9A9A;
    break;
  
    case "s":
    prevColor = sphereColor;
    sphereColor = #F0822E;
    break;
    
    case "t":
    prevColor = sphereColor;
    sphereColor = #A4CEAC;
    break;
    
    case "f":
    prevColor = sphereColor;
    sphereColor = #9AB4EA;
    break;
    
    case "g":
    prevColor = sphereColor;
    sphereColor = #D39AEA;
    break;
  }
}
