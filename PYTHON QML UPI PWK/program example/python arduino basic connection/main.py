######  PROGRAM MEMANGGIL WINDOWS PYQT5 ##########################

####### memanggil library PyQt5 ##################################
#----------------------------------------------------------------#
from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import * 
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *  
import sys
#----------------------------------------------------------------#

##################################################################
#----------------deklarasi variabel------------------------------#
analog = 0
data = 0

button_status = "L"

##################################################################
#----------------mengaktifkan komunikasi serial------------------#
import sys
import serial
import threading

import time

serial_data = ""

transmit_time = 0
transmit_time_prev = 0

data_send = "L"

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


########## mengisi class table dengan instruksi pyqt5#############
#----------------------------------------------------------------#
class table(QObject):    
    def __init__(self, parent = None):
        super().__init__(parent)
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine(self)
        self.engine.rootContext().setContextProperty("backend", self)    
        self.engine.load(QUrl("main.qml"))
        sys.exit(self.app.exec_())
        
        
    @pyqtSlot(str)
    def button(self, message):
        global button_status
        print(message)
        button_status = message
    
    
    @pyqtSlot(result=float)
    def get_analog(self):  return analog
    
#----------------------------------------------------------------#


#----------------------------------------------------------------#
###############################MEMBACA DATA SERIAL##################
def serial_read(num):
    global ser_bytes
    global decoded_bytes
    global serial_data
    global data
    global analog
    
    
    
    while True:
        try:
            ser_bytes = ser.readline()
            serial_data = (ser_bytes.decode('utf-8')[:-2])
            
            print(serial_data)
                
        except:
            serial_data = serial_data
            
        
        print(serial_data)
        analog = int(serial_data)
        
#----------------------------------------------------------------#

def serial_write(num):
    global transmit_time
    global transmit_time_prev
    global data_send
    
    while True:
        transmit_time = time.time() - transmit_time_prev
        data_send = (str(button_status))
        if (transmit_time > 0.5):
            print(data_send)
            ser.write(data_send.encode())
            transmit_time_prev = time.time() 




########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":
    t1 = threading.Thread(target=serial_read, args=(10,))
    t1.start()
    
    t2 = threading.Thread(target=serial_write, args=(10,))
    t2.start()
    
    main = table()
    
    
    
    
#----------------------------------------------------------------#