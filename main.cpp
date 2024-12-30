#include <QGuiApplication>
#include "backend/Backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Backend backend(app);
    return app.exec();
}
