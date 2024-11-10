#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

class DbMan;
//models
class BranchModel;

class Backend : public QObject
{
    Q_OBJECT

public:
    explicit Backend(QGuiApplication &app, QObject *parent = nullptr);
public slots:
    void initiate();
    void loadHome();


private:
    DbMan *dbMan;
    QQmlApplicationEngine engine;
};

#endif // BACKEND_H
