#include "common_functions.h"

QString qstringTrimStart(QString scr_string, QString toTrimString)
{
    QString ret_string = scr_string;

    while(ret_string.startsWith(toTrimString)){
        ret_string = ret_string.remove(0, toTrimString.length());
    }

    return ret_string;
}

QString qstringTrimEnd(QString scr_string, QString toTrimEnd)
{
    QString ret_string = scr_string;

    while(ret_string.endsWith(toTrimEnd)){
        int ipos = ret_string.length() - toTrimEnd.length();
        ret_string = ret_string.left(ipos);
    }

    return ret_string;

}


QString qstringTrim(QString scr_string, QString toTrim)
{
    QString ret_string = scr_string;

    ret_string = qstringTrimStart(ret_string, toTrim);
    ret_string = qstringTrimEnd(ret_string, toTrim);

    return ret_string;
}

