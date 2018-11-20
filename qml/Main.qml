import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'stopwastingtime.christianpauly'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    // automatically anchor items to keyboard that are anchored to the bottom
    anchorToKeyboard: true

    property var version: "1.0"
    property var minutesLeft: settings.isWasting ? settings.minutesLeft - Math.round((new Date().getTime() - settings.isWasting)/60000) : settings.minutesLeft

    Settings {
        id: settings
        property var minutesPerDay: 0
        property var minutesLeft: 0
        property var lastUpdate: 0
        property var isWasting: false
    }

    Alarm{
        id: alarm
        enabled: settings.isWasting
        message: i18n.tr('STOP wasting time!')
    }

    Timer {
        interval: 60000
        running: settings.isWasting
        repeat: true
        onTriggered: update ()
    }

    function update () {
        console.log("Updating...")
        var date = new Date( parseInt(settings.lastUpdate) )
        var now = new Date()

        if ( !(date.getDate()  === now.getDate()  &&
        date.getMonth() === now.getMonth() &&
        date.getFullYear() === now.getFullYear()) ) {
            settings.minutesLeft = parseInt(settings.minutesLeft) + parseInt(settings.minutesPerDay)
            settings.lastUpdate = new Date().getTime()
        }

        minutesLeft = settings.isWasting ? settings.minutesLeft - Math.round((new Date().getTime() - settings.isWasting)/60000) : settings.minutesLeft
        if ( minutesLeft <= 0 && settings.isWasting ) {
            if ( minutesLeft < 0 ) minutesLeft = 0
            settings.minutesLeft = minutesLeft = 0
            settings.isWasting = false
        }
    }

    StackView {
        id: mainStack
        anchors.fill: parent
    }

    Component.onCompleted: {
        update ()
        if ( settings.minutesPerDay === 0 ) {
            mainStack.push( Qt.resolvedUrl("./SettingsPage.qml") )
        }
        else {
            mainStack.push( Qt.resolvedUrl("./MainPage.qml") )
        }
    }


}
