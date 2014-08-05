#include <QtSql>
#include "dicom.h"
#include "database.h"

// --------------------------------------------------------------------------------
// データベーステーブル(今のところ、別モジュールで参照してない)
namespace DBT
{
    const QString PATIENT               = "patient";
    const QString STUDY                 = "study";
    const QString SERIES                = "series";
    const QString IMAGE                 = "image";
}

// --------------------------------------------------------------------------------
Database::Database(QObject *parent) :
    QObject(parent)
{
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    // m_db.setDatabaseName("C:/Users/Nagata/Desktop/aoc7.sqlite");
    m_db.setDatabaseName(":memory:");

    m_patientList
        << DBF::PATIENTID                          // Primary key: PatientID[0010,0020]
        << DBF::PATIENTNAME << DBF::BIRTHDATE << DBF::PATIENTSEX << "[0010,1000]"
        << DBF::PATIENT_THUMB
        << DBF::PATIENT_NUMOF_STUDIES << DBF::PATIENT_NUMOF_SERIES << DBF::PATIENT_NUMOF_IMAGES ;

    m_studyList
       << DBF::STUDYINSTANCEUID                    // Primary key: StudyInstanceUID[0020,000D]
       << DBF::PATIENTID                           // Primary key: PatientID[0010,0020] (patientテーブルとのリレーション用)
       << "[0008,0060]" << "[0008,0020]" << "[0018,0015]" << "[0010,1010]"
       << "[0020,0010]" << "[0008,0050]" << "[0008,0080]" << "[0008,0090]"<< "[0008,1030]" << "[0008,1060]"
       << "[0018,5100]" << "[0020,0060]" << "[0020,0011]" << "[0008,103E]"
       << DBF::STUDY_THUMB
       << DBF::STUDY_NUMOF_SERIES << DBF::STUDY_NUMOF_IMAGES;

    m_seriesList
       << DBF::SERIESINSTANCEUID                   // Primary key: SeriesInstanceUID [0020,000E]
       << DBF::STUDYINSTANCEUID                    //              StudyInstanceUID [0020,000D]
       << DBF::SERIES_THUMB
       << DBF::SERIES_NUMOF_IMAGES;

    m_imageList
       << DBF::SOPINSTANCEUID                      // Primary key: SOPInstanceUID [0008,0018]
       << DBF::SERIESINSTANCEUID                   //              SeriesInstanceUID [0020,000E]
       << DBF::VIEWPOSITION << DBF::LATERALITY     // マンモ画像用
       << DBF::IMAGE_THUMB;
}

// --------------------------------------------------------------------------------
Database::~Database()
{
    m_db.close();
}

// --------------------------------------------------------------------------------
QStringList Database::dicomValueList(QString dicomFileName, QStringList dicomTagList)
{
    // DICOMタグに対応する値を取得する
    // [IN]     ficomFileName
    //          dicomTagList    [xxxx,yyyy]書式のリスト形式
    // [RET]    dicomTagListに対応するdicom値リスト。dicomTagListの要素数と同じ。
    QStringList valueList;

    Dicom dicom(this, dicomFileName);
    if(dicom.error().isEmpty()) {
        foreach (QString tag, dicomTagList) {
            QString value;
            if( dicom.tagValue(tag.mid(1,9), &value, false) ) {
                valueList.append(value);
            } else {
                valueList.append("");
            }
        }

    } else {
        for(int i=0; i<dicomTagList.count(); i++) valueList.append("");
    }

    return valueList;
}

// --------------------------------------------------------------------------------
QStringList Database::patientTagList()
{
    return m_patientList;
}

// --------------------------------------------------------------------------------
QStringList Database::studyTagList()
{
    QStringList tagList = m_studyList;
    Q_ASSERT(tagList.at(1) == DBF::PATIENTID);
    tagList.removeAt(1);                        // F_PATIENTIDはリレーション用なので除外する
    return tagList;
}

// --------------------------------------------------------------------------------
bool Database::createTable(QString table, QStringList primaryFiledList, QStringList fieldList, QString *sqlInsert)
{
    // DBにテーブルを新規作成する
    // [IN]     table       テーブル
    //          primaryFieldList    主キーフィールド リスト
    //          fieldList           フィールド リスト
    // [OUT]    sqlInsert   INSERT文
    // [RET]    true:       success
    //          false:      error
    QSqlQuery query;
    query.exec( QString("DROP TABLE %1;").arg(table) );             // DB削除
    QString sql = QString("CREATE TABLE %1(").arg(table);           // patient用SQL文 CREATE
    *sqlInsert = QString("INSERT INTO %1(").arg(table);             // patient用SQL文 INSERT
    QString sqlValues = "VALUES(";

    foreach(QString str, fieldList) {

        // データタイプ TEXT/INTEGER
        QString type = "TEXT";
        QString intType = DBF::PATIENT_NUMOF_SERIES + DBF::PATIENT_NUMOF_IMAGES  + DBF::STUDY_NUMOF_SERIES + DBF::STUDY_NUMOF_IMAGES + DBF::SERIES_NUMOF_IMAGES;
        if( intType.indexOf(str) >= 0 ) type = "INTEGER";

        sql.append(QString("%1 %2,").arg(str).arg(type));
        sqlInsert->append(str + ",");
        sqlValues.append("?,");
    }

    // sql.append(QString("PRIMARY KEY(%1,%2));").arg(F_PATIENTID));
    if(primaryFiledList.count() > 0) {
        sql.append("PRIMARY KEY(");
        foreach(QString key, primaryFiledList) {
            sql.append(QString("%1,").arg(key));
        }
        sql.chop(1);
        sql.append("));");
    }

    if( !query.exec(sql) ) {
        return false;
    }

    sqlValues.chop(1);
    sqlValues.append(")");

    sqlInsert->chop(1);
    sqlInsert->append(") " + sqlValues + ";");
    return true;
}

