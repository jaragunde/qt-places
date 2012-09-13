import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2
import 'constants.js' as Constants

Sheet {

    acceptButtonText: "Save"
    rejectButtonText: "Cancel"

    content: Column {
        width: parent.width
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: appWindow.inPortrait ?
                Constants.HEADER_DEFAULT_TOP_SPACING_PORTRAIT :
                Constants.HEADER_DEFAULT_TOP_SPACING_LANDSCAPE
            leftMargin: Constants.DEFAULT_MARGIN
            rightMargin: Constants.DEFAULT_MARGIN
            bottomMargin: Constants.DEFAULT_MARGIN
        }
        spacing: Constants.DEFAULT_MARGIN

        Column {
            width: parent.width
            spacing: 0

            Label {
                font.pixelSize: Constants.FONT_SMALL
                text: "Name"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
            TextField {
                id: newElementName
                width: parent.width
            }
        }

        Column {
            width: parent.width
            spacing: 0

            Label {
                font.pixelSize: Constants.FONT_SMALL
                text: "Description"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
            TextArea {
                id: newElementDescription
                width: parent.width
                height: Constants.TEXT_AREA_HEIGHT
            }
        }

        Item {
            anchors {
                left: parent.left
                right: parent.right
            }
            height: Constants.MAP_AREA_HEIGHT
            MapEditView {
                id: newPlaceMap
                width: parent.width
                startCentered: true
                distance: 100
            }
        }
    }

    onAccepted: addPlace(newElementName.text,
                         newElementDescription.text,
                         newPlaceMap.getSelected().latitude,
                         newPlaceMap.getSelected().longitude)
}
