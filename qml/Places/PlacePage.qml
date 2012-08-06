import QtQuick 1.1
import com.nokia.meego 1.0

Page {

    property string name: ''
    property string description: ''

    tools: ToolBarLayout {
        ToolIcon {
            id: backIcon
            iconId: 'toolbar-back'
            onClicked: pageStack.pop()
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
    }
}
