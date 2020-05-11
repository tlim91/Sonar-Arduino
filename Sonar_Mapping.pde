import processing.serial.*; // imports library for serial communication
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;

Serial SonarPort;

String data = "";
String angle = "";
String d1 = "";
String d2 = "";

int iAngle = 45;
float iD1, iD2, pD1, pD2;
int index1, index2;

void setup() {
  
 size (1920, 1080);
 smooth();
 
 SonarPort = new Serial(this, "COM9", 9600); // starts Serial Communication
 SonarPort.bufferUntil('.'); // reads up to the '.'
}

void draw() {
  
  fill(98,245,31);
  // simulating motion blur and slow fade of the moving line
  noStroke();
  fill(0,4); 
  rect(0, 0, width, 1010); 
  
  // calls the functions for drawing the radar
  translate(600,520); // moves the starting coordinates to new location
  fill(98,245,31); // green color
  drawRadar(); 
  drawText();
  drawLine();
  drawObject();

}

void serialEvent (Serial SonarPort) {
  
  // Reads until period. Then shortens out the period
  data = SonarPort.readStringUntil('.');
  data = data.substring(0, data.length()-1);
  
  index1 = data.indexOf(","); // Finds the character and puts as a variable
  index2 = data.indexOf("/"); // Finds the character sets as second index
  angle = data.substring(0, index1); // Assign angle in string
  d1 = data.substring(index1+1, index2); // distance 1 in string
  d2 = data.substring(index2+1, data.length()); // distance 2 in string
  
  // Converts string to integers
  iAngle = int(angle);
  iD1 = float(d1);
  iD2 = float(d2);
  
}

void drawRadar() {
  pushMatrix();
  
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  // draws the circle lines
  circle(0,0,230);
  circle(0,0,460);
  circle(0,0,690);
  circle(0,0,920);
  
  // draws the lines
  line(-470,0,470,0); // horizontal
  line(0,-470,0,470); // vertical
  line(-470*cos(radians(30)), -470*sin(radians(30)), 470*cos(radians(30)), 470*sin(radians(30)));
  line(-470*cos(radians(30)), +470*sin(radians(30)), 470*cos(radians(30)), -470*sin(radians(30)));
  line(-470*cos(radians(60)), -470*sin(radians(60)), 470*cos(radians(60)), 470*sin(radians(60)));
  line(-470*cos(radians(60)), +470*sin(radians(60)), 470*cos(radians(60)), -470*sin(radians(60)));
  
  popMatrix();
}

void drawObject() {
 pushMatrix();
 
 strokeWeight(9);
 stroke(0,250,0);
 
 pD1 = iD1*22.5/2;
 pD2 = iD2*22.5/2;
 
 if (iD1 < 40){
   line(0,0,pD1*sin(radians(iAngle)),-pD1*cos(radians(iAngle)));
 }
 else {
   line(0,0,470*sin(radians(iAngle)),-470*cos(radians(iAngle)));
 }
 if (iD2 <40){
   line(-pD2*sin(radians(iAngle)),pD2*cos(radians(iAngle)),0,0);
 }
 else {
   line(-470*sin(radians(iAngle)),470*cos(radians(iAngle)),0,0);
 }
 
 
 popMatrix();
}

void drawLine(){
  pushMatrix();
  
  strokeWeight(9);
  stroke(250,0,0);
  line(470*sin(radians(iAngle)),-470*cos(radians(iAngle)),-470*sin(radians(iAngle)),470*cos(radians(iAngle)));
  
  popMatrix();
}

void drawText(){
  pushMatrix();
  
  fill(255,255,255);
  // Distance writing
  textSize(15);
  text("10cm",120*cos(radians(15)),-120*sin(radians(15)));
  text("20cm",235*cos(radians(15)),-235*sin(radians(15)));
  text("30cm",350*cos(radians(15)),-350*sin(radians(15)));
  text("40cm",465*cos(radians(15)),-465*sin(radians(15)));
  
  // Angles
  text("0°", 0 ,-480);
  text("180°", 0 ,480);
  text("90°", 480,0);
  text("270°", -500, 0);
  text("300°", -490*cos(radians(30)), -490*sin(radians(30)));
  text("330°", -490*cos(radians(60)), -490*sin(radians(60)));
  text("120°", 490*cos(radians(30)), 490*sin(radians(30)));
  text("150°", 490*cos(radians(60)), 490*sin(radians(60)));
  text("240°", -500*cos(radians(30)), 500*sin(radians(30)));
  text("210°", -490*cos(radians(60)), 490*sin(radians(60)));
  text("60°", 490*cos(radians(30)), -490*sin(radians(30)));
  text("30°", 490*cos(radians(60)), -490*sin(radians(60)));
  
  popMatrix();
}
