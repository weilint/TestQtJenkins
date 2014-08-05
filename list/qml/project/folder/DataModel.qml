import QtQuick 2.1

ListModel {

    ListElement {
        categoryName: "フォルダー"
        collapsed: false

        // A ListElement can't contain child elements, but it can contain
        // a list of elements. A list of ListElements can be used as a model
        // just like any other model type.
        subItems: [
        ListElement { itemName: "全検査";      imageSource: "../res/folder_all.png"  },
        ListElement { itemName: "フラグ付き";  imageSource: "../res/folder_flag.png" },
        ListElement { itemName: "CD作成済み";  imageSource: "../res/folder_cd.png"   },
        ListElement { itemName: "送信済み";    imageSource: "../res/folder_send.png" },
        ListElement { itemName: "ゴミ箱";    imageSource: "../res/folder_waste.png" }
        ]
    }

    ListElement {
        categoryName: "スマートフォルダー"
        collapsed: false
        subItems: [
        ListElement { itemName: "SmartFolder1"; imageSource: "../res/folder_smart.png" }
        ]
    }

    ListElement {
        categoryName: "イメージサーバー"
        collapsed: false
        subItems: [
        ListElement { itemName: "イメージサーバー1";  imageSource: "../res/folder.png" }
        ]
    }

    ListElement {
        categoryName: "別のコンピューター"
        collapsed: false
        subItems: [
        ListElement { itemName: "Folder1";  imageSource: "../res/folder.png" }
        //ListElement { itemName: "test";  imageSource: "../res/folder.png" }
        ]
    }

    ListElement {
        categoryName: "パブリッシャー"
        collapsed: false
        subItems: [
        ListElement { itemName: "PP-100N 1";  imageSource: "../res/folder-publisher.png" }
        ]
    }
}
