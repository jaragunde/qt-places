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

    Column {
        id: contentColumn
        width: parent.width

        Text {
            id: nameLabel
            anchors {
                left: parent.left
                right: parent.right
            }
            text: name
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        Text {
            id: descriptionLabel
            anchors {
                left: parent.left
                right: parent.right
            }
            text: description
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        Item {
            id: map
            anchors {
                left: parent.left
                right: parent.right
                margins: Constants.DEFAULT_MARGIN
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
}