// --------------------------------------------------------------------------------
bool Database::selectFolder(QString folder)
{
    // フォルダ以下の dcmで patient, study テーブル作る
    // [RET]    true    Success
    //          false   Error
    // ----------------------------------------
    // テーブル新規作成
    // ----------------------------------------
    bool res;
    res = createTable(DBT::PATIENT, QStringList() << DBF::PATIENTID, m_patientList, &m_sqlPatientInsert);
    if(!res) return false;

    res = createTable(DBT::STUDY, QStringList() << DBF::STUDYINSTANCEUID << DBF::PATIENTID, m_studyList, &m_sqlStudyInsert);
    if(!res) return false;

    res = createTable(DBT::SERIES, QStringList() << DBF::SERIESINSTANCEUID << DBF::STUDYINSTANCEUID, m_seriesList, &m_sqlSeriesInsert);
    if(!res) return false;

    res = createTable(DBT::IMAGE, QStringList() << DBF::SOPINSTANCEUID << DBF::SERIESINSTANCEUID, m_imageList, &m_sqlImageInsert);
    if(!res) return false;

    // ----------------------------------------
    // DICOMファイル検索
    // ----------------------------------------
    m_documentFileList.clear();
    m_docImageFileList.clear();

    kensaku(folder);                            // DICOMファイルを検索してDBに追加していく
    syukei();                                   // 一旦DBに取り込んだデータを使って、集計データを登録する

    return true;
}
// --------------------------------------------------------------------------------
void Database::kensaku(QString folder)
{
    // サブフォルダも含め、全ファイル(*.dcm)を検索する
    Q_ASSERT(!m_patientList.isEmpty());
    Q_ASSERT(!m_studyList.isEmpty());

    QDir dirKensaku(folder);
    if( ! dirKensaku.exists()) return;

    QString searchFolder = folder;
    if(searchFolder.endsWith("/")) searchFolder.chop(1);
    PROCESS_EVENT;

    if(m_config->isImportDocumentFolder(searchFolder)) {

        // ドキュメントファイル
        foreach(QFileInfo info, dirKensaku.entryInfoList(QDir::NoDotAndDotDot | QDir::AllDirs | QDir::Files)) {
            QString fileName = info.absolutePath() + "/" + info.fileName();

            if(info.isDir()) {
                // サブフォルダを検索
                kensaku(fileName + "/");
                continue;
            }

            // 一般画像ファイルか否か判定
            bool isImage = false;
            QFile file(fileName);
            if(file.open(QFile::ReadOnly)) {
                uint fileSize = file.size();
                quint8 *memory = file.map(0, fileSize);
                if (memory) {
                    QPixmap pm;
                    if( pm.loadFromData(memory, fileSize) ) isImage = true;
                    file.unmap(memory);
                }
                file.close();
            }

            if(isImage) {
                m_docImageFileList.append(fileName);        // 一般画像ファイル
            } else {
                m_documentFileList.append(fileName);        // 一般ドキュメント
            }
        }

    } else {

        // DICOMファイル
        dirKensaku.setNameFilters(QStringList() << "*.dcm");
        foreach(QFileInfo info, dirKensaku.entryInfoList(QDir::NoDotAndDotDot | QDir::AllDirs | QDir::Files)) {
            QString fileName = info.absolutePath() + "/" + info.fileName();

            if(info.isDir()) {
                // サブフォルダを検索
                kensaku(fileName + "/");
                continue;
            }

            // DBにDICOIMファイルを取り込む
            insertTable(fileName, m_sqlPatientInsert, m_patientList);
            insertTable(fileName, m_sqlStudyInsert, m_studyList);
            insertTable(fileName, m_sqlSeriesInsert, m_seriesList);
            insertTable(fileName, m_sqlImageInsert, m_imageList);
        }
    }
}

