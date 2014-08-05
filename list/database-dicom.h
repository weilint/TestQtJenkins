#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QDate>
#include <QLabel>
#include <QStringList>
#include <QSqlDatabase>

// --------------------------------------------------------------------------------
// データベースフィールド(別モジュールでも参照している)
namespace DBF
{
    // DBテーブルの主キーフィールド
    const QString PATIENTID              = "[0010,0020]";
    const QString STUDYINSTANCEUID       = "[0020,000D]";
    const QString SERIESINSTANCEUID      = "[0020,000E]";
    const QString SOPINSTANCEUID         = "[0008,0018]";

    // DBテーブルのフィールド(よく使うもの)
    const QString PATIENTNAME            = "[0010,0010]";
    const QString PATIENTSEX             = "[0010,0040]";
    const QString STUDYDATE              = "[0008,0020]";       // 日付フォーマット変換対象
    const QString MODALITY               = "[0008,0060]";
    const QString BIRTHDATE              = "[0010,0030]";       // 日付フォーマット変換対象
    const QString VIEWPOSITION           = "[0018,5101]";       // マンモ画像判定用
    const QString LATERALITY             = "[0020,0060]";       // マンモ画像判定用

    // 特殊タグ フィールド
    const QString PATIENT_THUMB          = "[P000,0001]";		// サムネイルファイルパス(代表画像)
    const QString PATIENT_NUMOF_STUDIES  = "[P000,0002]";		// study件数
    const QString PATIENT_NUMOF_SERIES   = "[P000,0003]";		// series件数
    const QString PATIENT_NUMOF_IMAGES   = "[P000,0004]";		// image件数

    const QString STUDY_THUMB            = "[T000,0001]";		// サムネイルファイルパス(代表画像)
    const QString STUDY_NUMOF_SERIES     = "[T000,0002]";		// series件数
    const QString STUDY_NUMOF_IMAGES     = "[T000,0003]";		// image件数

    const QString SERIES_THUMB           = "[R000,0001]";		// サムネイルファイルパス(代表画像)
    const QString SERIES_NUMOF_IMAGES    = "[R000,0002]";		// image件数

    const QString IMAGE_THUMB            = "[I000,0001]";		// サムネイルファイルパス(画像)
}

// --------------------------------------------------------------------------------
class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = 0);
    ~Database();

    bool        selectFolder(QString folder);           // フォルダの下にある*.dcmから patient, study テーブル作る
    QStringList patientTagList();
    QStringList studyTagList();
    QStringList dicomValueList(QString dicomFile, QStringList dicomTagList);    // DICOMタグに対応する値を取得する
    QStringList documentFileList() {return m_documentFileList;}                 // ドキュメントファイルリスト
    QStringList docImageFileList() {return m_docImageFileList;}                 // 一般画像ファイルリスト

    // patientID, studyInstanceUIDを指定して、seriesInstanceUIDListを取得
    QStringList seriesInstanceUIDList(QStringList patientID, QStringList studyInstanceUID);

    // patientID, studyInstanceUID, seriesInstanceUID を指定して、ImageFileListを取得
    QStringList imageFileList(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID);
    QStringList imageFileList_mammoOmitted(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID); // マンモ画像なしの画像リスト PreviewTable専用関数
    QStringList imageFileList_mammo(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID);        // マンモ画像リスト        PreviewTable専用関数

    // List1,2 専用関数
    QString     list_pickupDicomTag(
                    QString         htmlFile,
                    QList<QString>  &tagList,
                    QList<int>      &widthList,
                    QList<QString>  &titleList);
    void        list_select(QStringList htmlTagList, QStringList patientID, QString *sql, QStringList *fieldList, int *numOfAddField);

    // Matrix 専用関数
    void        matrix_timeline(QStringList patientID, QStringList studyInstanceUID, QMap<QDate, QStringList> &timeline);
    void        matrix_imageList(QStringList patientID, QStringList studyInstanceUIDList, QDate date, QString modality, QString &imageFile);

private:
    QSqlDatabase    m_db;
    QStringList     m_documentFileList;
    QStringList     m_docImageFileList;

    QStringList     m_patientList;
    QStringList     m_studyList;
    QStringList     m_seriesList;
    QStringList     m_imageList;

    QString         m_sqlPatientInsert;
    QString         m_sqlStudyInsert;
    QString         m_sqlSeriesInsert;
    QString         m_sqlImageInsert;

    void        kensaku(QString);
    bool        createTable(QString table, QStringList primaryFileList, QStringList fieldList, QString *sqlInsert);
    bool        insertTable(QString fileName, QString sqlInsert, QStringList fieldList);
    void        syukei();

    QStringList imageFileList_execSql(QStringList patientID, QStringList studyInstanceUID, QStringList seriesInstanceUID,
                    QStringList sqlWhere, QStringList sqlOrder);
};
// --------------------------------------------------------------------------------

#endif // DATABASE_H
