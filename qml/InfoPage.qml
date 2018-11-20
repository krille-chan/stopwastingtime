import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "components"

Page {

    header: DefaultPageHeader {
        title: i18n.tr('Info about Stop Wasting Time! %1 on %2').arg(version).arg(Qt.platform.os)
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

            Icon {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: parent.width / 4
                width: parent.width / 2
                height: width
                source: "../assets/logo.svg"
            }

            SettingsListItem {
                name: i18n.tr("Become a Patron")
                icon: "like"
                iconColor: UbuntuColors.red
                onClicked: Qt.openUrlExternally("https://www.patreon.com/krillechritzelius")
            }

            SettingsListItem {
                name: i18n.tr("Contributors")
                icon: "contact-group"
                onClicked: Qt.openUrlExternally("https://github.com/ChristianPauly/stopwastingtime/graphs/contributors")
            }

            SettingsListItem {
                name: i18n.tr("Source code")
                icon: "text-xml-symbolic"
                onClicked: Qt.openUrlExternally("https://github.com/ChristianPauly/stopwastingtime")
            }

            SettingsListItem {
                name: i18n.tr("License")
                icon: "x-office-document-symbolic"
                onClicked: Qt.openUrlExternally("https://github.com/ChristianPauly/stopwastingtime/blob/master/LICENSE")
            }

        }
    }

}
