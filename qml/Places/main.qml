import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    MainPage {
        id: mainPage
    }

    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-add"
            onClicked: {
                mainPage.openNewPlaceSheet();
            }
        }
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("Reset database")
                onClicked: {
                    confirmationDialog.open();
                }
            }
            MenuItem {
                text: qsTr("Acerca de")
                onClicked: appWindow.pageStack.push(aboutPage)
            }
        }
    }

    QueryDialog {
        id: confirmationDialog
        message: "This will delete all stored places. Are you sure?"
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        onAccepted: {
            mainPage.clearDB();
        }
    }

    Component {
        id: aboutPage
        AboutPage { }
    }
}
