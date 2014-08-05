/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

// 開発メモ
// C:\Qt\5.2.1\5.2.1\msvc2010\examples\declarative\ui-components\searchbox\qml\searchbox
// を改造した。

import QtQuick 2.0

FocusScope {
    id: focusScope
    width: 250 * dp; height: 28 * dp

    property alias text: textInput.text


    BorderImage {
        source: "../res/searchbox.png"
        width: parent.width; height: parent.height
        border { left: 4 * dp; top: 4 * dp; right: 4 * dp; bottom: 4 * dp }
    }

    BorderImage {
        source: "../res/searchbox_focus.png"
        width: parent.width; height: parent.height
        border { left: 4 * dp; top: 4 * dp; right: 4 * dp; bottom: 4 * dp }
        visible: parent.activeFocus ? true : false
    }

    Text {
        id: typeSomething
        anchors.fill: parent; anchors.leftMargin: 8 * dp
        verticalAlignment: Text.AlignVCenter
        text: "Search key"
        color: "gray"
        font.italic: true
    }

    MouseArea { 
        anchors.fill: parent
        onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); } 
    }

    TextInput {
        id: textInput
        anchors { left: parent.left; leftMargin: 8 * dp; right: clear.left; rightMargin: 8 * dp; verticalCenter: parent.verticalCenter }
        focus: true
        selectByMouse: true
    }

    Image {
        id: clear
        anchors { right: parent.right; rightMargin: 8 * dp; verticalCenter: parent.verticalCenter }
        source: "../res/searchbox_clear.png"
        opacity: 0
        height: 15 * dp
        width: 15 * dp
        MouseArea { 
            anchors.fill: parent
            onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
        }
    }

    states: State {
        name: "hasText"; when: textInput.text != ''
        PropertyChanges { target: typeSomething; opacity: 0 }
        PropertyChanges { target: clear; opacity: 1 }
    }

    transitions: [
        Transition {
            from: ""; to: "hasText"
            NumberAnimation { exclude: typeSomething; properties: "opacity" }
        },
        Transition {
            from: "hasText"; to: ""
            NumberAnimation { properties: "opacity" }
        }
    ]
}
