# Add more folders to ship with the application, here
folder_01.source = qml/project
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += sql
win32 {
    RC_ICONS = res/list_icon.ico
}

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    objects/qml_editinfoobject.cpp \
    objects/qml_studylistobject.cpp \
    functions/qml_studylisthelper.cpp \
    functions/qml_studylisthelper_edit.cpp \
    functions/qml_studylisthelper_test.cpp \
    objects/qml_imagelistobject.cpp \
    objects/qml_serieslistobject.cpp \
    functions/qml_studylisthelper_preview.cpp \
    iniparam.cpp \
    functions/qml_studylisthelper_search.cpp \
    searchstudykey.cpp \
    common_functions.cpp \
    objects/qml_flagobject.cpp \
    objects/qml_exportpatobject.cpp \
    functions/qml_exporthelper.cpp \
    functions/qml_studylisthelper_viewer.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2controlsapplicationviewer/qtquick2controlsapplicationviewer.pri)
qtcAddDeployment()

#win32 {
#        LIBS	+= -l../lib/MakeThumbnail
#}

OTHER_FILES += \
    qml/project/folder/DataModel.qml \
    qml/project/toolbar/InternalButton.qml \
    qml/project/dicomedit/extra.qml \
    qml/project/toolbar/CustomMenuItem.qml \
    qml/project/export/PatientDataModel.qml \
    res/list_icon.ico \
    qml/project/info/InfoEditComboBox2.qml \
    qml/project/publisher/PublisherQueue.qml

HEADERS += \
    qml_interface.h \
    objects/qml_studylistobject.h \
    objects/qml_editinfoobject.h \
    functions/qml_studylisthelper.h \
    objects/qml_imagelistobject.h \
    objects/qml_serieslistobject.h \
    objects/qml_editinfoobject.h \
    objects/qml_imagelistobject.h \
    objects/qml_serieslistobject.h \
    objects/qml_studylistobject.h \
    objects/studyeditobject.h \
    functions/qml_serieslisthelper.h \
    functions/qml_studylisthelper.h \
    iniparam.h \
    searchstudykey.h \
    common_functions.h \
    objects/qml_flagobject.h \
    objects/qml_exportpatobject.h \
    functions/qml_exporthelper.h
