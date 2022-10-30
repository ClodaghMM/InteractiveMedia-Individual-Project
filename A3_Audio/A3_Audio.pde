
//LIBRARIES
import beads.*;


//VARIABLES
RecordToSample recordToSample;
AudioContext ac;
AudioContext acm;
Gain g = new Gain(1, 2);
SamplePlayer player;
Boolean recorded;
String audio;


void setup() {
  
  //setting up the UI
  size(500, 800, P3D);
  background(255);
  textFont(createFont("Arial", 12));
  fill(#F2ABAB);
  translate(width/2, height/2);
  //noStroke();
  pushMatrix();
  rotate(PI);
  sphere(175);
  popMatrix();
  translate(0, 0);

  //setting up beads recording 
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
   audio = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/A3_Audio/test.wav";
   acm = AudioContext.getDefaultContext();
   player = new SamplePlayer(SampleManager.sample(audio));
   g.addInput(player);
   acm.out.addInput(g);
   acm.start();
  }
  
}


void mousePressed() {
  recordToSample.clip();//stop recording
  try {//write to sketch path
    recordToSample.getSample().write(sketchPath("test.wav"), AudioFileType.WAV);
    text("Recording Saved.", 5, 25);
    recorded = true;
    ac.stop();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}
