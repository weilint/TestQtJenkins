import QtQuick 2.0

Rectangle{
    id: root
    anchors.top: parent.top
    anchors.right: parent.right

    width: stacker_row.width + 5*dp
    height:finishedJobschkbox.height
    //color: "lightgray"
    color: "transparent"

    Row{
        id: stacker_row
        Image{
            id: stacker_1_img
            width:20*dp
            height:20*dp

            fillMode: Image.PreserveAspectFit
            source: "../res/stacker_ok.png"
        }

        Text{
            id: stacker_1_text
            text:"スタッカー１: CD-R"
        }

        Rectangle{
            id: stacker_separater_1
            width:20*dp
            height:20*dp
        }

        Image{
            id: stacker_2_img
            width:20*dp
            height:20*dp

            fillMode: Image.PreserveAspectFit
            source: "../res/stacker_warning.png"
        }
        Text{
            id: stacker_2_text
            text:"スタッカー２: DVD"
        }

        Rectangle{
            id: stacker_separater_2
            width:20*dp
            height:20*dp
        }

        Image{
            id: stacker_3_img
            width:20*dp
            height:20*dp

            fillMode: Image.PreserveAspectFit
            source: "../res/stacker_output.png"
        }
        Text{
            id: stacker_3_text
            text:"スタッカー３: 排出先"
        }

    }
}
