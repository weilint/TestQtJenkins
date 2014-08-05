#include <QtGui>
#include "config.h"

// #define APPVER           "AOC7 Proto - 2013/10/24"
#define APPVER              "AOC7 Proto"

#define FILE_SETTING        "setting.ini";

#define FOLDER_ROOT         "data/"                     // Root folder
#define FOLDER_LISTSTYLE    "liststyle/"
#define FOLDER_WSIMPORT     "ws_import/"                // DICOMファイルの取り込先
#define FOLDER_DOCUMENT     "doc"                       // インポートしたドキュメントを格納するフォルダ(あえて末尾に/を付けない)

// --------------------------------------------------------------------------------
Config::Config(QObject *parent) :
    QObject(parent)
{
    // Data root folder	
#ifdef Q_OS_ANDROID
    m_folderRoot = "/mnt/sdcard/external_sd/AOC7_Proto/data/";

#else
    m_folderRoot = qApp->applicationDirPath() + "/" + FOLDER_ROOT;
    if( !QFileInfo(m_folderRoot ).exists() ) {
        m_folderRoot = qApp->applicationDirPath() + "/../" + FOLDER_ROOT;
        if( !QFileInfo(m_folderRoot).exists() ) {
            m_folderRoot = qApp->applicationDirPath() + "/../../" + FOLDER_ROOT;
            if( !QFileInfo(m_folderRoot).exists() ) {
                m_folderRoot = qApp->applicationDirPath() + "/" + FOLDER_ROOT;
            }
        }
    }
#endif
}

// --------------------------------------------------------------------------------
QString Config::appVer()
{
    return APPVER;
}

// --------------------------------------------------------------------------------
QString Config::fileSetting()
{
    return m_folderRoot + FILE_SETTING;
}

// --------------------------------------------------------------------------------
QString Config::folderListStyle()
{
    // リッチ表示のhtml格納先
    return m_folderRoot + FOLDER_LISTSTYLE;
}

// --------------------------------------------------------------------------------
QString Config::folderWorkspaceImport()
{
    return m_folderRoot + FOLDER_WSIMPORT;
}

// --------------------------------------------------------------------------------
QString Config::fileRelativeWorkspace(QString fileName)
{
    // DICOMファイル取り込先からの相対パスに変換
    // 例 IN     "C:/Users/Nagata/Desktop/AOC7_Proto/data/ws_import/20130920/220510/99.jpg"
    //    RET   "20130920/220510/99.jpg"
    QString folder = "/" FOLDER_WSIMPORT;               // "/ws_import/"
    int pos = fileName.indexOf(folder);

    Q_ASSERT(pos >= 0);
    QString ret = fileName;
    if(pos>=0) ret = fileName.mid(pos + folder.length());
    return ret;
}

// --------------------------------------------------------------------------------
QString Config::folderRelativeWorkspace()
{
    // HTMLが画像ファイルを参照する時の相対パスに変換
    return "../" FOLDER_ROOT FOLDER_WSIMPORT;           // "../data/ws_import/"
}

// --------------------------------------------------------------------------------
bool Config::isImportDocumentFolder(QString folderName)
{
    // [RET]    true    ドキュメントフォルダ
    //          false   ドキュメントフォルダではない
    bool ret = false;
    QFileInfo dir(folderName);
    if(dir.isDir() && (dir.fileName() == FOLDER_DOCUMENT)) ret = true;

    return ret;
}

// --------------------------------------------------------------------------------
QString Config::fileExtensionJpgToDcm(QString jpgFileName)
{
    // ファイル拡張子.jpg を .dcmに変換する
    QString fileName = jpgFileName;
    if(fileName.endsWith(".jpg", Qt::CaseInsensitive)) {
        fileName.chop(4);
        fileName.append(".dcm");
    }

    return fileName;
}
// --------------------------------------------------------------------------------
