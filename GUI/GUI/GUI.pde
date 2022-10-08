import controlP5.*;
import java.util.*;

  //VARIABLES//
  ControlP5 cp5;
  List noiseEnvironment = Arrays.asList("conversation", "club", "cafe", "nature");


void setup() {
  size(1500, 850);
  
  cp5 = new ControlP5(this);
  cp5.addSlider("pitch Change")
  .setPosition(700, 600)
  .setRange(0, 50)
  .setNumberOfTickMarks(5);
  
  cp5.addScrollableList("noise Environment")
  .setPosition(700, 700)
  .setSize(200, 100)
  .setBarHeight(20)
  .setItemHeight(20)
  .addItems(noiseEnvironment);
}

//need to add a square that shows the sound being modulated 

void draw() {
  background(0);
}
