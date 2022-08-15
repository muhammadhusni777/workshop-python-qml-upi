import QtQuick 2.12
import QtQuick.Window 2.13
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


Window {
	id : root
	width: 400
	maximumWidth : width
	minimumWidth : width
    height: 400
	maximumHeight : height
	minimumHeight : height
	title:"membuat windows"
	color : "grey"
    visible: true
    flags: Qt.Dialog
	
	
	Text{
	x: 50
	y: 30
	text : "POTENSIOMETER"
	color : "white"//"#04f8fa"
	font.pixelSize : 24
	
	
	}
	
	CircularGauge {
		id : gauge1
		x: 10
		y: 70
		height : 250
		width : 250
		value: 0
		minimumValue: 0
		maximumValue: 1023
		
		style: CircularGaugeStyle {
			labelStepSize: 100
		}
		
	}
	
	Text{
	x: 330
	y: 150
	text : "LED"
	color : "white"//"#04f8fa"
	font.pixelSize : 24
	
	
	}
	
	
	Button{
	id : button
	x:300
	y:200
	width : 100
	height : 50
	text : "off"
	
	Rectangle{
	id : button_color
	width : parent.width
	height : parent.height
	color : "red"
	
	}
	
	
	palette {
        button: "transparent"
		buttonText: "black"
	}

	onClicked:{
			if(button.text == "on"){
				text = "off";
				button_color.color = "red"	
				backend.button("L")
			}else
				if(button.text == "off"){
				text = "on";
				button_color.color = "green" 
				backend.button("H")
				}
		}
	
	
	}
	
	
	Image {
	id : zuma
	x :0
	y : 200
	width : 100
	height : 100
	source : "zuma.png"
	visible  : false
	
	}
	
	
	
	Timer{
		id:tmgauge
		interval: 50
		repeat: true
		running: true
		onTriggered: {
		gauge1.value = backend.get_analog()
		zuma.rotation = backend.get_analog()
		}
	}
	
	
	
}