// --------------------------------------------------------------------------------
bool Database::insertTable(QString fileName, QString sqlInsert, QStringList fieldList)
{
    // テーブルにデータ追加
    // [IN]     fileName        読込んだDICOM(*.dcm)ファイル
    //          sqlInsert       実行するINSERT文
    //          fieldList
    // [RET]    true    success
    //          false   error
    Dicom dicom(this, fileName);
    if( !dicom.error().isEmpty() ) {
        return false;
    }

    if(sqlInsert.isEmpty()) {
        return false;
    }

    QSqlQuery query;
    query.prepare(sqlInsert);
    foreach (QString tag, fieldList) {          // Tag "[xxxx,yyyy]"形式

        if(tag == DBF::IMAGE_THUMB) {
            // IMAGE - サムネール画像
            QString jpgFile = fileName.replace( QRegExp(".dcm$"), ".jpg");
            jpgFile = m_config->fileRelativeWorkspace(jpgFile);
            query.addBindValue(jpgFile);

        } else if(tag.startsWith("[P") || tag.startsWith("[T")
                  || tag.startsWith("[R") || tag.startsWith("[I") ) {
            // 特殊タグ
            query.addBindValue("");

        } else {
            QString buf;
            if( dicom.tagValue(tag.mid(1,9), &buf, true) ) {            // TAGが存在しなければ、項目をNULLにするのでなくEmptyにする。
                                                                        // WHERE文で、LIKE '' で比較している場合があるので。
                // 表示用にデータを変換して格納する
                if(tag == DBF::PATIENTNAME) {
                    // Patient name

                    bool isDone = false;
                    QRegExp rx("(.*)=(.*)=(.*)");
                    if( rx.indexIn(buf) >= 0 ) {
                        // "Suzuki^Ichiro=鈴木^一郎=スズキ^イチロー" --> "鈴木 一郎(スズキ イチロー)"
                        isDone = true;
                        QRegExp rx1("(.*)\\^(.*)");
                        QString p1, p2, p3;
                        p1 = rx.cap(1);                                         // "Suzuki^Ichiro"
                        if(rx1.indexIn(p1) >= 0) p1 = QString("%1 %2").arg(rx1.cap(1)).arg(rx1.cap(2));     // "Suzuki Ichiro"

                        p2 = rx.cap(2);                                         // "鈴木^一郎"
                        if(rx1.indexIn(p2) >= 0) p2 = QString("%1 %2").arg(rx1.cap(1)).arg(rx1.cap(2));     // "鈴木 一郎"

                        p3 = rx.cap(3);                                         // "スズキ^イチロー"
                        if(rx1.indexIn(p3) >= 0) p3 = QString("%1 %2").arg(rx1.cap(1)).arg(rx1.cap(2));     // "スズキ イチロー"

                        if( p2.isEmpty() ) {
                            buf = (p3.isEmpty()) ? p1: p3;
                        } else {
                            buf = (p3.isEmpty()) ? QString("%1").arg(p1) : QString("%1(%2)").arg(p2).arg(p3);
                        }
                    }

                    rx.setPattern("(.*)=(.*)");
                    if(!isDone && (rx.indexIn(buf) >= 0)) {
                        // "Suzuki^Ichiro=鈴木^一郎" --> "鈴木 一郎(Suzuki Ichiro)"
                        isDone = true;
                        QRegExp rx1("(.*)\\^(.*)");
                        QString p1, p2;
                        p1 = rx.cap(1);                     // "Suzuki^Ichiro"
                        if(rx1.indexIn(p1) >= 0) p1 = QString("%1 %2").arg(rx1.cap(1)).arg(rx1.cap(2));  // "Suzuki Ichiro"

                        p2 = rx.cap(2);                     // "鈴木^一郎"
                        if(rx1.indexIn(p2) >= 0) p2 = QString("%1 %2").arg(rx1.cap(1)).arg(rx1.cap(2));  // "鈴木 一郎"

                        if( p2.isEmpty() ) {
                            buf = p1;
                        } else {
                            buf = (p1.isEmpty()) ? QString("%1").arg(p2) : QString("%1(%2)").arg(p2).arg(p1);
                        }
                    }

                    rx.setPattern("(.*)\\^(.*)");
                    if(!isDone && (rx.indexIn(buf) >= 0)) {
                        // "Suzuki^Ichiro" --> "Suzuki Ichiro"
                        isDone = true;
                        buf = QString("%1 %2").arg(rx.cap(1)).arg(rx.cap(2));
                    }

                } else if(tag==DBF::BIRTHDATE || tag==DBF::STUDYDATE) {
                    // 日付フォーマット
                    if(buf.length()==8) {
                        int y = buf.mid(0,4).toInt();
                        int m = buf.mid(4,2).toInt();
                        int d = buf.mid(6,2).toInt();
                        QDate date(y,m,d);
                        if(date.isValid()) {
                            buf = date.toString(Qt::SystemLocaleShortDate).toLatin1();
                        }
                    }
                }

                query.addBindValue(buf);

            } else {
                dicom.errorClear();             // TAGが存在しない場合でもNULLにせずに Emptyにしておく。WHERE で LIKE ''としているため。
                query.addBindValue("");
            }
        }
    }

    bool res = query.exec();
    return res;
}


