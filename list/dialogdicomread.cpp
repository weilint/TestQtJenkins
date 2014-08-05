#include <QtGui>
#include <QFileSystemModel>
#include "dicom.h"
#include "dialogdicomread.h"
#include "ui_dialogdicomread.h"

#define  THUMBNAIL_WIDTH    80
#define  THUMBNAIL_HEIGHT   80

// --------------------------------------------------------------------------------
DialogDicomRead::DialogDicomRead(QWidget *parent, Config *config, LangForm *langform) :
    QDialog(parent), m_config(config), m_langForm(langform), ui(new Ui::DialogDicomRead)
{
    ui->setupUi(this);
    setupUiLang();
    setStyleSheet("QLabel { background-color : #F0F0F0; color : black; }");

    // DIRページ
    m_model = new QFileSystemModel;
    m_model->setFilter(QDir::AllDirs | QDir::NoDotAndDotDot);
    m_model->setRootPath("");
    ui->treeDir->setModel(m_model);

    ui->treeDir->show();
    ui->treeDir->setColumnHidden(0, false);
    ui->treeDir->setColumnHidden(1, true);
    ui->treeDir->setColumnHidden(2, true);
    ui->treeDir->setColumnHidden(3, true);

    // 読み込み前情報表示ページ

    // 最初に開くページ
    ui->stackedWidget->setCurrentIndex(0);
    ui->btnBack->setEnabled(false);
    ui->btnNext->setEnabled(false);

    // CD挿入監視タイマー
    QTimer *cdWatcher = new QTimer(this);
    connect(cdWatcher, SIGNAL(timeout()), this, SLOT(slot_cdWatcher()));
    cdWatcher->start(3000);

    connect(ui->btnBack, SIGNAL(clicked()), this, SLOT(slot_buttonClicked()));
    connect(ui->btnNext, SIGNAL(clicked()), this, SLOT(slot_buttonClicked()));
}

// --------------------------------------------------------------------------------
DialogDicomRead::~DialogDicomRead()
{
    delete m_model;
    delete ui;
}

// --------------------------------------------------------------------------------
void DialogDicomRead::slot_cdWatcher()
{
    // CD挿入監視
    // C:～のドライブ名が変わったことで検出する
    QFileSystemModel tmpModel;
    tmpModel.setFilter(QDir::AllDirs | QDir::NoDotAndDotDot);
    tmpModel.setRootPath("");

    bool isCdInsert = false;

#ifdef Q_OS_WIN
    if(tmpModel.columnCount() == m_model->columnCount()) {
        QString driveList = "CDEFGHIJKLMNOPQRSTUVWXYZ";         // ドライブレター

        for(int i=0; i<tmpModel.columnCount(); i++) {
            QString drive = driveList.mid(i,1) + ":/";

            if(drive.isEmpty()) {
                isCdInsert = true;
                break;
            }

            if(tmpModel.fileName(tmpModel.index(drive, 0)) != m_model->fileName(m_model->index(drive, 0))) {
                isCdInsert = true;
                break;
            }
        }
    } else {
        isCdInsert = true;
    }

#else
	// Windows以外では、CDの挿入検出に対応していない

#endif

    if(isCdInsert) {
        delete m_model;
        m_model = new QFileSystemModel;
        m_model->setFilter(QDir::AllDirs | QDir::NoDotAndDotDot);
        m_model->setRootPath("");
        ui->treeDir->setModel(m_model);
    }
}

