import java.util.*;

Envelope Pitch = new Envelope(1);
Envelope freq = new Envelope(3);
Envelope Rate = new Envelope(2);

SamplePlayer cochlear;

Gain cochlear_gain = new Gain(1,2);

Envelope Grain;
WavePlayer wp;
float  val;
int envInt;
String level;
String Input;
AudioContext ac_wp;
Gain g_wp = new Gain(2, 2);

void audioManipulation(ArrayList<String> inputs, Hashtable<String, String> vals) {

  audio = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/A3_Audio/test.wav";
  player = new SamplePlayer(SampleManager.sample(audio));
  cochlear = new SamplePlayer(SampleManager.sample(audio));


  for (int i = 0; i < inputs.size(); i++) {
    Input = inputs.get(i);
    switch(Input) {

    case "s":
      level = vals.get(Input);
      
      if (level.equals("l"))
      {
          val = random(0, 0.4);
      }

      if (level.equals("m")) {
          val = random(0.4, 0.7);
        
      } else if (level.equals("h")) {
          val = random(0.9, 1.5);
      }

      envInt = (int)val;
      Rate.addSegment(val, val/2);
      player.setRate(Rate);
      break;

    case "t":
      level = vals.get(Input);
      if (level.equals("l"))
      {
        val = random(0.1, 0.5);
      }

      if (level.equals("m")) {
        val = random(0.5, 1);
        
      } else if (level.equals("h")) {
        val = random(1, 2);
      }

      envInt = (int)val;
      Pitch.addSegment(val, val/2);
      //Pitch.addSegment(1.15, 1.30/2);
      player.setPitch(Pitch);
      break;

    case "f":
      level = vals.get(Input);
      if (level.equals("l"))
      {
        val = random(5, 10);
      }

      if (level.equals("m")) {
        val = random(10, 20);
        
      } else if (level.equals("h")) {
        val = random(50, 100);
      }

      freq.addSegment(val, val*2);
      wp = new WavePlayer(freq, Buffer.TRIANGLE);
      ac_wp.out.addInput(g_wp);
      g_wp.addInput(wp);
      break;
        
    }    
  }

  ac.out.addInput(g);
  g.addInput(player);
  
}
 
