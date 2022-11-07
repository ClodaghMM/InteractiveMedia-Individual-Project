
import java.util.*;

Envelope Pitch = new Envelope(1);
Envelope freq = new Envelope(3);
Envelope Rate = new Envelope(2);

Envelope cochlear_rate = new Envelope(4);
Envelope cochlear_pitch = new Envelope(5);
Envelope cochlear_freq = new Envelope(6);

SamplePlayer cochlear;

Gain cochlear_gain = new Gain(1,2);

Envelope Grain;
WavePlayer wp;
float  val;
int envInt;
String level;
String Input;
AudioContext ac_wp;
AudioContext ac_mod;
AudioContext ac_coch;
Gain g_wp = new Gain(1, 2);

void audioManipulation(ArrayList<String> inputs, Hashtable<String, String> vals) {

  audio = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/A3_Audio/test.wav";
  player = new SamplePlayer(SampleManager.sample(audio));
  cochlear = new SamplePlayer(SampleManager.sample(audio));


  for (int i = 0; i < inputs.size(); i++) {
    Input = inputs.get(i);
    switch(Input) {

    case "s":
      level = vals.get(userInput);
      if (level.equals("l"))
      {
        val = random(0, 0.4);
      }

      if (level.equals("m")) {
        val = random(0.4, 0.7);
      } else if (level.equals("h")) {
        val = random(0.7, 1);
      }

      envInt = (int)val;
      Rate.addSegment(val, val/2);
      player.setRate(Rate);
      break;

    case "t":
      level = vals.get(userInput);
      if (level.equals("l"))
      {
        val = random(0.1, 0.5);
      }

      if (level.equals("m")) {
        val = random(0.5, 1);
      } else if (level.equals("h")) {
        val = random(1, 5);
      }

      envInt = (int)val;
      Pitch.addSegment(val, val/2);
      player.setPitch(Pitch);
      break;

    case "f":
      level = vals.get(userInput);
      if (level.equals("l"))
      {
        val = random(0.1, 0.5);
      }

      if (level.equals("m")) {
        val = random(0.5, 1);
      } else if (level.equals("h")) {
        val = random(1, 5);
      }

      freq.addSegment(val, val*2);
      wp = new WavePlayer(freq, Buffer.TRIANGLE);
      ac_wp.out.addInput(wp);
      g_wp.addInput(wp);
      break;
    
      //case "c":
      //cochlear_rate = new Envelope(ac, 4);
      //cochlear_rate.addSegment(0.9, 5);
      //cochlear_pitch = new Envelope(ac, 5);
      //cochlear_pitch.addSegment(0.8, 5);
      //player.setPitchEnvelope(cochlear_pitch);
      //player.setRateEnvelope(cochlear_rate);
      
      //cochlear_freq = new Envelope(ac, 6);
      //wp = new WavePlayer(freq, Buffer.TRIANGLE);
      //cochlear_freq.addSegment(100, 2);
      
      //ac_wp.out.addInput(wp);
      //g_wp.addInput(wp);
      //break;
      
  }    
  }

  ac.out.addInput(g);
  g.addInput(player);

}
 
  void implantMode() {
  cochlear_rate = new Envelope(ac, 4);
  cochlear_rate.addSegment(1, 5);
  cochlear.setPitchEnvelope(cochlear_rate);
  }
 