// --------------------------------------------------------------------------------
void DialogDicomRead::slot_buttonClicked()
{
    QPushButton *btn = (QPushButton *)(sender());
    QString btnName = btn->objectName();
    int currentPage = ui->stackedWidget->currentIndex();
    int nextPage = -1;

    if( btnName == "btnBack" ) {
        nextPage = currentPage - 1;
        if(nextPage < 0) nextPage = 0;

    } else if(btnName == "btnNext") {
        nextPage = currentPage + 1;
        if(nextPage >= ui->stackedWidget->count()) nextPage = ui->stackedWidget->count() - 1;
    }

    if(nextPage == currentPage) return;

    ui->btnNext->setVisible(true);
    ui->btnBack->setVisible(true);

    switch(nextPage) {
    case 0:
        // Dir page
        ui->btnNext->setVisible(true);
        ui->btnBack->setVisible(true);
        ui->btnBack->setEnabled(false);
        ui->btnNext->setText("Next >>");
        ui->btnNext->setEnabled(true);
        break;

    case 1: {
        // 読込条件表示
        ui->btnNext->setText("<< Back");
        ui->btnBack->setEnabled(true);
        ui->btnNext->setText("Read");
        ui->btnNext->setEnabled(true);

        QModelIndex index= ui->treeDir->currentIndex();
        QString str;
        str = QString(JTR("次のフォルダのDICOMファイルを読み込みます。<br /><br />%1")).arg(m_model->filePath(index));
        ui->lblPreinfo->setText(str);
        break;
        }

    case 2: {
        // DICOM読み込み中
        ui->btnNext->setVisible(false);
        ui->btnBack->setVisible(false);

        ui->stackedWidget->setCurrentIndex(nextPage);

        // DICOM展開先フォルダを決める
        m_destFolder = m_config->folderWorkspaceImport() + QDateTime::currentDateTime().toString("yyyyMMdd/hhmmss") + "/";
        QDir dir;
        dir.mkpath(m_destFolder);

        // DICOMファイルを検索する
        m_countTotal = 0;
        m_countImport = 0;
        QApplication::setOverrideCursor(Qt::WaitCursor);
        ui->edLog->clear();
        QString startFolder = m_model->filePath(ui->treeDir->currentIndex());
        kensaku(startFolder);

        ui->edLog->append("--- Summary ---");
        ui->edLog->append(QString(JTR("Total files: %L1").arg(m_countTotal)));
        ui->edLog->append(QString(JTR("Import files: %L1").arg(m_countImport)));
        ui->edLog->append(QString(JTR("Skipped files: %L1").arg(m_countTotal - m_countImport)));

        QApplication::restoreOverrideCursor();

        // Closeボタン機能をセット
        ui->btnNext->setText("Close");
        ui->btnNext->setVisible(true);
        disconnect(ui->btnNext, SIGNAL(clicked()), this, SLOT(slot_buttonClicked()));
        connect(ui->btnNext, SIGNAL(clicked()), this, SLOT(close()));

        break;
        }
    }

    ui->stackedWidget->setCurrentIndex(nextPage);
}

// --------------------------------------------------------------------------------
void DialogDicomRead::on_treeDir_clicked(const QModelIndex &index)
{
    // Tree dir がクリックされた
    if(m_model->filePath(index).isEmpty()) {
        ui->btnNext->setEnabled(false);             // Dir未選択状態にする
    } else {
        ui->btnNext->setEnabled(true);
    }
}

// --------------------------------------------------------------------------------
void DialogDicomRead::kensaku(QString folder)
{
    // サブフォルダも含め、全ファイルを検索する
    QDir dirKensaku(folder);
    if( ! dirKensaku.exists()) return;

    foreach(QFileInfo info, dirKensaku.entryInfoList(QDir::NoDotAndDotDot | QDir::AllDirs | QDir::Files)) {

        QString fileName = info.absolutePath() + "/" + info.fileName();

        if(info.isDir()) {
            // サブフォルダを検索
            kensaku(fileName + "/");
            continue;
        }

        m_countTotal++;

        // DICOMファイル展開
        QString msg = fileName;
        for(;;) {

            Dicom dicom(this,fileName);
            if( !dicom.error().isEmpty() ) {
                msg.append(" -- open error");
                break;
            }

            // 画像サイズ
            quint32 imageHeight=0, imageWidth=0;
            if( !dicom.tagValue("0028,0010", &imageHeight, true) ) {
                msg.append(" -- Image height error");
                break;
            }

            if( !dicom.tagValue("0028,0011", &imageWidth, true) ) {
                msg.append(" -- Image width error");
                break;
            }

            #if 0
            // UID
            QByteArray PatientID, StudyInstanceUID, SeriesInstanceUID, SopInstanceUID;
            if( !dicom.elementData("0010,0020", &PatientID) ) {
                msg.append(" -- PatientID error");
                break;
            }

            if( !dicom.elementData("0020,000D", &StudyInstanceUID) ) {
                msg.append(" -- StudyInstanceUID error");
                break;
            }

            if( !dicom.elementData("0020,000E", &SeriesInstanceUID) ) {
                msg.append(" -- SeriesInstanceUID error");
                break;
            }

            if( !dicom.elementData("0008,0018", &SopInstanceUID) ) {
                msg.append(" -- SopInstanceUID error");
                break;
            }
            #endif

            // 画像フォルダを作って展開する
            QDir dir(m_destFolder);
            // サムネイル リサイズ
            int thumbHeight, thumbWidth;
            if(imageHeight > imageWidth) {
                thumbHeight = THUMBNAIL_HEIGHT;
                thumbWidth = thumbHeight * imageWidth / imageHeight;
            } else {
                thumbWidth = THUMBNAIL_WIDTH;
                thumbHeight = thumbWidth * imageHeight / imageWidth;
            }

            QString createFileName = dir.absoluteFilePath(QString("%1").arg(m_countImport + 1));

            if(dicom.makeThumbnail( createFileName + ".jpg", QSize(thumbWidth, thumbHeight) ) ) {
                msg.append(" -- MakeThumbnail error");
                break;
            }

            if( !QFile::copy(fileName, createFileName + ".dcm") ) {
                msg.append(" -- Copy error");
                break;
            }

            m_countImport++;
            break;
        }

        ui->edLog->append(msg);
        QApplication::processEvents(QEventLoop::ExcludeUserInputEvents);	// ユーザー入力を無視する。
    }
}

// --------------------------------------------------------------------------------