// --------------------------------------------------------------------------------
void Database::syukei()
{
    // 一旦DBに取り込んだデータを使って、集計データを登録する
    bool res;
    QString sql;
    QSqlQuery query;
    QMap<QString, int> numofImagesList;
    QMap<QString, int> numofSeriesList;
    QMap<QString, int> numofStudiesList;

    QMap<QString, int>  seriesList;             // 1st:seriesInstanceUID, 2nd:画像数
    QMap<QString, int>  studyList;              // 1st:studyInstanceUID, 2nd:画像数
    QMap<QString, int>  patientList;            // 1st:patient ID,      2nd:画像数

    QSqlDatabase::database().transaction();

    // ========================================
    // 画像件数
    // ========================================

    // ----------------------------------------
    // seriesテーブルにシリーズ別の画像件数をセットする
    // ----------------------------------------
    // 画像数のカウント
    // "SELECT series.[0020,000E], COUNT(image.[0008,0018])"
    // "FROM series INNER JOIN [image] ON series.[0020,000E] = image.[0020,000E]"
    // "GROUP BY series.[0020,000E];"
    sql = QString("SELECT %1.%2, COUNT(%3.%4) ").arg(DBT::SERIES).arg(DBF::SERIESINSTANCEUID).arg(DBT::IMAGE).arg(DBF::SOPINSTANCEUID);
    sql.append(QString("FROM %1 INNER JOIN %2 ON %1.%3 = %2.%3 ").arg(DBT::SERIES).arg(DBT::IMAGE).arg(DBF::SERIESINSTANCEUID));
    sql.append(QString("GROUP BY %1.%2;").arg(DBT::SERIES).arg(DBF::SERIESINSTANCEUID));
    query.clear();
    numofImagesList.clear();
    res = query.exec(sql);
    Q_ASSERT(res);
    while(query.next()) {
        QString seriesUid = query.value(0).toString();
        int gazousu = query.value(1).toInt();
        numofImagesList.insert(seriesUid, gazousu);
        seriesList.insert(seriesUid, gazousu);
    }
    // qDebug() << numofImagesList;

    // 画像数をセット
    sql = QString("UPDATE %1 ").arg(DBT::SERIES);
    sql.append(QString("SET %1 = ? ").arg(DBF::SERIES_NUMOF_IMAGES));
    sql.append(QString("WHERE %1 LIKE ?;").arg(DBF::SERIESINSTANCEUID));
    query.clear();
    query.prepare(sql);
    foreach (QString seriesUid, seriesList.keys()) {
        query.addBindValue(numofImagesList.value(seriesUid));
        query.addBindValue(seriesUid);
        res = query.exec();
        Q_ASSERT(res);
    }

    // ----------------------------------------
    // studyテーブルにstudy別のSeries件数/画像件数をセットする
    // ----------------------------------------
    // 画像数のカウント
    // "SELECT study.[0020,000D], COUNT(series.[0020,000E]), SUM(series.[R000,0002])"
    // "FROM study INNER JOIN [series] ON study.[0020,000D] = series.[0020,000D]"
    // "GROUP BY study.[0020,000D];"
    sql = QString("SELECT %1.%2, COUNT(%3.%4), SUM(%3.%5) ").arg(DBT::STUDY).arg(DBF::STUDYINSTANCEUID).arg(DBT::SERIES).arg(DBF::SERIESINSTANCEUID).arg(DBF::SERIES_NUMOF_IMAGES);
    sql.append(QString("FROM %1 INNER JOIN %2 ON %1.%3 = %2.%3 ").arg(DBT::STUDY).arg(DBT::SERIES).arg(DBF::STUDYINSTANCEUID));
    sql.append(QString("GROUP BY %1.%2;").arg(DBT::STUDY).arg(DBF::STUDYINSTANCEUID));
    query.clear();
    numofSeriesList.clear();
    numofImagesList.clear();
    res = query.exec(sql);
    Q_ASSERT(res);
    while(query.next()) {
        QString studyUid = query.value(0).toString();
        int gazousu = query.value(2).toInt();
        numofSeriesList.insert(studyUid, query.value(1).toInt());
        numofImagesList.insert(studyUid, gazousu);
        studyList.insert(studyUid, gazousu);
    }
    // qDebug() << numofSeriesList;
    // qDebug() << numofImagesList;


    // Series件数/画像件数をセット
    sql = QString("UPDATE %1 ").arg(DBT::STUDY);
    sql.append(QString("SET %1 = ?, %2 = ? ").arg(DBF::STUDY_NUMOF_SERIES).arg(DBF::STUDY_NUMOF_IMAGES));
    sql.append(QString("WHERE %1 LIKE ?;").arg(DBF::STUDYINSTANCEUID));
    query.clear();
    query.prepare(sql);
    foreach (QString studyUid, studyList.keys()) {
        query.addBindValue(numofSeriesList.value(studyUid));
        query.addBindValue(numofImagesList.value(studyUid));
        query.addBindValue(studyUid);
        res = query.exec();
        Q_ASSERT(res);
    }

    // ----------------------------------------
    // patientテーブルにpatient別のstudy件数/series件数/画像件数をセットする
    // ----------------------------------------
    // 画像数のカウント
    // "SELECT patient.[0010,0020], COUNT(study.[0020,000D]), SUM(study.[T000,0002]), SUM(study.[T000,0003]) "
    // "FROM patient INNER JOIN [study] ON patient.[0010,0020] = study.[0010,0020] "
    // "GROUP BY patient.[0010,0020];"
    sql = QString("SELECT %1.%3, COUNT(%2.%4), SUM(%2.%5), SUM(%2.%6) ").arg(DBT::PATIENT).arg(DBT::STUDY).arg(DBF::PATIENTID).arg(DBF::STUDYINSTANCEUID).arg(DBF::STUDY_NUMOF_SERIES).arg(DBF::STUDY_NUMOF_IMAGES);
    sql.append(QString("FROM %1 INNER JOIN %2 ON %1.%3 = %2.%3 ").arg(DBT::PATIENT).arg(DBT::STUDY).arg(DBF::PATIENTID));
    sql.append(QString("GROUP BY %1.%2;").arg(DBT::PATIENT).arg(DBF::PATIENTID));
    query.clear();
    numofStudiesList.clear();
    numofSeriesList.clear();
    numofImagesList.clear();
    res = query.exec(sql);
    Q_ASSERT(res);
    while(query.next()) {
        QString patientId = query.value(0).toString();
        int gazousu = query.value(3).toInt();
        numofStudiesList.insert(patientId, query.value(1).toInt());
        numofSeriesList.insert(patientId, query.value(2).toInt());
        numofImagesList.insert(patientId, gazousu);
        patientList.insert(patientId, gazousu);
    }
    // qDebug() << numofStudiesList;
    // qDebug() << numofSeriesList;
    // qDebug() << numofImagesList;

    // Study件数.Series件数/画像件数をセット
    sql = QString("UPDATE %1 ").arg(DBT::PATIENT);
    sql.append(QString("SET %1 = ?, %2 = ?, %3 = ? ").arg(DBF::PATIENT_NUMOF_STUDIES).arg(DBF::PATIENT_NUMOF_SERIES).arg(DBF::PATIENT_NUMOF_IMAGES));
    sql.append(QString("WHERE %1 LIKE ?;").arg(DBF::PATIENTID));
    query.clear();
    query.prepare(sql);
    foreach (QString patientId, patientList.keys()) {
        query.addBindValue(numofStudiesList.value(patientId));
        query.addBindValue(numofSeriesList.value(patientId));
        query.addBindValue(numofImagesList.value(patientId));
        query.addBindValue(patientId);
        res = query.exec();
        Q_ASSERT(res);
    }

    // ========================================
    // 代表画像
    // 一番長いシリーズの中央画像を代表画像とする。
    // ========================================

    // ----------------------------------------
    // seriesテーブルの代表画像
    // ----------------------------------------
    foreach (QString seriesUid, seriesList.keys()) {

        // 代表画像検索
        // "SELECT image.[F_IMAGE_THUMB]"
        // "FROM image "
        // "WHERE image.[F_SERIESINSTANCEUID] LIKE seriesUid "
        // "ORDER BY image.[F_SOPINSTANCEUID];"
        sql = QString("SELECT %1 ").arg(DBF::IMAGE_THUMB);
        sql.append(QString("FROM %1 ").arg(DBT::IMAGE));
        sql.append(QString("WHERE %1 LIKE '%2' ").arg(DBF::SERIESINSTANCEUID).arg(seriesUid));
        sql.append(QString("ORDER BY %1;").arg(DBF::SOPINSTANCEUID));

        QString gazou;
        query.clear();
        res = query.exec(sql);
        Q_ASSERT(res);
        int gazousu = seriesList.value(seriesUid);
        for(int i=0; i<(gazousu/2 + 0.5); i++) {          // 真ん中画像まで読み飛ばす
            if(query.next()) {
                gazou = query.value(0).toString();
            } else {
                Q_ASSERT(0);
            }

        }

        // 代表画像をseriesテーブルにセットする
        sql = QString("UPDATE %1 ").arg(DBT::SERIES);
        sql.append(QString("SET %1 = '%2' ").arg(DBF::SERIES_THUMB).arg(gazou));
        sql.append(QString("WHERE %1 LIKE '%2';").arg(DBF::SERIESINSTANCEUID).arg(seriesUid));
        res = query.exec(sql);
        Q_ASSERT(res);
    }

    // ----------------------------------------
    // studyテーブルの代表画像
    // ----------------------------------------
    foreach (QString studyUid, studyList.keys()) {

        // 代表画像検索
        // "SELECT [F_SERIESINSTANCEUID],[F_SERIES_THUMB]"
        // "FROM series "
        // "WHERE [F_STUDYINSTANCEUID] LIKE studyUid;"
        sql = QString("SELECT %1, %2 ").arg(DBF::SERIESINSTANCEUID).arg(DBF::SERIES_THUMB);
        sql.append(QString("FROM %1 ").arg(DBT::SERIES));
        sql.append(QString("WHERE %1 LIKE '%2';").arg(DBF::STUDYINSTANCEUID).arg(studyUid));

        QString gazou;
        int gazouMax = -1;
        query.clear();
        res = query.exec(sql);
        Q_ASSERT(res);
        while(query.next()) {
            QString seriesUid = query.value(0).toString();
            if(seriesList.value(seriesUid) > gazouMax ) {
                gazou = query.value(1).toString();
                gazouMax = seriesList.value(seriesUid);
            }
        }

        // 代表画像をstudyテーブルにセットする
        sql = QString("UPDATE %1 ").arg(DBT::STUDY);
        sql.append(QString("SET %1 = '%2' ").arg(DBF::STUDY_THUMB).arg(gazou));
        sql.append(QString("WHERE %1 LIKE '%2';").arg(DBF::STUDYINSTANCEUID).arg(studyUid));
        res = query.exec(sql);
        Q_ASSERT(res);
    }

    // ----------------------------------------
    // patientテーブルの代表画像
    // ----------------------------------------
    foreach (QString patientId, patientList.keys()) {

        // 代表画像検索
        // "SELECT [F_STUDYINSTANCEUID],[F_STUDY_THUMB] "
        // "FROM study "
        // "WHERE [F_PATIENTID] LIKE patientId;"
        sql = QString("SELECT %1, %2 ").arg(DBF::STUDYINSTANCEUID).arg(DBF::STUDY_THUMB);
        sql.append(QString("FROM %1 ").arg(DBT::STUDY));
        sql.append(QString("WHERE %1 LIKE '%2';").arg(DBF::PATIENTID).arg(patientId));

        QString gazou;
        int gazouMax = -1;
        query.clear();
        res = query.exec(sql);
        Q_ASSERT(res);
        while(query.next()) {
            QString studyUid = query.value(0).toString();
            if(studyList.value(studyUid) > gazouMax ) {
                gazou = query.value(1).toString();
                gazouMax = studyList.value(studyUid);
            }
        }

        // 代表画像をpatientテーブルにセットする
        sql = QString("UPDATE %1 ").arg(DBT::PATIENT);
        sql.append(QString("SET %1 = '%2' ").arg(DBF::PATIENT_THUMB).arg(gazou));
        sql.append(QString("WHERE %1 LIKE '%2';").arg(DBF::PATIENTID).arg(patientId));
        res = query.exec(sql);
        Q_ASSERT(res);
    }

    QSqlDatabase::database().commit();
}

