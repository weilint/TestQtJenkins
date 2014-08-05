#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>
#include <QApplication>

#define MOUSE_BUSY          QApplication::setOverrideCursor(Qt::BusyCursor)
#define MOUSE_WAIT          QApplication::setOverrideCursor(Qt::WaitCursor)
#define MOUSE_RESTORE       QApplication::restoreOverrideCursor()
#define PROCESS_EVENT       QApplication::processEvents(QEventLoop::ExcludeUserInputEvents) // ユーザー入力無効

// --------------------------------------------------------------------------------
class Config : public QObject
{
    Q_OBJECT

public:
    explicit Config(QObject *parent = 0);
    QString     appVer();
    QString     folderRoot() {return m_folderRoot;}
    QString     fileSetting();
    QString     folderListStyle();                          // リッチ表示のhtml格納先
    QString     folderWorkspaceImport();                    // DICOMファイル取り込先
    QString     folderRelativeWorkspace();                  // 実行フォルダからの相対パス
    QString     fileRelativeWorkspace(QString fileName);    // DICOMファイル取り込先からの相対パスに変換
    bool        isImportDocumentFolder(QString filderName);
    QString     fileExtensionJpgToDcm(QString jpgFileName); // .jpg を .dcmに変換する

private:
    QString     m_folderRoot;
};
// --------------------------------------------------------------------------------

#endif // CONFIG_H
