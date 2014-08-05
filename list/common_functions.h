#ifndef COMMON_FUNCTIONS_H
#define COMMON_FUNCTIONS_H
#include <QTextCodec>
#include <QStringList>

QString qstringTrimStart(QString scr_string, QString toTrimString);
QString qstringTrimEnd(QString scr_string, QString toTrimEnd);
QString qstringTrim(QString scr_string, QString toTrim);

#endif // COMMON_FUNCTIONS_H
