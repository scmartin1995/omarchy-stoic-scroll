import QtQuick
import Quickshell
import qs.Commons
import qs.Ui
import "Quotes.js" as Quotes

BarWidget {
  id: root
  moduleName: "io.github.scmartin1995.stoic-scroll"

  readonly property int maxWidth: Number(setting("maxWidth", 600))
  readonly property int minWidth: 80
  // Width left between the center modules and our fixed edge; see measure()
  property real availableWidth: 0
  readonly property int windowWidth: Math.min(maxWidth, availableWidth)
  readonly property real speed: Math.max(5, Number(setting("speed", 40)))

  property int quoteIndex: 0
  readonly property string quote: Quotes.format(quoteIndex)
  readonly property string tooltipText: Quotes.tooltip(quoteIndex)
  readonly property bool hovered: mouseArea.containsMouse
  // The bar only shows a tooltip while its target reports tooltipHovered
  readonly property bool tooltipHovered: visible && hovered

  function next() {
    quoteIndex = Quotes.randomIndex(quoteIndex)
    Qt.callLater(scrollAnim.restart)
    if (tooltipHovered && bar) bar.showTooltip(root, tooltipText)
  }

  Component.onCompleted: quoteIndex = Quotes.randomIndex(-1)

  // Driven by hover state rather than enter/exit so it also works when the
  // widget reloads under a stationary cursor
  onTooltipHoveredChanged: {
    if (!bar) return
    if (tooltipHovered) bar.showTooltip(root, tooltipText)
    else bar.hideTooltip(root)
  }

  visible: !vertical && windowWidth >= minWidth
  implicitWidth: visible ? windowWidth + Style.spacing.controlPaddingX * 2 : 0
  implicitHeight: barSize

  Behavior on implicitWidth {
    NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
  }

  function barRoot() {
    var p = root
    while (p.parent) p = p.parent
    return p
  }

  // Region ("left" / "center" / "right") of the bar slot hosting this widget
  function slotRegion() {
    for (var p = parent; p; p = p.parent)
      if (p.region !== undefined && p.moduleName !== undefined) return p.region
    return ""
  }

  function collectCenterBounds(item, top, bounds) {
    var kids = item.children
    for (var i = 0; i < kids.length; i++) {
      var c = kids[i]
      if (!c || !c.visible) continue
      if (c.region === "center" && c.moduleName !== undefined) {
        if (c.width > 0) {
          var pt = c.mapToItem(top, 0, 0)
          bounds.left = Math.min(bounds.left, pt.x)
          bounds.right = Math.max(bounds.right, pt.x + c.width)
        }
        continue
      }
      collectCenterBounds(c, top, bounds)
    }
  }

  // The left/right sections are pinned to the bar edges, so our outer edge
  // stays put while our width changes; size to the gap before the center.
  function measure() {
    if (vertical) return
    var region = slotRegion()
    var top = barRoot()
    var bounds = { left: Infinity, right: -Infinity }
    if (region === "left" || region === "right") collectCenterBounds(top, top, bounds)

    var avail = maxWidth
    var reserved = Style.spacing.controlPaddingX * 2 + Style.space(12)
    if (bounds.right !== -Infinity) {
      if (region === "right") avail = root.mapToItem(top, root.width, 0).x - bounds.right - reserved
      else avail = bounds.left - root.mapToItem(top, 0, 0).x - reserved
    }
    availableWidth = Math.max(0, Math.floor(avail))
  }

  Timer {
    interval: 500
    running: !root.vertical
    repeat: true
    triggeredOnStart: true
    onTriggered: root.measure()
  }

  Item {
    id: scrollClip
    anchors.fill: parent
    anchors.leftMargin: Style.spacing.controlPaddingX
    anchors.rightMargin: Style.spacing.controlPaddingX
    clip: true

    Text {
      id: labelText
      textFormat: Text.PlainText
      anchors.verticalCenter: parent.verticalCenter
      text: root.quote
      color: root.bar ? root.bar.barForeground : Color.foreground
      font.family: root.bar ? root.bar.fontFamily : Style.font.family
      font.pixelSize: Style.font.body
      font.italic: true
      opacity: 0.85

      NumberAnimation on x {
        id: scrollAnim
        running: root.visible
        paused: running && root.hovered
        from: scrollClip.width
        to: -labelText.implicitWidth
        duration: (scrollClip.width + labelText.implicitWidth) / root.speed * 1000
        easing.type: Easing.Linear
        // restart() also emits finished; only advance after a full scroll
        onFinished: if (root.visible && labelText.x <= -labelText.implicitWidth + 1) root.next()
      }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.LeftButton
    onClicked: root.next()
  }
}
