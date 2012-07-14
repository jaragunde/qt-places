import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    tools: commonTools

    ListView {
        anchors.fill: parent; anchors.margins: 20

        model: PlacesModel {}
        delegate: Text {
            text: name
            MouseArea {
                anchors.fill: parent
                onClicked: parent.text = "clicked"
            }
        }
    }
}
