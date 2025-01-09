#include "Backend.h"
#include "lib/database/dbman.h"
//#include "lib/model/studentStatModel.h"
#include <QJsonObject>
#include <QFontDatabase>

Backend::Backend(QGuiApplication &app, QObject *parent)
    : QObject{parent}, dbMan(nullptr), studentStatModel(nullptr)
{
    dbMan = new DbMan(this);
    //studentStatModel = new StudentStatModel(this);


    // register fonts
    // usage name
    // B Yekan
    // IranNastaliq
    // Far.Afaaq
    //The Phamelo
    //Daughter of Fortune

    QFontDatabase::addApplicationFont(":/assets/font/yekan.ttf"); // B Yean
    QFontDatabase::addApplicationFont(":/assets/font/ZarBd.ttf"); // Zar
    QFontDatabase::addApplicationFont(":/assets/font/TitrBd.ttf"); //Titr
    QFontDatabase::addApplicationFont(":/assets/font/Far.Afaaq.ttf");
    QFontDatabase::addApplicationFont(":/assets/font/Phamelo.ttf");
    int ii =QFontDatabase::addApplicationFont(":/assets/font/Kalameh.ttf");


    // //Retrieve and print the font family name
    // QStringList fontFamilies = QFontDatabase::applicationFontFamilies(ii);
    // if (!fontFamilies.isEmpty()) {
    //     QString fontFamily = fontFamilies.at(0);
    //     qDebug() << "Font family:" << fontFamily;
    // } else {
    //     qWarning() << "No font families found!";
    // }


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
    //engine.rootContext()->setContextProperty("studentStatModel", studentStatModel);
    engine.loadFromModule("iSchool", "LoginWindow");
}

void Backend::loadHome()
{
    bool admin = dbMan->isUserAdmin();
    bool superAdmin = dbMan->isUserSuperAdmin();
    engine.rootContext()->setContextProperty("admin", admin);
    engine.rootContext()->setContextProperty("superAdmin", superAdmin);
    engine.loadFromModule("iSchool", "HomeWindow");
}
