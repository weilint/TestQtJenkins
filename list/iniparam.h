#ifndef INIPARAM_H
#define INIPARAM_H

#include <QTextCodec>
#include <QStringList>

enum N_FOLDER {
    N_MainFolder = 0,
    N_SmartFolder,
    N_RemoteFolder
};


class IniParam
{
public:
    IniParam();
    IniParam(QString iniFilePath);

public:
    QString m_iniFilePath;
    QString m_connectString;

    QStringList m_modalityList;

    //DB検索条件
    QString m_dbFilterForMainFolder;
    QString m_dbFilterForRemoteFolder;

    //スマートフォルダの検索条件　（MainFolderのサブセット）
    QString m_filterForSmartFolder;

    //ビューアーとの連携フォルダ
    QString m_viewerDataFolder;


    //Preludio.exe
    QString m_importerExePath;


private:
    void init();
    void getParametersFromInit();
    void loadModalities();
};

#endif // INIPARAM_H
