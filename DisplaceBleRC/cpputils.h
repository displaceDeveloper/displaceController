#ifndef CPPUTILS_H
#define CPPUTILS_H

#include <QObject>
#include <QQmlEngine>

class CppUtils : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(bool isAndroid READ isAndroid CONSTANT)
    Q_PROPERTY(QString appVersion READ appVersion CONSTANT)

public:
    explicit CppUtils(QObject *parent = nullptr);

    bool isAndroid() const;
    QString appVersion() const;

signals:
};

#endif // CPPUTILS_H
