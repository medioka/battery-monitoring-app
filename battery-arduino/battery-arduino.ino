// THIS CODE WAS USED FOR 4 SERIAL BATTERIES CONFIGURATION
// IF YOU HAVE DIFFERENT BATTERY SIZE, PLEASE ADJUST

#include "INA226.h"
#include "Wire.h"
#include "Math.h"
#include <SoftwareSerial.h>

#define VOLT_MULTIPLIER 3
#define VOLT_REFERENCE 5
#define PERIOD 1000
INA226 INA(0x40);
SoftwareSerial BTserial(8, 7);  // RX | TX

unsigned long prevTime = 0; 
unsigned long nowTime = 0; 
float batCapacity = 5.736; // Replace with your battery capacity in Ah
float soc = 50; 
float totalVolt = 0;
float current = 0;

void setup(){
  Serial.begin(9600);
  BTserial.begin(9600);   
  Wire.begin();  

  if (!INA.begin() ){
    Serial.println("could not connect. Fix and Reboot");
    return;
  }

  // CURRENT SHUNT USED IN THE SENSOR
  // ADJUST TO THE VALUE THAT YOU USE IN THE INA226 SENSOR
  INA.setMaxCurrentShunt(32, 0.001);
  INA.setAverage(4);

  Serial.println("Ready");
}

void sendDataBasedOnRequest(){
  if (BTserial.available() <= 0) return;
  byte index = 0;
  String myString = "";
  String data ;
  char tempData[4];
  char *ptr = NULL;
  char charArray[20];

  // Capture data from Bluetooth
  data += BTserial.readString();
  data.trim();

  //Convert data into array
  data.toCharArray(charArray, data.length() + 1);
  ptr = strtok(charArray, ",");
  while (ptr != NULL) {
    tempData[index] = ptr;
    index++;
    ptr = strtok(NULL, ",");
  }

  myString = String(tempData[1]);

  //Request percentage
  //Show battery percentage/soc 
  if(myString == "perc") {
    float val = atof(tempData[0]);
    soc = val;
    Serial.println(soc,2);
  }
  //Request capacity
  //Show battery capacity
  else if (myString == "cap"){
    float val = atof(tempData[0]);
    batCapacity = val/1000;
    Serial.println(batCapacity,3);
  }
}

void loop(){
  sendDataBasedOnRequest();
  nowTime = millis();

  //Calculate current, totalvolt, and soc
  if(nowTime - prevTime >= PERIOD){
    calculateCurrent();
    calculateVoltage();
    doColoumbCounting();
    prevTime = nowTime;
  }
    
  //Calculate cell voltages and send it to app
  float cellVoltages[4];
  float maxMinVoltages[2];
  calculateCellVoltages(cellVoltages);
  calculateMaxMinVoltage(maxMinVoltages, cellVoltages);
  sendDataToApp(maxMinVoltages, cellVoltages);
}

void calculateVoltage(){
  totalVolt = INA.getBusVoltage();
  if(totalVolt< 0.5) totalVolt = 0;
  else totalVolt = 1.0008*totalVolt  - 0.0023;
}

void calculateCurrent(){
  // FORMULA BELOW IS THE CALIBRATION FORMULA FOR THE INA226 SENSOR
  if(abs(current) <= .01){
    current = 0;
  }else if (current < 0){
    current = (0.9696 * current *-1 + 0.0004)  ;
  }else if (current > 0) {
    current = (0.9809 * current + 0.0033)* - 1;
  }
    
  current = roundf(current * 100);
  current /= 100;
}

void doColoumbCounting(){
  // FORMULA OF COLOUMB COUNTING METHOD
  soc = soc + (current * 100 / (batCapacity*3600));
}

void calculateMaxMinVoltage(float* maxMinVoltages, float* cellVoltages){
  float maxVoltage = -99999.0f ;
  float minVoltage = 99999.0f ;

  for (int i = 0; i < sizeof(cellVoltages); i++ ){
      if(cellVoltages[i] > maxVoltage) maxVoltage = cellVoltages[i];
      if(cellVoltages[i] < minVoltage) minVoltage = cellVoltages[i];
  }
  maxMinVoltages[0] = minVoltage;
  maxMinVoltages[1] = maxVoltage;
}

void calculateCellVoltages(float *cellVoltages){
    float cellVolt_1 = ((float (analogRead(A0)) *VOLT_REFERENCE / 1023) *1.026 * VOLT_MULTIPLIER) - ((float (analogRead(A1)) *VOLT_REFERENCE / 1023) *1.026 *VOLT_MULTIPLIER) ;
    float cellVolt_2 = ((float (analogRead(A1)) *VOLT_REFERENCE / 1023) *1.026 * VOLT_MULTIPLIER) - ((float (analogRead(A2)) *VOLT_REFERENCE / 1023) *1.026 *VOLT_MULTIPLIER ) ;
    float cellVolt_3 = ((float (analogRead(A2)) *VOLT_REFERENCE / 1023) *1.026 *VOLT_MULTIPLIER) - (float (analogRead(A3)) *VOLT_REFERENCE / 1023) *1.026;
    float cellVolt_4;

    if(cellVolt_1 == 0) cellVolt_4 = 0;
    else cellVolt_4 = (float (analogRead(A3)) *VOLT_REFERENCE / 1023) *1.026 ;

    float cellVolts[4] = {cellVolt_1,cellVolt_2,cellVolt_3,cellVolt_4};

    for(int i = 0; i < sizeof(cellVolts); i++){
      cellVoltages[i] = cellVolts[i];
    }
}

void sendDataToApp(float* maxMinVoltages, float* cellVoltages){
    String sendData = "";
    sendData += (totalVolt); sendData += ",";
    sendData += (current); sendData += ",";
    sendData += (soc); sendData += ",";
    sendData += (cellVoltages[0]); sendData += ",";
    sendData += (cellVoltages[1]); sendData += ",";
    sendData += (cellVoltages[2]); sendData += ",";
    sendData += (cellVoltages[3]); sendData += ",";
    sendData += (maxMinVoltages[0]); sendData += ",";
    sendData += (maxMinVoltages[1]); 
    sendData += "\n";
    BTserial.write((char*)sendData.c_str());
}


