#ifndef QML_SERIESLISTHELPER_H
#define QML_SERIESLISTHELPER_H

#include "../objects/qml_imagelistobject.h"
#include "../objects/qml_serieslistobject.h"

#include <QObject>

//　Global values ------------------

extern int g_currentStudyIndex;
extern QList<QObject *> g_studyList;  //QML_StudyListObject
extern QList<QObject *> g_seriesList;  //QML_SeriesListObject

extern QtQuick2ControlsApplicationViewer *g_pViewer;
extern QQmlContext *g_pContext;
//---------------------------------


class qml_serieslisthelper : public QObject
{
    Q_OBJECT
public:
    explicit qml_serieslisthelper(QObject *parent = 0);

signals:

public slots:

};

#endif // QML_SERIESLISTHELPER_H
