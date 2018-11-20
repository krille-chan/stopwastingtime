import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "components"

Page {

    header: DefaultPageHeader {
        id: header
        title: i18n.tr('Settings')
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: UbuntuColors.blue }
            GradientStop { position: 1.0; color: "lightcyan" }
        }
    }

    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        contentItem: Column {
            width: root.width
            spacing: units.gu(1)

            Icon {
                source: "../assets/logo.svg"
                width: parent.width / 2
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: units.gu(1)
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                textSize: Label.Large
                text: i18n.tr("Do you waste too much time playing computer games, watching TV and surfing the internet? You could be so much more productive. Here's a way to limit the time you're wasting: Simply decide how much downtime to award yourself.")
            }


            Row {
                id: inputRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(2)
                TextField {
                    id: minutesTextField
                    Keys.onReturnPressed: if ( button.enabled ) button.clicked()
                    text: settings.minutesPerDay !== 0 ? settings.minutesPerDay : "0"
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    width: units.gu(8)
                    focus: true
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: i18n.tr('Minutes')
                }
            }


            Button {
                id: button
                anchors.horizontalCenter: parent.horizontalCenter
                text: i18n.tr("Save")
                color: UbuntuColors.green
                width: inputRow.width
                enabled: minutesTextField.displayText !== "" && /^\d+$/.test( minutesTextField.displayText )
                onClicked: {
                    try {
                        settings.minutesPerDay = settings.minutesLeft = parseInt(minutesTextField.text)
                        settings.lastUpdate = new Date().getTime()
                        root.update ()
                        mainStack.pop()
                        if ( mainStack.depth === 0 ) mainStack.push( Qt.resolvedUrl("./MainPage.qml") )
                    }
                    catch(e) {
                        console.warn ( e )
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: units.gu(1)
                color: "#00000000"
            }

        }
    }


}
