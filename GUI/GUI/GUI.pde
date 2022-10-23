import controlP5.*;
import java.util.*;
PFont f;
String userInput = "";
char prevKey;
float xTextparam;
float yTextparam;
float textDiffParam;
float personXpos;

//VARIABLES//
ControlP5 cp5;
List noiseEnvironment = Arrays.asList("conversation", "club", "cafe", "nature");


void setup() {
  size(600, 900);
  background(#080101);
  fill(#4D4848);
  rect(0, 0, width, height);
  circle(width/2, 15, 25);
  fill(#555050); 
  rect(30, 30, width-50, height-100);
  circle(width/2, 15, 10);

  xTextparam = 50;
  yTextparam = 100;
  textDiffParam = 50;
  personXpos = 500;

  f = createFont("ITFDevanagari-Book-30.vlw", 48);
  textFont(f);
}



void draw() {
  textSize(20);
  fill(255);
  text("Do you want to listen to some sound (y) or (n)? ", xTextparam, yTextparam);

  if (key == 'n') {
    yTextparam = yTextparam + textDiffParam;
    text("No", personXpos, yTextparam);
    exit();
  }

  if (key == 'y') {
    prevKey = 'y';
    text("what sounds did you want to listen to?", xTextparam, yTextparam + 100);
    text("press m for music or e for environment", xTextparam, yTextparam + 150);
  }

  if (key == 'm' &&  prevKey == 'y') {
    prevKey = 'm';
    text("ok, we're going to play some music.", xTextparam, yTextparam + 200);
    text("Do you want to listen with the cochlear implant?(c)", xTextparam, yTextparam + 250);
    text("or without(w)?.", xTextparam, yTextparam + 300);
  }

  if (key == 'c' && prevKey == 'm') {
    prevKey = 'c';
    text("Press p to listen to both implant and audio", xTextparam, yTextparam + 350);
    playMusic();
  }

  if (key == 'w' && prevKey == 'm') {
    prevKey = 'w';
    text("Listening to music", xTextparam, yTextparam + 350);
    playMusic();
  }

  if (key == 'e' && prevKey == 'y') {
    prevKey = 'e';
    text("ok, we're going to play some environment noise.", xTextparam, yTextparam + 200);
    text("Do you want to listen with the cochlear implant?(c)", xTextparam, yTextparam + 250);
    text("or without(w)?.", xTextparam, yTextparam + 300);
  }

  if (key == 'w' && prevKey == 'e')
  {
    prevKey = 'w';
    text("Listening to sound", xTextparam, yTextparam + 350);
    playEnvironment();
  }

  if (key == 'c' && prevKey == 'e')
  {
    prevKey = 'c';
    text("Press p to listen to both implant and audio", xTextparam, yTextparam + 350);
    playEnvironment();
  }

  if (key == 'x') {
    exit();
  }

  if (key == 'p' && prevKey == 'c') {
    changePitch(true);
  }
}



// OLD CODE //
//cp5 = new ControlP5(this);
//cp5.addSlider("pitch Change")
//.setPosition(700, 600)
//.setRange(0, 50)
//.setNumberOfTickMarks(5);

//cp5.addScrollableList("noise Environment")
//.setPosition(700, 650)
//.setSize(225, 100)
//.setBarHeight(20)
//.setItemHeight(20)
//.addItems(noiseEnvironment);

//cp5.addButton("play")
//.setValue(0)
//.setSize(100, 50)
//.setPosition(700, 775);

//cp5.addButton("pause")
//.setValue(0)
//.setSize(100, 50)
//.setPosition(825, 775);

//drawCochlear();
