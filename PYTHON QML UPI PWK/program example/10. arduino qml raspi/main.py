import sys

from PyQt5 import QtGui, QtCore, Qt
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot, QTimer, pyqtProperty
from PyQt5.QtCore    import pyqtSlot, pyqtSignal, QUrl, QObject,QStringListModel, Qt
from PyQt5.QtQuick   import QQuickView
from PyQt5.QtWidgets import QApplication, QCheckBox, QGridLayout, QGroupBox
from PyQt5.QtWidgets import QMenu, QPushButton, QRadioButton, QVBoxLayout, QWidget, QSlider
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtGui import QGuiApplication, QIcon

import time


##################################################################
#----------------deklarasi variabel------------------------------#
analog = 110
input1_color = "#df1c39"
input2_color = "#df1c39"

button1_status = "0"
button2_status = "0"
button3_status = "0"

analog_output = "0"



adc = 0
data1 = 0
data2 = 0
esp32_status = "inactive"

time_esp = 0
time_esp_prev = time.time()

sensor1_color = "#04f8fa" #"#df1c39"
sensor2_color = "#04f8fa" #"#df1c39"


datapinpwm = 0
formchar = "0"

led_status1 = "off"
led_status2 = "off"
led_status3 = "off"


message_time = 0
message_time_prev = time.time()


##################################################################
#----------------mengaktifkan komunikasi serial------------------#
import sys
import serial
import threading

serial_data = ""

transmit_time = 0
transmit_time_prev = 0

data_send = ""

print ("select your arduino port:")

def serial_ports():
    
    if sys.platform.startswith('win'):
        ports = ['COM%s' % (i + 1) for i in range(256)]
    elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
        # this excludes your current terminal "/dev/tty"
        ports = glob.glob('/dev/tty[A-Za-z]*')
    elif sys.platform.startswith('darwin'):
        ports = glob.glob('/dev/tty.*')
    else:
        raise EnvironmentError('Unsupported platform')

    result = []
    for port in ports:
        try:
            s = serial.Serial(port)
            s.close()
            result.append(port)
        except (OSError, serial.SerialException):
            pass
    return result
print(str(serial_ports()))

port = input("write port : ")

ser = serial.Serial(port, 9600, timeout=3)






@pyqtSlot(result=int)
def get_tempo(self):
    date_time = QDateTime.currentDateTime()
    unixTIME = date_time.toSecsSinceEpoch()
    print("yes")
    #unixTIMEx = date_time.currentMSecsSinceEpoch()
    return unixTIME



class table(QQuickView):
    adc_val = pyqtSignal(str)
    sensor1_color_val = pyqtSignal(str)
    sensor2_color_val = pyqtSignal(str)
    
    def __init__(self):
        super().__init__()
        self.setSource(QUrl('main.qml'))
        self.setTitle("")
        
        self.rootContext().setContextProperty("table", self)
        self.setGeometry(100, 100, 1000, 600)
        self.show()
        
        windows = self.rootObject()
        
        self.init_tempo()
        
        self.adc_val.connect(windows.adc_read)
        self.sensor1_color_val.connect(windows.sensor1_color_read)
        self.sensor2_color_val.connect(windows.sensor2_color_read)


    def init_tempo(self):
        self.tempo = QtCore.QTimer()
        self.tempo.timeout.connect(self.variable_transfer)
        self.tempo.start(500)
        
        
    def variable_transfer(self):
        global time_esp
        global espledcolor
        global message_time
        global message_time_prev
        global sensor1_color
        global sensor2_color
        
        time_esp = time.time() - time_esp_prev
        
        
        self.adc_val.emit(str(analog))
        self.sensor1_color_val.emit(str(input1_color))
        self.sensor2_color_val.emit(str(input2_color))
        
        self.tempo.start(50)
        
        message_time = time.time() - message_time_prev

        '''
        if (message_time > 0.5):
            pass
        
            print(" | pwm : " + str(datapinpwm) +  " | led1 : " +
                  str(led_status1) +  " | led2 : " +
               str(led_status2)
                  +  " | led3 :" +
                  str(led_status3))
                
            message_time_prev = time.time()
        '''
    
    #####################TOMBOL QML KE PYTHON###################
    @pyqtSlot(str)
    def button1(self, message):
        global button1_status
        print(message)
        button1_status = message
        

        
    @pyqtSlot(str)
    def button2(self, message):
        global button2_status
        print(message)
        button2_status = message
        
        
        
    @pyqtSlot(str)
    def button3(self, message):
        print(message)
        global button3_status
        print(message)
        button3_status = message
        
    #####################SLIDER QML KE PYTHON###################
    @pyqtSlot(str)
    def analog_output(self, message):
        global analog_output
        analog_output=message
        
                 
    
        
            

#----------------------------------------------------------------#
###############################MEMBACA DATA SERIAL##################
def serial_read(num):
    global ser_bytes
    global decoded_bytes
    global serial_data
    global analog
    global data
    global input1_color
    global input2_color
    
    while True:
        try:
            ser_bytes = ser.readline()
            serial_data = (ser_bytes.decode('utf-8')[:-2])
            
            print(serial_data)
                
        except:
            serial_data = serial_data
            
        data = serial_data.split(":")
        
        analog = int(data[0])
        print(analog)
        if (data[1] == "0"):
            input1_color = "#df1c39"
        else:
            input1_color = "#04f8fa"
            
        if (data[2] == "0"):
            input2_color = "#df1c39"
        else:
            input2_color = "#04f8fa"
#----------------------------------------------------------------#

def serial_write(num):
    global transmit_time
    global transmit_time_prev
    global data_send
    
    while True:
        transmit_time = time.time() - transmit_time_prev
        data_send = (str("*") + str(button1_status) + str("|")
        + str(button2_status) + str("|")
        + str(button3_status) + str("|")
        + str(analog_output) +str("|")
        
        )
        if (transmit_time > 0.5):
            #print(data_send)
            ser.write(data_send.encode())
            transmit_time_prev = time.time() 




if __name__ == '__main__':
    
    app = QApplication(sys.argv)
    
    t1 = threading.Thread(target=serial_read, args=(10,))
    t1.start()
    
    t2 = threading.Thread(target=serial_write, args=(10,))
    t2.start()
    
    w = table()
    sys.exit(app.exec_())