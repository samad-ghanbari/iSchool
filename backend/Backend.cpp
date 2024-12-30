#include "Backend.h"
#include "lib/database/dbman.h"
#include <QFontDatabase>

Backend::Backend(QGuiApplication &app, QObject *parent)
    : QObject{parent}, dbMan(nullptr)
{
    dbMan = new DbMan(this);

    QFontDatabase::addApplicationFont("qrc:/assets/font/yekan.ttf");
    // B Yekan
    const QUrl url(QStringLiteral("qrc:/ui/login/LoginWindow.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("backend", this);
    engine.rootContext()->setContextProperty("dbMan", dbMan);
    engine.load(url);
}

void Backend::loadHome()
{
    const QUrl url(QStringLiteral("qrc:/ui/home/HomeWindow.qml"));
    engine.load(url);
}
