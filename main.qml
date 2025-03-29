import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Theme

Item {
  id: plugin
  property var positioningSettings: iface.findItemByObjectName('positioningSettings')
  property var mainWindow: iface.mainWindow()
  property var deviceLoaderItem: iface.findItemByObjectName("positioningDeviceItem")

  function appWideEnabled() {
    positioningSettings.egenioussEnabled = true
  }

  function appWideDisabled() {
    positioningSettings.egenioussEnabled = false
  }

  function setupEgenioussUi() {
    if ( deviceLoaderItem.item.generateName() === "Egeniouss") {
      deviceLoaderItem.item.setupLoader(egenioussConfigDialog)
    }
  }

  Component.onCompleted: {
    deviceLoaderItem.onSourceChanged.connect( setupEgenioussUi )
    setupEgenioussUi()
  }

  Component {
    id: egenioussConfigDialog

    ColumnLayout {
      width: childrenRect.width
      spacing: 8

      function setSettings(settings) {
        ipAddress.text = settings['address']
        port.text = settings['port'];
      }

      function getSettings() {
        return {
          "address": ipAddress.text.trim(),
          "port": parseInt(port.text)
        };
      }

      Image {
        id: logo
        Layout.alignment: Qt.AlignHCenter
        Layout.maximumHeight: 80
        Layout.preferredWidth: parent.width / 2
        source: "logo.svg"
        fillMode: Image.PreserveAspectFit
        sourceSize: Qt.size(width , height)
      }

      TextField {
        id: ipAddress
        placeholderText: qsTr("Address:")
        Layout.fillWidth: true
        font: Theme.defaultFont
        text: '127.0.0.1'
        inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase | Qt.ImhPreferLowercase
      }
      TextField {
        id: port
        Layout.fillWidth: true
        font: Theme.defaultFont
        text: defaultPort
        placeholderText:  qsTr("Port:")
        inputMethodHints: Qt.ImhFormattedNumbersOnly

        readonly property string defaultPort: "1235"
      }
    }
  }
}
