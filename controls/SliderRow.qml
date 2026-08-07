import QtQuick
import qs.Ui
import qs.Commons

// Labelled slider in the shape the audio panel uses: a section header on the
// left, the live value on the right, and the track on its own line below at
// full width. Brightness, volume and temperature all render through this so
// they cannot drift apart.
Column {
  id: sliderRow

  property QtObject bar: null
  property string label: ""
  property string valueText: ""
  property real value: 0
  property real minimum: 0
  property real maximum: 1
  property real step: 0.05

  readonly property color fg: bar ? bar.foreground : Color.foreground
  readonly property string family: bar ? bar.fontFamily : Style.font.family

  signal moved(real value)
  signal released(real value)

  spacing: Style.spacing.sm

  Item {
    width: parent.width
    implicitHeight: Math.max(header.implicitHeight, valueLabel.implicitHeight)

    PanelSectionHeader {
      id: header
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      text: sliderRow.label
      foreground: sliderRow.fg
      fontFamily: sliderRow.family
    }

    Text {
      textFormat: Text.PlainText
      id: valueLabel
      anchors.right: parent.right
      anchors.rightMargin: Style.spacing.md
      anchors.verticalCenter: parent.verticalCenter
      text: sliderRow.valueText
      color: Qt.darker(sliderRow.fg, 1.4)
      font.family: sliderRow.family
      font.pixelSize: Style.font.caption
      font.bold: true
    }
  }

  PanelSlider {
    id: slider
    width: parent.width
    bar: sliderRow.bar
    minimum: sliderRow.minimum
    maximum: sliderRow.maximum
    step: sliderRow.step
    value: sliderRow.value

    onMoved: function(value) { sliderRow.moved(value) }
    onReleased: function(value) { sliderRow.released(value) }
  }
}
