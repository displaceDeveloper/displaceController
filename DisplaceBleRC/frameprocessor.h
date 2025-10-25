#ifndef FRAMEPROCESSOR_H
#define FRAMEPROCESSOR_H

#include <QObject>
#include <QQmlEngine>
#include <QImage>

class FrameProcessor : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit FrameProcessor(QObject *parent = nullptr);

public slots:
    void processImage(const QImage &image);

signals:
    void codeDetected(const QString tvCode, const QString pairCode);
};

#endif // FRAMEPROCESSOR_H
