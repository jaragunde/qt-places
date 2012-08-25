import QtQuick 1.1
import com.nokia.meego 1.0
import 'storage.js' as Storage
import 'util.js' as Util

Page {
    tools: commonTools

    ListView {
        anchors.fill: parent; anchors.margins: 20

        model: ListModel {
            id: placesModel
        }
        delegate: Text {
            text: name
            MouseArea {
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
