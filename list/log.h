#ifndef LOG_H
#define LOG_H

#include <QObject>

// --------------------------------------------------------------------------------
class Log : public QObject
{
    Q_OBJECT
public:
    explicit Log(QObject *parent = 0);
    ~Log();

public slots:
    void slot_log(QString message);

};
// --------------------------------------------------------------------------------

#endif // LOG_H
