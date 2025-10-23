// Ari Mahpour
// 07/21/2021
// This example code demonstrates reading from the ADC and sending the value back under command

String readString;

void setup() {
  Serial.begin(115200);
  //pinMode(DAC0, OUTPUT);
  pinMode(A0, INPUT);
}

void loop() {
  // Reads the serial input until a carriage return shows up
  while (Serial.available()) {
    delay(10);  //small delay to allow input buffer to fill
    char c = Serial.read();  //gets one byte from serial buffer
    if (c == '\r') {
      break; //breaks out of capture loop to print readstring
    }  
    readString += c; //makes the string readString
  }

  // Process the commands
  if (readString.length() > 0) { 
    // Request for ADC telemetry
    if (readString == "getADCValue") {
      int sensorValue = analogRead(A0);
      Serial.println(sensorValue);
    }
    else {
      Serial.println("Unsupported command: " + readString);
    }

    readString=""; //clears variable for new input
  }
  
  //float voltage = sensorValue * (3.3/1023.0);
  //analogWrite(DAC0, sensorValue/4);
}