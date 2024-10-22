#ifndef DBMAN_H
#define DBMAN_H

#include <QObject>
//#include <QtQml/qqml.h>
#include <QSqlQuery>
#include <QJsonObject>
#include <QJsonArray>

class DbMan : public QObject
{
    Q_OBJECT
    // QML_SINGLETON
    // QML_ELEMENT

public:
    explicit DbMan(QObject *parent = nullptr);

public slots:
    //USER
    bool isDbConnected();
    QString getVersion();
    QString getAppVersion();
    bool isOnMaintenance();
    bool newRelease();
    QString getLastError();
    bool userAuthenticate(QString natid, QString password);
    QJsonObject getUser();
    QJsonObject getUser(int userId);
    QByteArray getUserByteArray();
    QByteArray getUserByteArray(int userId);
    QString getUserName();
    bool insertUser(QJsonObject user);
    QByteArray getUsersByteArray();
    QJsonArray filterUsers(QJsonObject userFilter);
    bool updateUser(QJsonObject user);
    bool deleteUser(int userId);
    bool verifyUserPassword(QString password);
    bool changeUserPassword(int id, QString password);


    // LOG


    void insertLog(QString Target, QString Action, QString ActionDetail );


    //BRANCHES
    QByteArray getBranchesJson();
    QJsonObject getBranchJson(int id);
    QJsonArray getBranches();
    QByteArray getBranchesJsonById(QList<int> branches);
    QList<int> getUserBranch(int userId);
    bool updateBranch(QJsonObject branch);
    bool deleteBranch(int id);
    bool insertBranch(QJsonObject branchObj);

    //STEPS
    QByteArray getStepsByteArray(QList<int> branches);
    QJsonArray getSteps(QList<int> branches);
    QJsonArray getStepsById(QList<int> steps);
    QJsonArray getStepsById(QList<int> branches, QList<int> steps);
    QList<int> getStepsBranch(QList<int> stepsId);
    QJsonArray getBranchStepsJson(int branchId);
    QByteArray getStepsJsonById(QList<int> steps);
    bool insertStep(QJsonObject step);
    bool deleteStep(int stepId);
    bool updateStep(QJsonObject step);
    QJsonObject getStepJson(int stepId);

    //STUDY BASES
    QByteArray getStudyBasesByteArray(QList<int> branches);
    QList<int> getStudyBaseBranch(QList<int> baseId);
    QJsonArray getStudyBases(QList<int> branches);
    QJsonArray getStudyBasesById(QList<int> bases);
    QJsonArray getStudyBasesById(QList<int>  branches, QList<int> bases);
    QByteArray getBasisJsonById(QList<int> basis);
    QJsonObject getBasisById(int id);
    QJsonArray getStepBasis(int stepId);
    bool insertBasis(QJsonObject basis);
    bool updateBasis(QJsonObject basis);
    bool deleteBasis(int basisId);

    // STUDY PERIODS
    QJsonArray getBasisStudyPeriods(int basisId);
    QJsonObject getStudyPeriod(int periodId);
    bool studyPeriodUpdate(QJsonObject periodObj);
    bool studyPeriodInsert(QJsonObject periodObj);
    bool studyPeriodDelete(int periodId);


private:
    QString lastError;
    bool dbConnected;
    QSqlQuery *query;
    QJsonObject user;
};

#endif // DBMAN_H
