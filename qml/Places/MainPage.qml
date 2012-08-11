import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    tools: commonTools

    ListView {
        anchors.fill: parent; anchors.margins: 20

        model: PlacesModel {
            id: placesModel
        }
        delegate: Text {
            text: name
            MouseArea {
                anchors.fill: parent
                onClicked: appWindow.pageStack.push(placePage,
                    {
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

    function addPlace() {
        placesModel.append({
            "name": "New place",
            "description": "New description"
        });
    }
}
