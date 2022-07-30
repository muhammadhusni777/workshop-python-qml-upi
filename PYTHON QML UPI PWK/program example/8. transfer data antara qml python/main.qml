import QtQuick 2.12
import QtQuick.Window 2.13
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


Window {
	id : root
	width: 1000
	maximumWidth : width
	minimumWidth : width
    height: 600
	maximumHeight : height
	minimumHeight : height
	title:"Arduino PyQt5 GUI"
	color : "#000212"
    visible: true
    flags: Qt.Dialog
	
	Image{
	x:20
	y:10
	width : 150
	height : 100
	source : "arduino.png"
	
	}
	
	Image{
	x:850
	y:10
	width : 100
	height : 100
	source : "pyqt.png"
	
	}
	
	
	
	
	Rectangle{
	x: 200
	y:0
	width : 600
	height : 130
	color : "#122e55"
	
	}
	
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:0
	text : "ARDUINO PyQt5 GUI"
	color : "white"
	font.pixelSize : 50
	}
	
	
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:60
	text : "written by : Muhammad Husni"
	color : "white"//"#04f8fa"
	font.pixelSize : 24
	}
	
	
	
	

	Rectangle{
	x: 10
	y: 150
	width: 300
	height:400
	color: "#122e55"
	
	Text{
	x:0
	y:0
	text:"ANALOG OUTPUT"
	font.pixelSize:30
	color: "white"
	}
	
	CircularGauge {
		id : gauge1
		x: 0
		y: 50
		height : 300
		width : 300
		value: slider1.value
		minimumValue: 0
		maximumValue: 100
		
		style: CircularGaugeStyle {
			labelStepSize: 10
			
			
			needle: Rectangle {
					y: outerRadius * 0.15
					implicitWidth: outerRadius * 0.03
					implicitHeight: outerRadius * 0.9
					antialiasing: true
					color: "#04f8fa"
				}
		}
		
	}
	
	Slider {
		id: slider1
		x:0
		y:360
		height: 20
		width: 300
		value: 0
		from:0
		to: 100
		stepSize: 1
		orientation: Qt.Horizontal
		onValueChanged: {
		backend.analog_output(value)
		
		}
	}


	}




	Rectangle{
		x: 350
		y: 150
		width: 400
		height:400
		color: "#122e55"
	
		Text{
			x:0
			y:0
			text:"DIGITAL INPUT OUTPUT"
			font.pixelSize:30
			color: "white"
		}
		
		
		Text{
			x:0
			y:55
			text:"OUTPUT 1 :"
			font.pixelSize:22
			color: "white"
		}
		
		
		Button {
		id: button1
		x :120
		y :50
		width : 250
		text: "off"
		font.pixelSize : 20
		
		Rectangle{
			id:button1_color
			width : parent.width
			height: parent.height
			color:"#df1c39"
		}
		
		
		palette {
      		button: "transparent"
			buttonText: "black"
		}
		
		onClicked:{
			if(button1.text == "on"){
				text = "off";
				button1_color.color = "#df1c39"
				backend.button1("off")
				
			}else
				if(button1.text == "off"){
				text = "on";
				button1_color.color = "#04f8fa" 
				backend.button1("on")
				}
		}
			
			
	}
	
		
		Text{
			x:0
			y:115
			text:"OUTPUT 2 :"
			font.pixelSize:22
			color: "white"
		}
		
		
		Button {
		id: button2
		x :120
		y :110
		width : 250
		text: "off"
		font.pixelSize : 20
		
		Rectangle{
			id:button2_color
			width : parent.width
			height: parent.height
			color:"#df1c39"
		}
		
		
		palette {
      		button: "transparent"
			buttonText: "black"
		}
		
		onClicked:{
			if(button2.text == "on"){
				text = "off";
				button2_color.color = "#df1c39"
				backend.button2("off")
				
				
			}else
				if(button2.text == "off"){
				text = "on";
				button2_color.color = "#04f8fa" 
				backend.button2("on")
				}
		}
			
			
	}
	
	
		Text{
			x:0
			y:175
			text:"OUTPUT 3 :"
			font.pixelSize:22
			color: "white"
		}
		
		
		Button {
		id: button3
		x :120
		y :170
		width : 250
		text: "off"
		font.pixelSize : 20
		
		Rectangle{
			id:button3_color
			width : parent.width
			height: parent.height
			color:"#df1c39"
		}
		
		
		palette {
      		button: "transparent"
			buttonText: "black"
		}
		
		onClicked:{
			if(button3.text == "on"){
				text = "off";
				button3_color.color = "#df1c39"
				backend.button3("off")
				
			}else
				if(button3.text == "off"){
				text = "on";
				button3_color.color = "#04f8fa" 
				backend.button3("on")
				}
		}
			
			
	}
	
	
	Rectangle{
			id:sensor1_color
			x: 30
			y:250
			width : 120
			height: 130
			color: backend.get_input1_color()
			
			Image{
			width : parent.width
			height : 90
			source:"sensor.png"
			}
			Text {
			anchors.horizontalCenter: parent.horizontalCenter
			y: 95
			text : "INPUT 1"
			color : "white"
			font.pixelSize : 23
			}
			
		}
	
	
	Rectangle{
			id:sensor2_color
			x: 220
			y:250
			width : 120
			height: 130
			color:backend.get_input2_color()
			
			Image{
			width : parent.width
			height : 90
			source:"sensor.png"
			}
			
			Text {
			anchors.horizontalCenter: parent.horizontalCenter
			y: 95
			text : "INPUT 2"
			color : "white"
			font.pixelSize : 23
			}
			
		}
	
	
	
	}

	
	Rectangle{
		x: 800
		y: 150
		width: 180
		height:400
		color: "#122e55"
	
		Text{
			anchors.horizontalCenter: parent.horizontalCenter
			y:0
			text:"ANALOG INPUT"
			font.pixelSize:24
			color: "white"
		}
		
		
		Gauge {
		id : gauge2
		x: 30
		y: 45
		height : 270
		width : 150
		minimumValue: 0
		value: backend.get_analog()
		maximumValue: 100
		tickmarkStepSize: 20
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "#04f8fa"
				implicitWidth: 70
			}	
		
		}
		
		
		
	}
	
	Text{
		anchors.horizontalCenter: parent.horizontalCenter
		y:330
		text: gauge2.value
		font.pixelSize:33
		color :"white"
	}
	
	
	
	}
	
	
	
	Text{
	x:0
	y:570
	text:"FREE SOFTWARE, FOR EDUCATIONAL PURPOSE"
	font.pixelSize:20
	
	color :"#04f8fa"
	}
	
	
}













