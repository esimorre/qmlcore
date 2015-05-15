ListView {
	property bool active: false;
	height: parent.height;
	width: active ? 300 : 0;
	model: categoriesModel;
	clip: true;
	delegate: Rectangle {
		height: 40;
		width: parent.width;
		color: activeFocus ? colorTheme.activeBackgroundColor : colorTheme.backgroundColor;

		Text {
			anchors.left: parent.left;
			anchors.leftMargin: 10;
			anchors.verticalCenter: parent.verticalCenter;
			text: model.text;
			font.pointSize: 14;
		}
	}

	toggle: { this.active = !this.active; }

	Behavior on width { Animation { duration: 300; } }
}
