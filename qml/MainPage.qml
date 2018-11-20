import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "components"

Page {

    header: DefaultPageHeader {
        id: header
        title: i18n.tr('Stop Wasting Time!')


        trailingActionBar {
            actions: [
            Action {
                iconName: "settings"
                onTriggered: mainStack.push(Qt.resolvedUrl("./SettingsPage.qml"))
            },
            Action {
                iconName: "info"
                onTriggered: mainStack.push(Qt.resolvedUrl("./InfoPage.qml"))
            }
            ]
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: UbuntuColors.blue }
            GradientStop { position: 1.0; color: "lightcyan" }
        }
    }

    Label {
        id: label
        anchors.centerIn: parent
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: units.gu(1)
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        textSize: Label.Large
        text: minutesLeft === 1 ? i18n.tr('You have 1 minute left.') : i18n.tr('You have %1 minutes left.').arg(minutesLeft)
    }

    Button {
        id: button
        anchors.top: label.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: units.gu(1)
        enabled: settings.minutesLeft > 0
        text: settings.isWasting ? i18n.tr('STOP wasting time') : i18n.tr('Start wasting time')
        onClicked: {
            root.update ()
            if ( settings.isWasting ) {
                if ( minutesLeft < 0 ) minutesLeft = 0
                settings.minutesLeft = parseInt(minutesLeft)
                settings.isWasting = false
                alarm.cancel()
            }
            else {
                settings.isWasting = new Date().getTime()
                var now = new Date().getTime() + settings.minutesLeft*60000
                alarm.date = new Date(now)
                alarm.save()
            }
        }
        color: settings.isWasting ? UbuntuColors.red : UbuntuColors.green
    }

    ProgressBar {
        indeterminate: true
        anchors.top: button.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: button.width
        visible: settings.isWasting
    }

}
