import QtQuick
import qs.Ui
import qs.Commons

// One line in the settings device browser: add or remove a favorite, and for
// rows already in the list, move it up or down.
CursorSurface {
  id: row

  required property string entityId
  required property string name
  required property string icon
  required property string detail
  required property bool favorite
  required property bool reorderable
  property var service: null
  property string family: Style.font.menuFamily

  implicitHeight: content.implicitHeight + Style.space(10)

  HoverHandler {
    id: hover
    onHoveredChanged: row.hasCursor = hovered
  }

  Item {
    id: content
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: Style.space(8)
    anchors.rightMargin: Style.space(8)
    anchors.verticalCenter: parent.verticalCenter
    implicitHeight: Math.max(glyph.implicitHeight, labels.implicitHeight,
                             actions.implicitHeight)

    Text {
      textFormat: Text.PlainText
      id: glyph
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      width: Style.space(22)
      text: row.icon
      color: Color.muted
      font.family: row.family
      font.pixelSize: Style.font.body
      horizontalAlignment: Text.AlignHCenter
    }

    Column {
      id: labels
      anchors.left: glyph.right
      anchors.leftMargin: Style.space(8)
      anchors.right: actions.left
      anchors.rightMargin: Style.space(8)
      anchors.verticalCenter: parent.verticalCenter
      spacing: Style.space(1)

      Text {
        textFormat: Text.PlainText
        width: parent.width
        text: row.name
        color: Color.foreground
        font.family: row.family
        font.pixelSize: Style.font.bodySmall
        elide: Text.ElideRight
      }

      Text {
        textFormat: Text.PlainText
        width: parent.width
        text: row.detail
        color: Color.muted
        font.family: row.family
        font.pixelSize: Style.font.caption
        elide: Text.ElideRight
      }
    }

    Row {
      id: actions
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      spacing: Style.space(4)

      PanelActionButton {
        anchors.verticalCenter: parent.verticalCenter
        visible: row.reorderable
        iconText: "󰅃"                       // md-chevron_up
        tooltipText: "Move up"
        foreground: Color.muted
        fontFamily: row.family
        onClicked: if (row.service) row.service.moveFavorite(row.entityId, -1)
      }

      PanelActionButton {
        anchors.verticalCenter: parent.verticalCenter
        visible: row.reorderable
        iconText: "󰅀"                       // md-chevron_down
        tooltipText: "Move down"
        foreground: Color.muted
        fontFamily: row.family
        onClicked: if (row.service) row.service.moveFavorite(row.entityId, 1)
      }

      PanelActionButton {
        anchors.verticalCenter: parent.verticalCenter
        // A filled star for a favorite, an outline for everything else, so
        // the state is legible without relying on colour alone.
        iconText: row.favorite ? "󰓎" : "󰓒"   // md-star / md-star_outline
        tooltipText: row.favorite ? "Remove from panel" : "Add to panel"
        foreground: row.favorite ? Color.foreground : Color.muted
        fontFamily: row.family
        onClicked: if (row.service) row.service.toggleFavorite(row.entityId)
      }
    }
  }
}
