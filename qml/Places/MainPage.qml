import QtQuick 1.1
import com.nokia.meego 1.0
import 'constants.js' as Constants
import 'storage.js' as Storage
import 'util.js' as Util

Page {
    tools: commonTools

    Header { id: header }

    ListView {
        spacing: Constants.DEFAULT_MARGIN
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: Constants.DEFAULT_MARGIN
            leftMargin: Constants.DEFAULT_MARGIN
            rightMargin: Constants.DEFAULT_MARGIN
        }

        model: ListModel {
            id: placesModel
        }
        delegate: Label {
            text: name
            platformStyle: LabelStyle {
                fontPixelSize: Constants.LIST_TILE_SIZE
            }
            font.weight: Font.Bold
            color: mouseArea.pressed ? Constants.LIST_TITLE_COLOR_PRESSED : Constants.LIST_TITLE_COLOR

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: appWindow.pageStack.push(placePage,
                    {
                        index: index,
                        code: code,
                        name: name,
                        description: description,
                        locationLatitude: latitude,
                        locationLongitude: longitude
                    })
            }
        }
    }

    Component {
        id: placePage
        PlacePage { }
    }

    Sheet {
        id: sheet

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

    function addPlace(name, description, latitude, longitude) {
        var place = new Util.Place(0, name, description, latitude, longitude);
        Storage.savePlace(place);
        placesModel.append(place);
    }

    function openNewPlaceSheet() {
        sheet.open();
    }

    Component.onCompleted: {
        //init DB
        Storage.initialize();
        //load places and put in ListModel
        var placesList = Storage.loadPlaces();
        for(var i in placesList) {
            placesModel.append(placesList[i]);
        }
    }
}
