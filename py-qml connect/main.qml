import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


Rectangle {
	id: root
	visible: true
	width: 1380
	height: 800
	color:"grey"
	property bool fullscreen: false
	
	
	
	
	Rectangle{
	x:0
	y:0
	width:800
	height:800
	color: "red"
	
	Image{
          id: garuda
          x:400
		  y:50
		  width: 300
          height: 300             
          source:"garuda.png"
		}
	
	
	
	}
	
	Rectangle{
	x:0
	y:400
	width:800
	height:800
	color: "white"
	}
	
	Text {
			x : 150
			y : 20
			id: ardumeka
			text: "ARDUMEKA BASIC QML part 1"
			font.family: "Helvetica"
			
			font.pointSize: 17
			font.bold: true 
			color: "black"
		}
	
	Text {
			x : 0
			y : 60
			id: textinput1
			text: "Text input : "
			font.family: "Helvetica"
			
			font.pointSize: 17
			font.bold: true 
			color: "navy"
		}
		
	
	TextField {
			x : 150
			y : 60
			id: textinputfield1
			text: "0"
			font.family: "Helvetica"
			
			font.pointSize: 12
			font.bold: true 
			color: "black"
			
			
			
		}
		
	Button {
		id: btsubmit
		x :300
		y :60
		text: "submit"
		//font.color : "white"
		palette {
        button: "red"
		buttonText: "white"
    }
	onClicked:{
	table.form_char(textinputfield1.text)
	}
	
	}
	
	Text {
			x : 0
			y : 130
			id: textgauge
			text: "Gauge : "
			font.family: "Helvetica"
			
			font.pointSize: 17
			font.bold: true 
			color: "navy"
		}
	
	
	Rectangle {
		id:rect1
		x: 100
		y: 160
		width: 150
		height: 200
		color: "red"
		//color: "#969696"
		CircularGauge {
			id: gauge1
			x:0
			y:50
			//value:66
			width: 150
			height: 150
			maximumValue: 100
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style
				labelStepSize: 20

				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						ctx.beginPath();
						ctx.strokeStyle = "#ff8000";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(120) - 90), degreesToRadians(valueToAngle(250) - 90));
						ctx.stroke();
					}
				}

				tickmark: Rectangle {
					visible: styleData.value < 80 || styleData.value % 10 == 0
					implicitWidth: outerRadius * 0.02
					antialiasing: true
					implicitHeight: outerRadius * 0.06
					color: styleData.value >= 120 ? "#ff8000" : "#e5e5e5"
				
				}

				minorTickmark: Rectangle {
					visible: styleData.value < 80 || styleData.value % 20 == 0
					implicitWidth: outerRadius * 0.01
					antialiasing: true
					implicitHeight: outerRadius * 0.05
					color: "#e5e5e5"
				}

				tickmarkLabel:  Text {
					font.pixelSize: 12//Math.max(20, outerRadius * 0.09)
					text: styleData.value
					
					color: styleData.value >= 80 ? "#ff8000" : "#e5e5e5"
					antialiasing: true
				}

				needle: Rectangle {
					y: outerRadius * 0.15
					implicitWidth: outerRadius * 0.03
					implicitHeight: outerRadius * 0.9
					antialiasing: true
					color: "#00ff00"
				}

			}
			Rectangle {
				id:rectsg1
				anchors.horizontalCenter: parent.horizontalCenter
				y: 100
				width: 30
				height: 40
				color: "red"
				Text {
					id:textgauge1
					anchors.horizontalCenter: parent.horizontalCenter
					text: Math.floor(gauge1.value)
					font.family: "Helvetica"
					font.pointSize: 14
					color: "#00ff00"
				}
			}
		}
	}
	
	
	Text {
			x : 0
			y : 450
			id: slidertext
			text: "slider : "
			font.family: "Helvetica"
			
			font.pointSize: 17
			font.bold: true 
			color: "navy"
		}
	
	
	
	Rectangle
	{
	x:80
	y: 500
	height: 35
	width : 310
	color : "grey"
	Slider {
		id: slider1
		y:5
		height: 20
		width: 300
		//value: 80
		to: 255
		stepSize: 5
		
		onValueChanged: {
		table.setPwm(value)
		//table.form_char(textinputfield1.text)
		
		}
		
		}
	
	}
	
	
	Text {
			x : 0
			y : 550
			id: buttontext
			text: "button : "
			font.family: "Helvetica"
			
			font.pointSize: 17
			font.bold: true 
			color: "navy"
		}
	
	Button {
		id: bt00
		x :10
		y :600
		text: "state 1"
		//font.color : "white"
		palette {
        button: "red"
		buttonText: "white"
    }
		 
		onClicked:{
			if(bt00.text == "state 1"){
				text = "state 2";
				table.led_status("on")
				
			}else
				if(bt00.text == "state 2"){
					text = "state 1";
					table.led_status("off")
				}
		}
    }
	
	Image{
          id: esp32
          x:450
		  y:500
		  width: 100
          height: 100             
          source:"esp32.png"
		}
		
		
	Text {
			x : 450
			y : 450
			id: espconn
			text: "esp32 connection :"
			font.family: "Helvetica"
			
			font.pointSize: 17
			font.bold: true 
			color: "navy"
		}
	
	
		StatusIndicator {
                id: statusIndicator
                x: 600
                y: 500
                width: 80
                height: 80
				active : true
                color: "red"
                
            }
	
	 function data1_read(text) {
        gauge1.value = text;
    }
	
	function espcolor_read(text){
		statusIndicator.color = text
	
	}
	
	
	
		
	
	
}
	