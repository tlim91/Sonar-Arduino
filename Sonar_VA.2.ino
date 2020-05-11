// Servo
#include <Servo.h>
  Servo servo_pan; // servo object for pan angles
  
// defining pin numbers
#define echoPin1 2
#define trigPin1 3 
#define echoPin2 4
#define trigPin2 5

int angle = 0; // variable for pan angle
long duration;
int distance, d1,d2;

void setup() {  
  // Attaching to pin ports
  servo_pan.attach(9);  // Servo Pin
  
  // Attaching Sonar to pin ports
  pinMode (trigPin1, OUTPUT); pinMode (echoPin1, INPUT); // Sonar 1
  pinMode (trigPin2, OUTPUT); pinMode (echoPin2, INPUT); // Sonar 2

  Serial.begin(9600);
  servo_pan.write(angle); // Setting the inital angle
}

void loop() {
  // Sweeping through 0 to 180
  for (angle = 0; angle <= 180; angle++){
    // Move the servo
    servo_pan.write(angle);
    delay(30);

    // Calculate Distance
    d1 = CalculateDistance(echoPin1, trigPin1);
    d2 = CalculateDistance(echoPin2, trigPin2);
    Serial.print(angle);
    Serial.print(",");
    Serial.print(d1);
    Serial.print("/");
    Serial.print(d2);
    Serial.print(".");
  }

  // Sweeping through 180 to 0
  for (angle = 180; angle > 0; angle--){
    // Move the servo
    servo_pan.write(angle);
    delay(30);

    // Calculate Distance
    d1 = CalculateDistance(echoPin1, trigPin1);
    d2 = CalculateDistance(echoPin2, trigPin2);
    Serial.print(angle);
    Serial.print(',');
    Serial.print(d1);
    Serial.print('/');
    Serial.print(d2);
    Serial.print('.');
  }

}

int CalculateDistance(int echoPin, int trigPin){

  digitalWrite(trigPin, LOW); delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Record time in microseconds
  duration = pulseIn(echoPin, HIGH);

  // calculate distance
  distance = duration * 0.0343/2;

  return distance;
  
}
