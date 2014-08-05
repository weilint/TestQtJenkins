import QtQuick 2.0
import QtQuick.Controls 1.0

MenuItem {
    //text: flagmodel.get(counter).flagid
    checkable: true
    //iconSource: flagmodel.get(counter).flagicon
    onCheckedChanged:
    {
        flagmenu.handleFlag(checked, text)
    }
 }
