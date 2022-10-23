//Currently houses audio files

import beads.*;
import java.util.Arrays; 

String playFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/GUI/GUI/data/24096__acclivity__henry5.mp3";
String environmentFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/GUI/GUI/data/128291__garyq__cafeteria.mp3";
String musicFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/GUI/GUI/data/378665__frankum__red-hard-lead-techno-house.mp3";
String bellFile = "/Users/cmm/Documents/University/Year 4 University/Interactive Media/Assignment 3 Repo/InteractiveMedia-Individual-Project/GUI/GUI/data/82997__ah107825__bell-tower-isolated.wav";
String audioFile;

Boolean cochlearMode;

GranularSamplePlayer player;
SamplePlayer enviroPlayer;
AudioContext ac;
AudioContext ac2;
Gain g = new Gain(2, 1);
Envelope rate = new Envelope(1);
Gain g2 = new Gain(1, 1);



void playMusic() {
  player = new GranularSamplePlayer(SampleManager.sample(musicFile));
  ac = AudioContext.getDefaultContext();
  g.addInput(player);
  ac.out.addInput(g);
  ac.start();
}

void playEnvironment() {
  player = new GranularSamplePlayer(SampleManager.sample(environmentFile));
  ac = AudioContext.getDefaultContext();
  g2.addInput(player);
  ac.out.addInput(g2);
  ac.start();
  
}

void changePitch(Boolean cochlearMode) { //play around the with distortion to sound less grating? Maybe a seperate file loaded in
  if(cochlearMode == true){
  rate = new Envelope(ac, 4);
  rate.addSegment(1, 5);
  //rate.addSegment(2, 0.5, -90);
  player.setPitchEnvelope(rate);
  }
}
