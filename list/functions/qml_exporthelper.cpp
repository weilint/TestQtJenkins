#include "qml_exporthelper.h"
#include "math.h"
#include <QDebug>

#define NULL    0

QML_ExportHelper::QML_ExportHelper(QObject *parent) :
    QObject(parent)
{

}

void QML_ExportHelper::qmlClearExportList()
{
    g_exportList.clear();
    g_exportModalityList.clear();
    g_exportStudydateList.clear();
    g_exportDisplayList.clear();
}

void QML_ExportHelper::qmlAddToExportList(const QString studydate,
                                        const QString modality,
                                        const QString bodypart,
                                        const QString numseries,
                                        const QString numimg,
                                        const QString imgsource,
                                        const bool isselected)
{
    qDebug() << "is checked = " << isselected;
    QML_ExportPatObject *pExport = new QML_ExportPatObject(studydate, modality, bodypart, numseries, numimg, imgsource, isselected);
    g_exportList.append(pExport);
    g_pContext->setContextProperty(QMLExportListViewModel, QVariant::fromValue(g_exportList));
    qDebug() << "in add to export list: num of items = " << g_exportList.length();

    if (g_exportModalityList.contains(modality) == false)
    {
        g_exportModalityList.append(modality);
        g_pContext->setContextProperty(QMLExportModalityList, QVariant::fromValue(g_exportModalityList));
    }

    if (g_exportStudydateList.contains(studydate) == false)
    {
        g_exportStudydateList.append(studydate);
        g_pContext->setContextProperty(QMLExportStudyDateList, QVariant::fromValue(g_exportStudydateList));
    }
}

void QML_ExportHelper::qmlSetExportDisplayList()
{
    for (int i=0; i<g_exportModalityList.length()*g_exportStudydateList.length(); i++){
        int _modalityindex = i % g_exportModalityList.length();
        int _studydateindex = (int)(i / g_exportModalityList.length());

        QString modalityval = g_exportModalityList[_modalityindex];
        QString studydateval = g_exportStudydateList[_studydateindex];

        QML_ExportPatObject *pStudy = qmlGetExportPatObject(modalityval, studydateval);
        g_exportDisplayList.append(pStudy);
    }

    g_pContext->setContextProperty(QMLExportDisplayList, QVariant::fromValue(g_exportDisplayList));
    qDebug() << "finish qmlSetExportDisplayList";
}

QML_ExportPatObject* QML_ExportHelper::qmlGetExportPatObject(QString modality, QString studydate)
{
    qDebug() << "in qmlGetExportPatObject: " << modality << " " << studydate;

    for (int i = 0; i < g_exportList.length(); i++)
    {
        QML_ExportPatObject *pStudy = (QML_ExportPatObject *) g_exportList.at(i);
        if (pStudy->studyDate()==studydate)
        {
            if (pStudy->modality().toUpper() == modality.toUpper())
            {
                return pStudy;
            }
        }
    }
    QML_ExportPatObject *pnull = new QML_ExportPatObject("","","","","","",false);
    return pnull;
}

QString QML_ExportHelper::qmlGetBodyPart(int index)
{
    QML_ExportPatObject *exportobj = (QML_ExportPatObject *)g_exportDisplayList[index];
    if (exportobj->bodyPart() != "")
        qDebug() << exportobj->bodyPart();
    else
        qDebug() << "is null";
    return exportobj->bodyPart();
}

void QML_ExportHelper::qmlCheckModality(QString modality, bool isChecked)
{
    for (int i = 0; i<g_exportDisplayList.length() ; i++) {
        QML_ExportPatObject *exportobj = (QML_ExportPatObject *)g_exportDisplayList[i];
        if (exportobj->modality() == modality)
        {
            exportobj->setIsSelected(isChecked);
        }
    }
    //g_pContext->setContextProperty(QMLExportDisplayList, QVariant::fromValue(g_exportDisplayList));
}
