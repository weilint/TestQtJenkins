#include <QDebug>
#include <QSqlQuery>
#include <qsqlerror.h>
#include "qtquick2controlsapplicationviewer.h"
#include "log.h"
#include "database.h"
#include "databasemodel.h"

int main(int argc, char *argv[])
{
    Application app(argc, argv);

    Log *log = new Log;

    // テーブル列の属性定義
    struct { QString role; QString title; int width; bool visible;} columnItem[] = {
        // Role           Title          Width       Visible
        { "Icon",        "Icon",         40,         true } ,       // 画像
        { "Patientname", "Patient Name", 120,        true } ,
        { "StudyDate",   "Study Date",   80,         true },
        { "Modality",    "Modality",     200,         true }
    };

    // 患者データベースを作る
    Database dbPatient("patient");                      // データを登録する
    QStringList fieldList;
    for( int i=0; i<sizeof(columnItem) / sizeof(columnItem[0]); i++) fieldList.append(columnItem[i].role);
    if( !dbPatient.createTable(fieldList) ) qDebug() << dbPatient.lastError();
    if( !dbPatient.insert(QStringList() << "res/emotion_amazing.png" << "Tokyo taro"     << "1991/02/03" << "CT")) qDebug() << dbPatient.lastError();
    if( !dbPatient.insert(QStringList() << "res/emotion_amazing.png" << "Osaka hanako"   << "1994/05/06" << "CT")) qDebug() << dbPatient.lastError();
    if( !dbPatient.insert(QStringList() << "res/emotion_exciting.png" << "Nagoya jiro"    << "1997/08/09" << "CT")) qDebug() << dbPatient.lastError();

    // データベースのモデル
    DatabaseModel *model = new DatabaseModel;
    // model->setObjectName("dataModel");
    model->setTable(dbPatient.tableName());
    model->generateRoleNames();
    model->select();

    // ----------------------------------------
    // QMLビューワ起動
    // ----------------------------------------
    QtQuick2ControlsApplicationViewer viewer;

    // QMLのプロパティセット
    QQmlContext *qmlContext = viewer.rootContext();
    qmlContext->setContextProperty("patientModel", model);      // TavleViewのmodelをセット 1st:QMLに定義したプロパティ  2nd:セットする値

    viewer.setMainQmlFile(QStringLiteral("qml/project/main.qml"));

    // QMLのSIGNAL連結
    QObject *qmlObject = viewer.rootObject();
    QObject::connect(qmlObject, SIGNAL(log(QString)), log, SLOT(slot_log(QString)));

    // QMLの関数CALL
    for( int i=0; i<sizeof(columnItem) / sizeof(columnItem[0]); i++) {
        // QMLテーブルに列を追加
        QMetaObject::invokeMethod(
            qmlObject,"addColumn",                              // QMLに定義した関数
            Q_ARG(QVariant, QVariant::fromValue(columnItem[i].role)),
            Q_ARG(QVariant, QVariant::fromValue(columnItem[i].title)),
            Q_ARG(QVariant, QVariant::fromValue(columnItem[i].width)),
            Q_ARG(QVariant, QVariant::fromValue(columnItem[i].visible)));
    }

    viewer.show();

    int ret = app.exec();

    delete model;
    delete log;
    return ret;
}
