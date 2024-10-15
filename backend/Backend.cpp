#include "Backend.h"
#include "lib/database/dbman.h"
#include <QJsonObject>

Backend::Backend(QGuiApplication &app, QObject *parent)
    : QObject{parent}, dbMan(nullptr)
{
    dbMan = new DbMan(this);

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
}

void Backend::initiate()
{
    engine.rootContext()->setContextProperty("backend", this);
    engine.rootContext()->setContextProperty("dbMan", dbMan);
    engine.loadFromModule("iSchool", "LoginWindow");
}

void Backend::loadHome()
{
    engine.loadFromModule("iSchool", "HomeWindow");
}
