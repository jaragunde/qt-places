import QtQuick 1.1
import com.nokia.meego 1.0
import 'constants.js' as UIConstants

Page {
    property string license: 'This program is free software: you can redistribute it and/or modify ' +
        'it under the terms of the GNU General Public License as published by ' +
        'the Free Software Foundation, either version 3 of the License, or ' +
        '(at your option) any later version.<br /><br />' +

        'This package is distributed in the hope that it will be useful, ' +
        'but WITHOUT ANY WARRANTY; without even the implied warranty of ' +
        'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the ' +
        'GNU General Public License for more details.<br /><br />' +

        'You should have received a copy of the GNU General Public License ' +
        'along with this program. If not, see ' +
        '<a href="http://www.gnu.org/licenses">http://www.gnu.org/licenses</a><br /><br />'

    tools: ToolBarLayout {
        ToolIcon {
            id: backIcon
            iconId: 'toolbar-back'
            onClicked: pageStack.pop()
        }
    }

    Flickable {
        id: flick
        clip: true
        anchors.fill: parent
        anchors {
            topMargin: UIConstants.DEFAULT_MARGIN
            leftMargin: UIConstants.DEFAULT_MARGIN
            rightMargin: UIConstants.DEFAULT_MARGIN
        }
        contentHeight: contentColumn.height

        Column {
            id: contentColumn
            spacing: UIConstants.DEFAULT_MARGIN
            width: parent.width

            Label {
                id: aboutVersion
                text: 'Places 0.1'
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                platformStyle: LabelStyle {
                    fontPixelSize: UIConstants.FONT_XLARGE
                }
                color: UIConstants.COLOR_FOREGROUND
            }

            Label {
                id: aboutCopyright
                text: 'Copyright © 2012 Jacobo Aragunde'
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                platformStyle: LabelStyle {
                    fontPixelSize: UIConstants.FONT_LSMALL
                    fontFamily: UIConstants.FONT_FAMILY_LIGHT
                }
                color: UIConstants.COLOR_FOREGROUND
            }

            Label {
                id: aboutText
                text: "Register interesting places in your phone so you don't forget how to get back to them."
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                platformStyle: LabelStyle {
                    fontPixelSize: UIConstants.FONT_LSMALL
                    fontFamily: UIConstants.FONT_FAMILY_LIGHT
                }
                color: UIConstants.COLOR_FOREGROUND
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: 'Licencia'
                onClicked: licenseDialog.open()
            }
        }
    }

    QueryDialog {
        id: licenseDialog
        message: license
        acceptButtonText: 'OK'
    }

    ScrollDecorator {
        flickableItem: flick
        anchors.rightMargin: -UIConstants.DEFAULT_MARGIN
    }
}
