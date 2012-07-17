import QtQuick 1.1
import com.nokia.meego 1.0

Page {

    tools: ToolBarLayout {
        ToolIcon {
            id: backIcon
            iconId: 'toolbar-back'
            onClicked: pageStack.pop()
        }
    }
}
