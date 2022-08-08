///////////////////////////////////////////////////////////////////////////////
/////// PROGRAM FIRMWARE ARDUINO PYTHON //////////////////////////////////////
/////// written by : muhammad husni     /////////////////////////////////////
/////// FOR EDUCATIONAL PURPOSE         ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////// 



///////////////DEKLARASI VARIABEL////////////////////////////////////////////
String myString;
String received_data;
char c;
String data_buffer;
int Index1,Index2,Index3,Index4,Index5,Index6, Index7, Index8, Index9;
String secondValue, thirdValue, fourthValue, fifthValue, sixthValue, seventhValue, eighthValue, firstValue;
unsigned long time_send;
unsigned long prev_time_send;

int led1 = 13;
int led2 = 12;
int led3 = 11;
int led_pwm = 10;

int led1_status;
int led2_status;
int led3_status;
int led_pwm_val;


int button1=9;
int button2=8;

int pot = A0;


void setup() {              
  //inisialisasi baud rate serial
   Serial.begin(9600);

  //inisialisasi pin input dan output
   pinMode(led1, OUTPUT);
   pinMode(led2, OUTPUT);
   pinMode(led3, OUTPUT);
   pinMode(led_pwm, OUTPUT);
   pinMode(button1, INPUT_PULLUP);
   pinMode(button2, INPUT_PULLUP);
  }


void loop() {

  //program untuk menerima data serial
  while (Serial.available()>0){
    delay(10);
    c = Serial.read();
    myString += c;
    data_buffer = myString;
   
  }


  //memisah misahkan data (parsing) serial yang diterima
  if (myString.length()>0){
    Index1 = myString.indexOf('*');
    Index2 = myString.indexOf('|', Index1+1);
    Index3 = myString.indexOf('|', Index2+1);
    Index4 = myString.indexOf('|', Index3+1);
    Index5 = myString.indexOf('|', Index4+1);

    secondValue = myString.substring(Index1+1, Index2);
    thirdValue = myString.substring(Index2+1, Index3);
    fourthValue = myString.substring(Index3+1, Index4);
    firstValue = myString.substring(Index4+1, Index5);
    myString="";
  }


 //mengirim data serial dari arduino ke python
  time_send = millis() - prev_time_send;
  if (time_send > 500){
    Serial.println(data_buffer);
    Serial.print("data 1 :");
    Serial.println(firstValue);
    Serial.print("data 2 :");
    Serial.println(secondValue);
    Serial.print("data 3 :");
    Serial.println(thirdValue);
    Serial.print("data 4 :");
    Serial.println(fourthValue);
    prev_time_send = millis();
}

}
