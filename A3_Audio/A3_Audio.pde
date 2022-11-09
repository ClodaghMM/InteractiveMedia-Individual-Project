//LIBRARIES
import beads.*;
import java.util.*;

//VARIABLES
RecordToSample recordToSample;
AudioContext ac;
Gain g = new Gain(1, 2);
SamplePlayer player;
PowerSpectrum ps;

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
  ac_wp = AudioContext.getDefaultContext();
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
  
   
  //if(!recorded && recordedStart == false)
  //  {
  //  text("Press r key to start recording.", 40, 550);
  //  recordedStart = true;
  //  }
    
  //if(recorded == false && key == 'r' && start == false)
  //{
  //  text("Now recording, click on the mouse to stop recording.", 40, 565);
  //  ac.start();
  //  start = true;
  //}
   
  if(recorded == true && manipulate == true & key == 'p')
  {
    //refill the square 
    fill(#555050); 
    rect(30, 30, width-50, height-75);
    visualise();
    //visualising the output. Not the best at the moment. 
  //  stroke(fore);
  //  if(ps == null) return;
  //  float[] features = ps.getFeatures();
  //  if(features != null) {
  //  //scan across the pixels
  //  for(int i = 0; i < width; i++) { //for(int i = 0; i < width; i++) { 
  //    int featureIndex = i * features.length / width;
  //    int vOffset = height - 1 - Math.min((int)(features[featureIndex] * height), height - 1);
  //    line(i,height,i,vOffset);
  //  }
  //}
    
    if(inputs.contains("f") || inputs.contains("c")){ 
      ac_wp.start();
      ac.start();
    }
    
    else{
    ac.start();
    }
  }
  
  if(key == 'x')
  {
    exit();
  }
}

void mousePressed() {
  manipulate = true;
  recorded = true;
  
  //recordToSample.clip();//stop recording
  
  //if(recorded == false) {
  //try {//write to sketch path
  //  recordToSample.getSample().write(sketchPath("test.wav"), AudioFileType.WAV);
  //  text("Recording Saved.", 40, 580);
  //  recorded = true;
  //  ac.stop();
  //  manipulate = true;
  //  changeColor("r");
  
  //}
  //catch (IOException e) {
  //  e.printStackTrace();
  //  }  
  //}
  
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
      text("How do you want to modify the rate? (l, m, h)", 40, 670);
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
      text("How do you want to modify the pitch? (l, m, h)", 40, 685);
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
    text("How do you want to modify the frequency? (l, m, h)", 40, 700);
    inputs.add(userInput);
    envelopeVals.put(userInput, "l");
  }
  
  if(key == 'l' & userInput == "f") {
      envelopeInput = "l";
      envelopeVals.put(userInput, envelopeInput);
      changeColor(userInput);
      showChoice(envelopeInput);
    }
    
    if(key == 'm' & userInput == "f") {
      envelopeInput = "m";
      envelopeVals.put(userInput, envelopeInput);
      changeColor(userInput);
      showChoice(envelopeInput);
  }
    
    if(key == 'h' & userInput == "f") {
      envelopeInput = "h";
      envelopeVals.put(userInput, envelopeInput);
      changeColor(userInput);
      showChoice(envelopeInput);
  }
    
    if(key == 'c') {
      userInput = "t";
      inputs.add(userInput);
      envelopeVals.put(userInput, "h");
      userInput = "f";
      inputs.add(userInput);
      envelopeVals.put(userInput, "h");
      userInput = "f";
      inputs.add(userInput);
      envelopeVals.put(userInput, "l");
      userInput = "p";
      inputs.add(userInput);
      envelopeVals.put(userInput, "m");
      text("Cochlear Mode selected. Please press g", 40, 670);
    }
    
   if (key == 'g') {
    text("Processing Selections. Press p to play", 40, 715);
    audioManipulation(inputs,envelopeVals);
    changeColor("g");
  }   
}

void showChoice(String envelopeInput) {
  String choice;
    
  for(int i = 0; i < inputs.size(); i++)
  {
  choice = inputs.get(i);
  println(choice);
  print(envelopeKeys);
    
  switch(choice) 
  
  {
    case "t":
    text("Pitch Modified: " + " " + envelopeKeys.get(envelopeInput), 300, 650);                                
    break;
    
    case "s":
    text("Rate Modified: " + " " + envelopeKeys.get(envelopeInput), 300, 675);
    break;
    
    case "f":
    text("Frequency Modified: " + " " + envelopeKeys.get(envelopeInput), 300, 690);
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

 void visualise() {
   for(int i = 0; i < inputs.size(); i++) {
     Input = inputs.get(i);
     
      switch(Input) {
       
        case "s": 
        fill(#F0822E);
       level = envelopeVals.get(userInput);
        
        if (level.equals("l"))
      {
        square(random(10, 100), random(10, 100), 50);
      }

      if (level.equals("m")) {    
         square(random(100, 200), random(100, 200), 50);
      } 
      else if (level.equals("h")) {
         square(random(200, 300), random(200, 300), 50);
      }
         break;
        
        case "t": 
        fill(#A4CEAC);
        level = envelopeVals.get(userInput);

          if (level.equals("l"))
        {
           circle(random(10, 100), random(10, 100), 50);
        }
        
        if (level.equals("m")) {
          circle(random(100, 200), random(100, 200), 50);
        } 
        
        else if (level.equals("h")) {
          circle(random(200, 300), random(200, 300), 50);
        }

        break;
        
        case "f": 
        fill(#9AB4EA);
        level = envelopeVals.get(userInput);

          if (level.equals("l"))
        {
          triangle(random(10, 100), random(10, 100), random(10, 100), random(10, 100), random(10, 100), random(10, 100)); 
        }
  
        if (level.equals("m")) {
          triangle(random(100, 200), random(100, 200), random(100, 200), random(100, 200), random(100, 200), random(100, 200));
        } 
        
        else if (level.equals("h")) {
          triangle(random(200, 300), random(200, 300), random(200, 300), random(200, 300), random(200, 300), random(200, 300));
        }
        
        break;
        
     
   }
 
 }
 }
