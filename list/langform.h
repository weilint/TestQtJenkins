#ifndef LANGFORM_H
#define LANGFORM_H

#include <QObject>
#include <QMap>
#include <QStringList>
#include <QTextCodec>

#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )

QT_BEGIN_NAMESPACE
class QLabel;
class QPushButton;
class QSettings;
QT_END_NAMESPACE

namespace Ui {
class MainWindow;
class DialogDicomRead;
class ToolbarSearch;
class Workspace;
class List1;
class List2;
class ListHtml;
class ListText;
class Matrix;
class PreviewTable;
class PreviewLine;
}

namespace Lang {
const QString EN = ".en";
const QString JP = ".jp";
}

// --------------------------------------------------------------------------------
class LangForm : public QObject
{
    Q_OBJECT
public:
    explicit LangForm(QObject *parent = 0, QString lang = Lang::EN);
    ~LangForm();

    void    setupMainWindow(Ui::MainWindow *);
    QString setupDialogDicomRead(Ui::DialogDicomRead *);
    QString setupToolbarSearch(Ui::ToolbarSearch *);
    QString setupWorkspace(Ui::Workspace *);
    QStringList setupList1(Ui::List1 *);
    QString setupList2(Ui::List2 *);
    QString setupListHtml(Ui::ListHtml *);
    QString setupListText(Ui::ListText *);
    QString setupMatrix(Ui::Matrix *);
    QString setupPreviewTable(Ui::PreviewTable *);
    QString setupPreviewLine(Ui::PreviewLine *);

    void    setLang(QString lang) {
        Q_ASSERT(lang==Lang::EN || lang==Lang::JP);
        m_lang = lang;
    }

    QString     langWithoutDot() {return m_lang.mid(1);}        // "jp"とかを返す
    QStringList modalityList() {return m_modalityList;}         // 補助検索BOXのモダリティリストを返す

signals:
    
public slots:
    
private:
    QString     m_lang;
    QSettings   *m_ini;
    QMap <QString, QString> m_printConfirm;
    QStringList m_modalityList;

    QString     trans(QString);
    QStringList transList(QString);
    void        setButtonHtmlText(QPushButton *, QString);
};
// --------------------------------------------------------------------------------

#endif // LANGFORM_H
