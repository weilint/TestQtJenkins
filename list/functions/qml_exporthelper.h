#ifndef QML_EXPORTHELPER_H
#define QML_EXPORTHELPER_H

#include <QtQml>
#include <QQmlContext>
#include <QDebug>


#include "qtquick2controlsapplicationviewer.h"
#include "../qml_interface.h"
#include "../objects/qml_exportpatobject.h"

extern QList<QObject *> g_exportList;
extern QList<QObject *> g_exportDisplayList;
extern QStringList g_exportModalityList;
extern QStringList g_exportStudydateList;
extern QQmlContext *g_pContext;

class QML_ExportHelper: public QObject
{
    Q_OBJECT

public:
    explicit QML_ExportHelper(QObject *parent = 0);

    Q_INVOKABLE void qmlClearExportList();
    Q_INVOKABLE void qmlAddToExportList(const QString studydate,
                                        const QString modality,
                                        const QString bodypart,
                                        const QString numseries,
                                        const QString numimg,
                                        const QString imgsource,
                                        const bool isselected);
    Q_INVOKABLE void qmlSetExportDisplayList();
    Q_INVOKABLE QML_ExportPatObject* qmlGetExportPatObject(QString modality, QString studydate);
    Q_INVOKABLE QString qmlGetBodyPart(int index);
    Q_INVOKABLE void qmlCheckModality(QString modality, bool isChecked);

};

#endif // QML_EXPORTHELPER_H