// --------------------------------------------------------------------------------
void Database::list_select(QStringList htmlTagList, QStringList patientID, QString *sql, QStringList *fieldList, int *numOfAddField)
{
    // List1,2 画面専用
    // Select文を生成する
    // [IN]     htmlTagList
    //          patientID       patientIDのWHERE条件。条件を付けない場合は ""を渡す。
    // [OUT]    sql             "SELECT patient.[0010,0020],patient.[0010,0010],patient.[0010,0040],patient.[0010,0030] "
    //                          "FROM patient "
    //                          "WHERE patient.[0010,0020] LIKE '10023'"
    //                          "ORDER BY patient.[0010,0020],patient.[0010,0010],patient.[0010,0040],patient.[0010,0030];"
    //          fieldList
    //          numOfAddTag     主キーがSELECTの末尾に追加されたることがあり、追加された主キー数(シンプルリストに表示させない)
    sql->clear();
    fieldList->clear();

    // 表示分類( patient / study / patient and study)を決定する
    bool isPatient = false;
    bool isStudy = false;

    QString sqlField;
    foreach (QString tag, htmlTagList) {

        if(m_patientList.contains(tag)) {
            isPatient = true;
            sqlField.append(QString("%1.%2,").arg(DBT::PATIENT).arg(tag));
            fieldList->append(tag);
        }

        if(m_studyList.contains(tag)) {
            if(tag != DBF::PATIENTID) {    // PatientID はリレーション用なので、検査の表示に含めない
                isStudy = true;
                sqlField.append(QString("%1.%2,").arg(DBT::STUDY).arg(tag));
                fieldList->append(tag);
            }
         }
    }

    // 主キーを必ず含める
    *numOfAddField = 0;
    if(isPatient) {
        QString tag = DBF::PATIENTID;
        if( sqlField.indexOf(tag) < 0) {
            sqlField.append(QString("%1.%2,").arg(DBT::PATIENT).arg(tag));
            fieldList->append(tag);
            *numOfAddField = *numOfAddField + 1;
        }
    }
    if(isStudy) {
        QString tag = DBF::PATIENTID;
        if( sqlField.indexOf(tag) < 0) {
            sqlField.append(QString("%1.%2,").arg(DBT::STUDY).arg(tag));
            fieldList->append(tag);
            *numOfAddField = *numOfAddField + 1;
        }

        tag = DBF::STUDYINSTANCEUID;
        if( sqlField.indexOf(tag) < 0) {
            sqlField.append(QString("%1.%2,").arg(DBT::STUDY).arg(tag));
            fieldList->append(tag);
            *numOfAddField = *numOfAddField + 1;
        }
    }

    if(sqlField.right(1) == ",") sqlField.chop(1);

    // 表示クエリを組み立てる
    QString sqlTable;
    if(isPatient && isStudy) {
        sqlTable = QString("%1 INNER JOIN %2 ON %1.%3 = %2.%3").arg(DBT::STUDY).arg(DBT::PATIENT).arg(DBF::PATIENTID);
    } else if(isPatient) {
        sqlTable = DBT::PATIENT;
    } else if(isStudy) {
        sqlTable = DBT::STUDY;
    }

    QString sqlWhere;
    if(patientID.count()>0) {
        sqlWhere.append("WHERE ( ");
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sqlWhere.append("OR ");
            sqlWhere.append( QString("(%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
        sqlWhere.append(") ");
    }

    *sql = QString("SELECT %1 FROM %2 %3 ORDER BY %1;").arg(sqlField).arg(sqlTable).arg(sqlWhere);
}

// --------------------------------------------------------------------------------
QString Database::list_pickupDicomTag(QString htmlFile, QList<QString> &tagList, QList<int> &widthList, QList<QString> &titleList )
{
    // List1,2 画面専用
    // htmlから、(xxxx,yyyy|n^aaa|)パターンを抜き出してパースする。
    // メモ ： "[～]" はSQLiteの列名に使える。
    // [IN]     htmlFile
    // [OUT]    tagList             xxxx,yyyy   タグ部分    [xxxx,yyyy] 形式
    //          widthList           n           シンプル表示時のカラム列幅。0で非表示
    //          titleList           aaa         シンプル表示時のカラムタイトル
    // [RET]    htmlFileファイル内容
    QString html;
    QFile file(htmlFile);
    if( !file.open(QFile::ReadOnly) ) return html;
#ifdef Q_OS_WIN
    html = JTR(file.readAll());
#else
    // Linuxでは文字化けしたので強制的に"Shift-JIS"指定。【暫定処理】
    html = QTextCodec::codecForName("Shift-JIS")->toUnicode(file.readAll());
#endif
    file.close();

    // 検索パターン
    // ListHtml_delegate::paint() のパターンとも対応させておくこと。
    QRegExp rx("\\(([0-9A-Fa-fPTRI]{1}[0-9A-Fa-f]{3},[0-9A-Fa-f]{4})\\|(\\d*)\\^(.*)\\|\\)"); // (Zxxx,yyyy|n^aaa|) パターン
    rx.setMinimal(true);

    int pos = 0;
    while ((pos = rx.indexIn(html, pos)) != -1) {
        QString str = "[" + rx.cap(1).toUpper() + "]";  // Zxxx,yyyy部分。英大文字にしておく
        tagList.append(str);

        bool isOk;
        int num = rx.cap(2).toInt(&isOk);               // n部分
        if(!isOk) num=0;
        widthList.append(num);

        str = rx.cap(3);                                // aaa 部分
        titleList.append(str);

        pos += rx.matchedLength();
    }

    // qDebug() << tagList << widthList << titleList;
    return html;
}

// --------------------------------------------------------------------------------
void Database::matrix_timeline(QStringList patientID, QStringList studyInstanceUID, QMap<QDate, QStringList> &timeline)
{
    // Matrix画面専用
    // [IN]     patientID, studyInstanceUID
    // [OUT]    timeline
    QString sql;
    if(studyInstanceUID.count() == 0) {

        sql = QString("SELECT DISTINCT %1,%2 FROM %3 WHERE (").arg(DBF::STUDYDATE).arg(DBF::MODALITY).arg(DBT::STUDY);
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("%1 LIKE '%2'").arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
        sql.append(");");

    } else {

        sql = QString("SELECT DISTINCT %1,%2 FROM %3 WHERE (").arg(DBF::STUDYDATE).arg(DBF::MODALITY).arg(DBT::STUDY);
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("%1 LIKE '%2'").arg(DBF::PATIENTID).arg(patientID.at(i)));
        }

        sql.append(") AND ( ");
        for(int i=0; i<studyInstanceUID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("%1 LIKE '%2'").arg(DBF::STUDYINSTANCEUID).arg(studyInstanceUID.at(i)));
        }
        sql.append(");");
    }

    QSqlQuery query;
    bool res = query.exec(sql);
    Q_ASSERT(res);
    Q_UNUSED(res);
    while(query.next()) {
        // qDebug() << query.value(0).toString() << query.value(1).toString();
        QString studyDate = query.value(0).toString();
        QDate date = QDate::fromString(studyDate, Qt::SystemLocaleShortDate);
        timeline[date].append(query.value(1).toString());    // data, modality List
    }
}

