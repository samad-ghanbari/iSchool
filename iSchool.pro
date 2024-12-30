QT += core quick sql printsupport

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        backend/Backend.cpp \
        lib/database/dbman.cpp \
        lib/export/jsontable.cpp \
        lib/export/pdfjsontable.cpp \
        main.cpp

RESOURCES += qml.qrc \
fonts.qrc \
images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    backend/Backend.h \
    lib/database/dbman.h \
    lib/export/jsontable.h \
    lib/export/pdfjsontable.h \
    lib/export/tableTemplate.h


RC_ICONS = icon.ico
