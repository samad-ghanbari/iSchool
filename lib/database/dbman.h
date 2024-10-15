#ifndef DBMAN_H
#define DBMAN_H

#include <QObject>
#include <QSqlQuery>
#include <QJsonObject>
#include <QJsonArray>

class DbMan : public QObject
{
    Q_OBJECT
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
    QJsonObject getUserJson();
    QByteArray getUserByteArray();
    QJsonObject getUserJson(int userId);
    QByteArray getUserByteArray(int userId);
    QString getUserName();
    bool insertUser(QJsonObject user);
    QByteArray getUsersByteArray();
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
    bool updateBranch(QJsonObject branch);
    bool deleteBranch(int id);
    bool insertBranch(QJsonObject branchObj);

    //STEPS
    QByteArray getStepsJson(QList<int> branches);
    QJsonArray getBranchStepsJson(int branchId);
    QByteArray getStepsJsonById(QList<int> steps);
    bool insertStep(QJsonObject step);
    bool deleteStep(int stepId);
    bool updateStep(QJsonObject step);
    QJsonObject getStepJson(int stepId);

    //BASES
    QByteArray getBasisJson(QList<int> steps);
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
