#ifndef DIALOGDICOMREAD_H
#define DIALOGDICOMREAD_H

#include <QDialog>
#include "config.h"

class QFileSystemModel;
class QModelIndex;
class QMutex;

namespace Ui {
class DialogDicomRead;
}

// --------------------------------------------------------------------------------
class DialogDicomRead : public QDialog
{
    Q_OBJECT
    
public:
    explicit DialogDicomRead(QWidget *parent = 0, Config *config = 0);
    ~DialogDicomRead();
    void setupUiLang() { setWindowTitle(m_langForm->setupDialogDicomRead(ui)); }     // 表示の言語切り替え

private slots:
    void    on_treeDir_clicked(const QModelIndex &index);
    void    slot_buttonClicked();
    void    slot_cdWatcher();

private:
    Ui::DialogDicomRead *ui;
    Config          *m_config;
    QString         m_destFolder;                   // DICOM生成先
    QFileSystemModel *m_model;
    int             m_countTotal;                   // 対象ファイル数
    int             m_countImport;                  // 取り込んだDICOMファイル数

    void            kensaku(QString folder);
};
// --------------------------------------------------------------------------------

#endif // DIALOGDICOMREAD_H
