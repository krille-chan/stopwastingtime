import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

PageHeader {
    id: header

    StyleHints {
        foregroundColor: "white"
        backgroundColor: UbuntuColors.blue
        dividerColor: UbuntuColors.blue
    }

    leadingActionBar {
        actions: [
        Action {
            visible: mainStack.depth > 1
            iconName: "go-previous"
            onTriggered: mainStack.pop()
        }
        ]
    }
}
