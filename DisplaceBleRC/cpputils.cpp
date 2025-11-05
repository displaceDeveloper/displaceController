#include "cpputils.h"

CppUtils::CppUtils(QObject *parent)
    : QObject{parent}
{}

bool CppUtils::isAndroid() const
{
#if defined(Q_OS_ANDROID)
    return true;
#else
    return false;
#endif
}

QString CppUtils::appVersion() const
{
    return APP_VER;
}
