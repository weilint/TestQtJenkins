import QtQuick 2.1
import "."  // QTBUG-34418, singletons require explicit import to load qmldir file

Text {
    horizontalAlignment: Style.titleAlignment
    font.pixelSize: Style.titleFontSize
    color: Style.titleColor
}
