
import java.util.*;
import beads.*;

Envelope Pitch; 
Envelope Frequency;
Envelope Rate = new Envelope(2);
Envelope Grain;
float  val;
int envInt;
String level;
String Input;

void audioManipulation(ArrayList<String> inputs, Hashtable<String, String> vals) {
  //keys that decide upon.
  audio = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/A3_Audio/test.wav";
  player = new SamplePlayer(SampleManager.sample(audio));
  
  
  for (int i = 0; i < inputs.size(); i++) {
    Input = inputs.get(i);
    switch(Input) {
     
      case "s":
      level = vals.get(userInput);
        if(level.equals("l"))
        {
          val = random(10.0, 50);
        }
        
        if(level.equals("m")) {
          val = random(60, 110);
        }
        
        else if(level.equals("h")) {
          val = random(120, 150);
        }
        
      envInt = (int)val;
      Rate.addSegment(0.1, 0.2);
      player.setRate(Rate);
      break; 
    }
  }
  ac.out.addInput(g);
  g.addInput(player);
  //if cochlear implant mode avaliable
  //test those settings
}
