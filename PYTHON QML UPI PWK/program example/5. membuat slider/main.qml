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
	
	Slider {
		id: slider1
		x:0
		y:150
		height: 20
		width: 300
		value: 0
		from:10
		to: 255
		stepSize: 5
		orientation: Qt.Horizontal
		
		onValueChanged: {
		
		
		}
		
	}
	
	Text {
	x:300
	y:145
	text : slider1.value
	color : "#00FF00"
	font.pixelSize:24
	font.bold : true
	font.family : "Comic Sans MS"
	
	}
	
	
}













