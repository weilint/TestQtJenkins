#include "langform.h"

// --------------------------------------------------------------------------------
LangForm::LangForm(QObject *parent, QString lang) :
    QObject(parent), m_lang(lang)
{
    // Language
    m_ini = new QSettings(":/style/LangForm.ini", QSettings::IniFormat);
    m_ini->setIniCodec("UTF-8");                    // INI file codec
}

// -----------------------------------------------------------------------------
LangForm::~LangForm()
{
    delete m_ini;
}

// -----------------------------------------------------------------------------
QString LangForm::trans(QString key)
{
    return m_ini->value(key + m_lang, "---").toString();
}

// -----------------------------------------------------------------------------
QStringList LangForm::transList(QString key)
{
    return m_ini->value(key + m_lang, "---").toStringList();
}

// -----------------------------------------------------------------------------
void LangForm::setButtonHtmlText(QPushButton *button, QString html)
{
    // ボタンキャプションをhtml形式でセットする
    QTextDocument Text;
    Text.setHtml(html);

    QPixmap pixmap(Text.size().width(), Text.size().height());
    pixmap.fill( Qt::transparent );
    QPainter painter( &pixmap );
    Text.drawContents(&painter, pixmap.rect());

    QIcon ButtonIcon(pixmap);
    button->setIcon(ButtonIcon);
    button->setIconSize(pixmap.rect().size());
}

// -----------------------------------------------------------------------------
void LangForm::setupMainWindow(Ui::MainWindow *ui)
{
    m_ini->beginGroup("MainWindow");

    ui->menu_File->setTitle(trans("MENU_File"));
    ui->action_File_DicomRead->setText(trans("MENU_File_DicomRead"));
    ui->menu_File_Language->setTitle(trans("MENU_File_Langeuge"));
    ui->action_File_Language_English->setText(trans("MENU_File_Langeuge_English"));
    ui->action_File_Language_Japanese->setText(trans("MENU_File_Langeuge_Japanese"));
    ui->action_File_Exit->setText(trans("MENU_Exit"));

    ui->menu_Edit->setTitle(trans("MENU_Edit"));

    ui->menu_Layout->setTitle(trans("MENU_Layout"));
    ui->action_Layout_Column->setText(trans("MENU_Layout_Column"));
    ui->action_Layout_FolderHigh->setText(trans("MENU_Layout_FolderHigh"));
    ui->action_Layout_PreviewWide->setText(trans("MENU_Layout_PreviewWidw"));
    ui->action_Layout_StyleNorm->setText(trans("MENU_Layout_StyleNorm"));
    ui->action_Layout_StyleDark->setText(trans("MENU_Layout_StyleDark"));

    ui->toolBar_Layout->setWindowTitle(trans("TOOLBAR_Layout"));
    ui->toolBar_Search->setWindowTitle(trans("TOOLBAR_Search"));

    m_ini->endGroup();

    // リソースアイコン切り替え
    if(m_lang==Lang::EN) ui->menu_File_Language->setIcon(QIcon(":/res/flag_usa.png"));
    if(m_lang==Lang::JP) ui->menu_File_Language->setIcon(QIcon(":/res/flag_japan.png"));
}

// -----------------------------------------------------------------------------
QString LangForm::setupDialogDicomRead(Ui::DialogDicomRead *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("DialogDicomRead");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupToolbarSearch(Ui::ToolbarSearch *ui)
{
    m_ini->beginGroup("ToolbarSearch");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    // モダリティリスト
    m_ini->beginGroup("ToolbarSearch_ModalityList");
    QStringList list;                                   // Key名から国識別子を除外する。これがmodality
    foreach (QString key, m_ini->childKeys()) {
        int dotPos = key.lastIndexOf(".");
        if(dotPos >= 0) key = key.left(dotPos);
        if( !list.contains(key) ) list.append(key);
    }

    ui->cbModality->blockSignals(true);
    ui->cbModality->clear();
    m_modalityList.clear();
    foreach (QString modality, list) {
        ui->cbModality->addItem(trans(modality));
        m_modalityList.append(modality);
    }
    ui->cbModality->blockSignals(false);
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QStringList LangForm::setupList1(Ui::List1 *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("List1");
    // List1は、「患者リスト」「患者検査リスト」の２画面で使いまわしていて、WindowTitleも複数登録されている
    QStringList windowTitleList = transList("WindowTitle");

    ui->btnSimple->setText(trans("ButtonSimple"));
    ui->btnRich->setText(trans("ButtonRich"));
    m_ini->endGroup();

    return windowTitleList;
}

// -----------------------------------------------------------------------------
QString LangForm::setupList2(Ui::List2 *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("List2");
    QString windowTitle = trans("WindowTitle");

    ui->btnSimple->setText(trans("ButtonSimple"));
    ui->btnRich->setText(trans("ButtonRich"));
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupListHtml(Ui::ListHtml *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("ListHtml");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupListText(Ui::ListText *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("ListText");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupPreviewTable(Ui::PreviewTable *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("PreviewTable");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupPreviewLine(Ui::PreviewLine *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("PreviewLine");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupMatrix(Ui::Matrix *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("Matrix");

    QString windowTitle = trans("WindowTitle");
    ui->lblModality->setText(trans("LabelModality"));
    ui->rbTypical->setText(trans("RadioButtonTypical"));
    ui->rbLineup->setText(trans("RadioButtonLineup"));
    ui->rbDaily->setText(trans("RadioButtonDaily"));

    // モダリティリスト
    ui->lstModality->clear();
    QStringList modalityList = transList("ModalityList");
    foreach (QString modality, modalityList) ui->lstModality->addItem(modality);

    m_ini->endGroup();
    return windowTitle;
}

// -----------------------------------------------------------------------------
QString LangForm::setupWorkspace(Ui::Workspace *ui)
{
    Q_UNUSED(ui)

    m_ini->beginGroup("Workspace");
    QString windowTitle = trans("WindowTitle");
    m_ini->endGroup();

    return windowTitle;
}

// --------------------------------------------------------------------------------
