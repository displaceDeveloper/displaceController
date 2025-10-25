#include <ZXingCpp.h>
#include <QDebug>

#include "frameprocessor.h"

FrameProcessor::FrameProcessor(QObject *parent)
    : QObject{parent}
{}

void FrameProcessor::processImage(const QImage &image)
{
    // qDebug() << "Image size: " << image.size();

    QImage img = image;
    if (img.format() != QImage::Format_Grayscale8)
        img = img.convertToFormat(QImage::Format_Grayscale8);


    QByteArray owned = QByteArray(
        reinterpret_cast<const char*>(img.bits()),
        img.bytesPerLine() * img.height()
    );

    auto view = ZXing::ImageView(
        reinterpret_cast<const uint8_t*>(owned.constData()),
        img.width(),
        img.height(),
        ZXing::ImageFormat::Lum,
        img.bytesPerLine()
    );


    auto options = ZXing::ReaderOptions().setFormats(ZXing::BarcodeFormat::QRCode);
    auto barcodes = ZXing::ReadBarcodes(view, options);

    for (const auto& b : barcodes) {
        QString text = QString::fromStdString(b.text());
        if (text.startsWith("DISPLACE_PAIR")) {
            QStringList parts = text.split(":");
            if (parts.size() == 3) {
                QString tvcode = parts[1];
                QString pairCode = parts[2];

                emit codeDetected(tvcode, pairCode);
            }
        }
    }
}
