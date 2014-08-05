#include "iniparam.h"

#include <Windows.h>
#include <QDir>
#include <QFile>
#include <string>
#include <QDebug>
#include <QFileInfo>
#include <QTextStream>


#include <QDebug>


IniParam::IniParam()
{
    init();
}

IniParam::IniParam(QString iniFilePath)
{
    init();
    m_iniFilePath = iniFilePath;
    getParametersFromInit();
}


void IniParam::init()
{
    m_iniFilePath = "list.ini";
    m_connectString = "Driver={SQL Server};Server=127.0.0.1\\SQLEXPRESS;Database=GrandBleuDB;";

    //m_dbFilterForMainFolder = "where pat.PatientID like '20140320%'";
    m_dbFilterForMainFolder = "";
    m_dbFilterForRemoteFolder = "where pat.PatientID like '9%'";
    m_filterForSmartFolder = "CR";


    //
    m_viewerDataFolder= "C:\\Array\\ViewerData\\DICOM";

    m_importerExePath = "C:\\Array\\AOC\\Preludio\\Preludio.exe";
}

void IniParam::getParametersFromInit()
{
    qDebug() << "iniFilePath = " << m_iniFilePath;
//    QFileInfo fInfo(iniFilePath);
//    qDebug() << "finfo absoluteFilePath() = " << fInfo.absoluteFilePath();
//    qDebug() << "finfo absolutePath() = " << fInfo.absolutePath();
//    qDebug() << "finfo baseName() = " << fInfo.baseName();

//    qDebug() << "finfo canonicalFilePath() = " << fInfo.canonicalFilePath();
//    qDebug() << "finfo canonicalPath() = " << fInfo.canonicalPath();
//    qDebug() << "finfo completeBaseName() = " << fInfo.completeBaseName();
//    qDebug() << "finfo completeSuffix() = " << fInfo.completeSuffix();

    //　read ini file　--------------------------------
    WCHAR  buf[1024];
    DWORD  ret;

    //std::wstring sx;
    if ( QFile::exists( m_iniFilePath ) )
    {
        ret = GetPrivateProfileString(TEXT("DB"), TEXT("connectString"),TEXT(""),buf,sizeof(buf)/sizeof(buf[0]), (LPCWSTR)m_iniFilePath.toStdWString().c_str());
        if(ret > 0) {
            //std::wstring sx(buf);
            m_connectString = QString::fromStdWString(std::wstring(buf));
        }
        qDebug() << m_connectString << ret;

        ret = GetPrivateProfileString(TEXT("TEST"), TEXT("dbFilterForMainFolder"),TEXT(""),buf,sizeof(buf)/sizeof(buf[0]), (LPCWSTR)m_iniFilePath.toStdWString().c_str());
        if(ret > 0) {
            m_dbFilterForMainFolder = QString::fromStdWString(std::wstring(buf));
        }
        qDebug() << m_dbFilterForMainFolder << ret;

        ret = GetPrivateProfileString(TEXT("TEST"), TEXT("dbFilterForRemoteFolder"),TEXT(""),buf,sizeof(buf)/sizeof(buf[0]), (LPCWSTR)m_iniFilePath.toStdWString().c_str());
        if(ret > 0) {
            m_dbFilterForRemoteFolder = QString::fromStdWString(std::wstring(buf));
        }
        qDebug() << m_dbFilterForRemoteFolder << ret;

        ret = GetPrivateProfileString(TEXT("TEST"), TEXT("dbfilterForSmartFolder"),TEXT(""),buf,sizeof(buf)/sizeof(buf[0]), (LPCWSTR)m_iniFilePath.toStdWString().c_str());
        if(ret > 0) {
            m_filterForSmartFolder = QString::fromStdWString(std::wstring(buf));
        }
        qDebug() << m_filterForSmartFolder << ret;
    }

    loadModalities();


}

void IniParam::loadModalities()
{
    m_modalityList.clear();

    m_modalityList.append("CR");
    m_modalityList.append("CT");
    m_modalityList.append("DX");
    m_modalityList.append("ECG");
    m_modalityList.append("ES");
    m_modalityList.append("IO");
    m_modalityList.append("MG");
    m_modalityList.append("MR");
    m_modalityList.append("NM");
    m_modalityList.append("OT");
    m_modalityList.append("PT");
    m_modalityList.append("PET");
    m_modalityList.append("RF");
    m_modalityList.append("RG");
    m_modalityList.append("US");
    m_modalityList.append("XA");
    m_modalityList.append("PDF");
    m_modalityList.append("WORD");
    m_modalityList.append("EXCEL");

    qDebug() << "m_modalityList.length=" << m_modalityList.length();
}
