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
analog = 60
input1_color = "#df1c39"
input2_color = "#df1c39"


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
    
    
    
    #####################TOMBOL QML KE PYTHON###################
    @pyqtSlot(str)
    def button1(self, message):
        print(message)
        
    @pyqtSlot(str)
    def button2(self, message):
        print(message)
        
    @pyqtSlot(str)
    def button3(self, message):
        print(message)
        
    #####################SLIDER QML KE PYTHON###################
    @pyqtSlot(str)
    def analog_output(self, message):
        print(message)
    
    ######################KIRIM DATA ANALOG KE GAUGE##############
    @pyqtSlot(result=float)
    def get_analog(self):  return analog
    
    ####################KIRIM DATA WARNA STATUS BUTTON#############
    @pyqtSlot(result=str)
    def get_input1_color(self):  return input1_color
    
    @pyqtSlot(result=str)
    def get_input2_color(self):  return input2_color

#----------------------------------------------------------------#

########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":
    main = table()
    
    
#----------------------------------------------------------------#