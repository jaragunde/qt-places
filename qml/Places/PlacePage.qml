import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2
import 'constants.js' as Constants
import 'storage.js' as Storage

Page {

    property int index: -1
    property int code: -1
    property string name: ''
    property string description: ''
    property double locationLatitude: 0
    property double locationLongitude: 0

    tools: ToolBarLayout {
        ToolIcon {
            id: backIcon
            iconId: 'toolbar-back'
            onClicked: pageStack.pop()
        }
        ToolIcon {
            id: deleteIcon
            iconId: 'toolbar-delete'
            onClicked: {
                Storage.removePlace(code);
                pageStack.pop();
                placesModel.remove(index);
            }
        }
    }

    anchors {
        topMargin: appWindow.inPortrait ?
            Constants.HEADER_DEFAULT_TOP_SPACING_PORTRAIT :
            Constants.HEADER_DEFAULT_TOP_SPACING_LANDSCAPE
        leftMargin: Constants.DEFAULT_MARGIN
        rightMargin: Constants.DEFAULT_MARGIN
        bottomMargin: Constants.DEFAULT_MARGIN
    }

    Column {
        id: contentColumn
        width: parent.width
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 2 * Constants.DEFAULT_MARGIN

        Label {
            id: nameLabel
            font.weight: Font.Bold
            font.pixelSize: Constants.FONT_XXXLARGE
            text: name
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        Label {
            id: descriptionLabel
            text: description
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

    }

    Item {
        id: map
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: Constants.MAP_AREA_HEIGHT
        MapView {
            width: parent.width
            addressText: name
            mapCenter: Coordinate {
                 latitude: locationLatitude
                 longitude: locationLongitude
            }
            startCentered: true
            distance: 100

        }
    }
}
