// MapView based on:
// https://github.com/spenap/porcorunha

import QtQuick 1.1
import QtMobility.location 1.2
import com.nokia.meego 1.0
import 'constants.js' as Constants

// Pinch zoom behaviour from
// http://developer.qt.nokia.com/wiki/QML_Maps_with_Pinch_Zoom

Item {
    id: mapComponent
    height: Constants.MAP_AREA_HEIGHT

    property Coordinate mapCenter: positionSource.position.coordinate
    property Coordinate selected: mapCenter
    property Coordinate lowerLeftCoordinate: Coordinate { }
    property Coordinate upperRightCoordinate: Coordinate { }
    property real distance: 1000
    property bool startCentered: false
    property bool drawPolyline: false
    property bool drawLandmarks: true

    property string addressText: ''

    property ListModel landmarksModel

    property bool interactive: true
    property bool fullscreen: interactive

    signal clicked()

    Behavior on height {
        NumberAnimation { duration: 100; easing.type: Easing.InOutQuad }
    }

    Behavior on width {
        NumberAnimation { duration: 100; easing.type: Easing.InOutQuad }
    }

    function fitContentInMap() {
        var minLat = 100, minLon = 100
        var maxLat = -100, maxLon = -100

        for (var i = 0; i < landmarksModel.count; i ++) {
            minLat = Math.min(minLat, landmarksModel.get(i).lat)
            minLon = Math.min(minLon, landmarksModel.get(i).lon)
            maxLat = Math.max(maxLat, landmarksModel.get(i).lat)
            maxLon = Math.max(maxLon, landmarksModel.get(i).lon)
        }
        mapCenter.latitude = (minLat + maxLat) / 2
        mapCenter.longitude  = (minLon + maxLon) / 2

        lowerLeftCoordinate.latitude = minLat
        lowerLeftCoordinate.longitude = minLon

        upperRightCoordinate.latitude = maxLat
        upperRightCoordinate.longitude = maxLon

        distance = lowerLeftCoordinate.distanceTo(upperRightCoordinate)
        map.center = mapCenter
    }

    function getZoomLevel(distance) {

        if (distance > 3500) {
            return 13
        } else if (distance > 2000) {
            return 13.5
        } else if (distance > 1500) {
            return 14
        } else if (distance > 1000) {
            return 14.5
        } else if (distance > 500) {
            return 15
        } else if (distance > 250) {
            return 15.5
        } else {
            return 16
        }
    }

    Map {
        id: map
        plugin: Plugin { name: 'nokia' }
        connectivityMode: Map.HybridMode
        size {
            width: parent.width
            height: parent.height
        }
        smooth: true
        zoomLevel: getZoomLevel(distance)
        center: mapCenter

        MapCircle {
            id: positionInnerCircle
            center: mapCenter
            radius: 450 / map.zoomLevel
            color: Constants.MAP_POSITION_INNER_CIRCLE_COLOR
            border {
                width: 1
                color: Constants.MAP_POSITION_OUTER_CIRCLE_COLOR
            }
        }

        MapCircle {
            id: positionOuterCircle
            center: mapCenter
            radius: 750 / map.zoomLevel
            color: 'transparent'
            border {
                width: 2
                color: Constants.MAP_POSITION_OUTER_CIRCLE_COLOR
            }
        }

        MapMouseArea {
            anchors.fill: parent
            onClicked: mapComponent.clicked()
        }
    }

    PinchArea {
        id: pinchArea
        enabled: interactive
        anchors.fill: parent

        property double initialZoom

        function calcZoomDelta(zoom, percent) {
            return zoom + 3 * Math.log(percent)
        }

        onPinchStarted: {
            initialZoom = map.zoomLevel
        }

        onPinchUpdated: {
            map.zoomLevel = calcZoomDelta(initialZoom, pinch.scale)
        }

        onPinchFinished: {
            map.zoomLevel = calcZoomDelta(initialZoom, pinch.scale)
        }
    }

    MouseArea {
        id: mouseArea
        enabled: interactive
        anchors.fill : parent

        onReleased: {
            selected = map.toCoordinate(Qt.point(mouse.x, mouse.y))
            positionInnerCircle.center = selected;
            positionOuterCircle.center = selected;
        }
    }

    PositionSource {
        id: positionSource
        active: platformWindow.active
    }

    function getSelected() {
        return selected;
    }
}
