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



data1 = 0
data2 = 0
esp32_status = "inactive"

time_esp = 0
time_esp_prev = time.time()
espledcolor = "green"

datapinpwm = 0
formchar = "0"
led_status = "off"


message_time = 0
message_time_prev = time.time()


@pyqtSlot(result=int)
def get_tempo(self):
    date_time = QDateTime.currentDateTime()
    unixTIME = date_time.toSecsSinceEpoch()
    print("yes")
    #unixTIMEx = date_time.currentMSecsSinceEpoch()
    return unixTIME



class table(QQuickView):
    data1_val = pyqtSignal(str)
    espled_val = pyqtSignal(str)
    
    def __init__(self):
        super().__init__()
        self.setSource(QUrl('main.qml'))
        self.setTitle("ARDUMEKA PYTHON QML DEMO")
        
        self.rootContext().setContextProperty("table", self)
        self.setGeometry(600, 25, 700, 700)
        self.show()
        
        windows = self.rootObject()
        
        self.init_tempo()
        
        self.data1_val.connect(windows.data1_read)
        self.espled_val.connect(windows.espcolor_read)


    def init_tempo(self):
        self.tempo = QtCore.QTimer()
        self.tempo.timeout.connect(self.variable_transfer)
        self.tempo.start(500)
        
        
    def variable_transfer(self):
        global time_esp
        global espledcolor
        global message_time
        global message_time_prev
        time_esp = time.time() - time_esp_prev
        
        
        self.data1_val.emit(str(data1))
        self.espled_val.emit(str(espledcolor))
        
        self.tempo.start(50)
        
        message_time = time.time() - message_time_prev

        if (message_time > 0.5):
            print(" | form : " + str(formchar) + " | pwm : " + str(datapinpwm) +  " | led : " +
                  str(led_status) + " | esp status :" + str(esp32_status))
            message_time_prev = time.time()
            
           
    
    @pyqtSlot('QString')
    def setPwm(self, value):
        global datapinpwm
        datapinpwm = value
        #print(datapinpwm)
    
    @pyqtSlot('QString')
    def form_char(self, value):
        global formchar
        formchar = value
        #print(formchar)
    
    @pyqtSlot('QString')
    def led_status(self, value):
        global led_status
        led_status = value
        #print(led_status)


if __name__ == '__main__':
    
    app = QApplication(sys.argv)    
    
    app.setWindowIcon(QIcon("garuda.png"))
    w = table()
    sys.exit(app.exec_())