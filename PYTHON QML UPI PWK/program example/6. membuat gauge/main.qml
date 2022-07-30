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
	
	CircularGauge {
		id : gauge1
		x: 10
		y: 70
		height : 250
		width : 250
		value: 0
		minimumValue: 0
		maximumValue: 100
		
		style: CircularGaugeStyle {
			labelStepSize: 10
		}
		
	}
	
	Gauge {
		id : gauge2
		x: 300
		y: 70
		height : 250
		width : 250
		minimumValue: 0
		value: 50
		maximumValue: 100
		tickmarkStepSize: 20
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "#e85d08"
				implicitWidth: 16
			}
		}
	}
	
}













