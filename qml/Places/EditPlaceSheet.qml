import QtQuick 1.1
import com.nokia.meego 1.0

Sheet {

    acceptButtonText: "Save"
    rejectButtonText: "Cancel"

    content: Flickable {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 10
        contentWidth: col2.width
        contentHeight: col2.height
        flickableDirection: Flickable.VerticalFlick
        Column {
            id: col2
            anchors.top: parent.top
            anchors.fill: parent
            spacing: 10
            TextField {
                id: newElementName
                text: "Name"
            }
            TextField {
                id: newElementDescription
                text: "Description"

            }
        }
    }

    onAccepted: addPlace(newElementName.text,
                         newElementDescription.text,
                         43.369493, -8.407938)
}
