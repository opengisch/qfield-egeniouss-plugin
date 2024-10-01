import QtQuick
import QtQuick.Controls

Item {
  id: plugin
  property var positioningSettings: iface.findItemByObjectName('positioningSettings')
  
  function appWideEnabled() {
    positioningSettings.egenioussEnabled = true
  }

  function appWideDisabled() {
    positioningSettings.egenioussEnabled = false
  }
}
