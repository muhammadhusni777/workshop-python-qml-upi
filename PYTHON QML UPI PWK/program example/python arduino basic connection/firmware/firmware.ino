int led = 13;

int transmit_time;
int transmit_time_prev;

void setup()  
{  
    Serial.begin(9600); //Baud Rate  
    pinMode(led, OUTPUT);  
}  
void loop()  
{  
    char data = Serial.read();  
    switch (data) //Selection Control Statement  
    {  
        case 'H':  
            digitalWrite(led, HIGH); // Sets the led ON  
            break;  
        case 'L':  
            digitalWrite(led, LOW); //Sets the led OFF  
            break;  
    }

    transmit_time = millis() - transmit_time_prev;
    if (transmit_time > 1000){
      Serial.println(analogRead(A0));
      transmit_time_prev = millis();
    }
} 