// --------------------------------------------------------------------------------
void Database::matrix_imageList(QStringList patientID, QStringList studyInstanceUID, QDate date, QString modality, QString &imageFile)
{
    // Matrix画面専用
    // [IN]     patientID, studyInstanceUID, date, modality
    // [OUT]    imageFile
    QString sql = QString("SELECT %1.%2 ").arg(DBT::IMAGE).arg(DBF::IMAGE_THUMB);
    sql.append(QString(
        "FROM (%1 INNER JOIN %2 ON %1.%3 = %2.%3) INNER JOIN %4 ON %2.%5 = %4.%5 ")\
        .arg(DBT::STUDY).arg(DBT::SERIES).arg(DBF::STUDYINSTANCEUID).arg(DBT::IMAGE).arg(DBF::SERIESINSTANCEUID));

    if(studyInstanceUID.count() == 0) {
        sql.append(QString("WHERE ( "));
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("(%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
        sql.append(QString(") AND (%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::STUDYDATE).arg(date.toString(Qt::SystemLocaleShortDate)));
        sql.append(QString("AND (%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::MODALITY).arg(modality));

    } else {
        //sql.append(QString(
        //"WHERE ((study.[0010,0020] LIKE '%1') AND (study.[0020,000D] LIKE '%2') AND (study.%3 LIKE '%4') AND (study.[0008,0060] LIKE '%5')) ")\
        //.arg(patientID).arg(studyInstanceUID).arg(DBF::STUDYDATE).arg(date.toString(Qt::SystemLocaleShortDate)).arg(modality));

        sql.append(QString("WHERE ( "));
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("(%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
        sql.append(") AND ( ");
        for(int i=0; i<studyInstanceUID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("(%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::STUDYINSTANCEUID).arg(studyInstanceUID.at(i)));
        }
        sql.append(QString(") AND (%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::STUDYDATE).arg(date.toString(Qt::SystemLocaleShortDate)));
        sql.append(QString("AND (%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::MODALITY).arg(modality));
    }

    sql.append(QString("ORDER BY %1.%2;").arg(DBT::IMAGE).arg(DBF::SOPINSTANCEUID));       // SOP Instance UIDで並べ替え

    QSqlQuery query;
    bool res = query.exec(sql);
    Q_ASSERT(res);
    Q_UNUSED(res);

    QStringList imageFileList;
    while(query.next()) {
        QString file = m_config->folderWorkspaceImport() + query.value(0).toString();
        imageFileList.append(file);
    }

    // 中央の画像を返す
    imageFile.clear();
    if(imageFileList.count()>0) imageFile = imageFileList.at(imageFileList.count() / 2);
}

// --------------------------------------------------------------------------------
QStringList Database::seriesInstanceUIDList(QStringList patientID, QStringList studyInstanceUID)
{
    // [IN]     patientID, studyInstanceUID
    // [RET]    seriesInstanceUIDList
    QStringList ret;
    if(patientID.isEmpty()) return ret;

    QString sql;
    sql.append(QString("SELECT %1.%2 ").arg(DBT::SERIES).arg(DBF::SERIESINSTANCEUID));
    sql.append(QString("FROM (%1 INNER JOIN %2 ON %1.%3 = %2.%3) INNER JOIN series ON %2.%4 = series.%4 ")\
               .arg(DBT::PATIENT).arg(DBT::STUDY).arg(DBF::PATIENTID).arg(DBF::STUDYINSTANCEUID));
    if(studyInstanceUID.count() == 0) {
        sql.append("WHERE ( ");
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("%1.%2 LIKE '%3' ").arg(DBT::PATIENT).arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
        sql.append(") ");

    } else {
        sql.append("WHERE ( ");
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("%1.%2 LIKE '%3' ").arg(DBT::PATIENT).arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
        sql.append(") AND ( ");
        for(int i=0; i<studyInstanceUID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("%1.%2 LIKE '%3' ").arg(DBT::STUDY).arg(DBF::STUDYINSTANCEUID).arg(studyInstanceUID.at(i)));
        }
        sql.append(") ");
    }
    sql.append(QString("ORDER BY %1.%2;").arg(DBT::SERIES).arg(DBF::SERIESINSTANCEUID));

    QSqlQuery query;
    bool res = query.exec(sql);
    Q_ASSERT(res);
    Q_UNUSED(res);

    while(query.next()) {
        ret.append(query.value(0).toString());
    }
    return  ret;
}

// --------------------------------------------------------------------------------
QStringList Database::imageFileList_execSql(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID,
                                            QStringList sqlWhere, QStringList sqlOrderby)
{
    // imageFileList 共通のSQL実行
    QStringList ret;
    if(patientID.isEmpty()) return ret;

    QString sql;
    sql.append(QString("SELECT %1.%2 ").arg(DBT::IMAGE).arg(DBF::IMAGE_THUMB));
    sql.append(QString("FROM ((%1 "
                       "INNER JOIN %2 ON %1.%5 = %2.%5) "
                       "INNER JOIN %3 ON %2.%6 = %3.%6) "
                       "INNER JOIN %4 ON %3.%7 = %4.%7 ")\
            .arg(DBT::PATIENT).arg(DBT::STUDY).arg(DBT::SERIES).arg(DBT::IMAGE)\
            .arg(DBF::PATIENTID).arg(DBF::STUDYINSTANCEUID).arg(DBF::SERIESINSTANCEUID));

    sql.append("WHERE ( ");
        for(int i=0; i<patientID.count(); i++) {
            if(i>0) sql.append("OR ");
            sql.append(QString("(%1.%2 LIKE '%3') ").arg(DBT::PATIENT).arg(DBF::PATIENTID).arg(patientID.at(i)));
        }
    sql.append(") ");

    if( !studyInstanceUID.isEmpty() ) {
        sql.append("AND ( ");
            for(int i=0; i<studyInstanceUID.count(); i++) {
                if(i>0) sql.append("OR ");
                sql.append(QString("(%1.%2 LIKE '%3') ").arg(DBT::STUDY).arg(DBF::STUDYINSTANCEUID).arg(studyInstanceUID.at(i)));
            }
        sql.append(") ");
    }

    if( !seriesInstanceUID.isEmpty() ) {
        sql.append("AND ( ");
            for(int i=0; i<seriesInstanceUID.count(); i++) {
                if(i>0) sql.append("OR ");
                sql.append(QString("(%1.%2 LIKE '%3') ").arg(DBT::SERIES).arg(DBF::SERIESINSTANCEUID).arg(seriesInstanceUID.at(i)));
            }
        sql.append(") ");
    }

    foreach (QString condition, sqlWhere) {
        sql.append(QString("AND (%1) ").arg(condition));
    }

    if( sqlOrderby.count() > 0 ) {
        sql.append(QString("ORDER BY "));
        foreach (QString condition, sqlOrderby) {
            sql.append(QString("%1,").arg(condition));
        }
        sql.chop(1);
    }
    sql.append(";");

    QSqlQuery query;
    bool res = query.exec(sql);
    Q_ASSERT(res);
    Q_UNUSED(res);

    while(query.next()) {
        QString imageFile = m_config->folderWorkspaceImport() + query.value(0).toString();
        ret.append(imageFile);
    }

    return  ret;
}

// --------------------------------------------------------------------------------
QStringList Database::imageFileList(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID)
{
    // patientID, studyInstanceUID, seriesInstanceUID を指定して、ImageFileListを取得。
    // [IN]     patientID, studyInstanceUID, seriesInstanceUID
    // [RET]    imageFile List

    // SQL WHERE句
    QStringList sqlWhere;

    // SQL ORDER BY句
    QStringList sqlOrderby;
    sqlOrderby.append(QString("%1.%2").arg(DBT::IMAGE).arg(DBF::SOPINSTANCEUID));

    QStringList ret = imageFileList_execSql(patientID, studyInstanceUID, seriesInstanceUID, sqlWhere, sqlOrderby);
    return ret;
}

// --------------------------------------------------------------------------------
QStringList Database::imageFileList_mammoOmitted(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID)
{
    // imageFileList() の拡張版
    // マンモ画像を除いたリストを返す

    // SQL WHERE句
    // DicomタグのViewPositionが空ならマンモでないとみなすことにした。
    QStringList sqlWhere;
    sqlWhere.append(QString("%1.%2 LIKE ''").arg(DBT::IMAGE).arg(DBF::VIEWPOSITION));

    // SQL ORDER BY句
    QStringList sqlOrderby;
    sqlOrderby.append(QString("%1.%2").arg(DBT::IMAGE).arg(DBF::SOPINSTANCEUID));

    QStringList ret = imageFileList_execSql(patientID, studyInstanceUID, seriesInstanceUID, sqlWhere, sqlOrderby);
    return ret;
}

// --------------------------------------------------------------------------------
QStringList Database::imageFileList_mammo(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID)
{
    // imageFileList() の拡張版
    // マンモ画像リストを返す

    // SQL WHERE句
    // DicomタグのViewPositionが空でなければ(MLO,CC etc)、マンモ画像とみなすことにした。
    QStringList sqlWhere;
    sqlWhere.append(QString("NOT(%1.%2 LIKE '')").arg(DBT::IMAGE).arg(DBF::VIEWPOSITION));

    // SQL ORDER BY句
    // ORDER BY [Study Instance UID], [ViewPosition(MLO,CC etc)], [Laterality(L,R)] の順番
    QStringList sqlOrderby;
    sqlOrderby.append(QString("%1.%2").arg(DBT::STUDY).arg(DBF::STUDYINSTANCEUID)); // Study Instance UID
    sqlOrderby.append(QString("%1.%2").arg(DBT::IMAGE).arg(DBF::VIEWPOSITION));     // ViewPosition(CC, MLO etc)
    sqlOrderby.append(QString("%1.%2 DESC").arg(DBT::IMAGE).arg(DBF::LATERALITY));  // Laterality(表示したいRRR・・・LLL・・・順とする)
    sqlOrderby.append(QString("%1.%2").arg(DBT::IMAGE).arg(DBF::SOPINSTANCEUID));   // SOP Instance UID

    QStringList ret = imageFileList_execSql(patientID, studyInstanceUID, seriesInstanceUID, sqlWhere, sqlOrderby);
    return ret;
}

// --------------------------------------------------------------------------------
