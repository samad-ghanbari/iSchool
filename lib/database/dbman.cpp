#include "dbman.h"
#include <QSqlDatabase>
#include <QSqlError>
#include <QCryptographicHash>
#include "lib/version.h"
#include <QJsonDocument>

#include <QDebug>

DbMan::DbMan(QObject *parent)
    : QObject{parent},  query(nullptr)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
    db.setHostName("127.0.0.1");
    db.setUserName("admin");
    db.setPassword("Samad.@2514");
    db.setDatabaseName("schooldb");
    user.empty();

    if(db.open())
    {
        dbConnected = true;
        query = new QSqlQuery(db);
    }
    else
    {
        dbConnected = false;
        lastError = db.lastError().text();
    }
}


// USER

bool DbMan::isDbConnected()
{
    return this->dbConnected;
}

QString DbMan::getVersion()
{
    QString _version="0";
    query->prepare("SELECT app_version	FROM main.app_versions ORDER BY app_version DESC Limit 1;");
    if(query->exec())
    {
        if(query->next())
            _version = query->value(0).toString();
    }
    return _version;
}

QString DbMan::getAppVersion()
{
    return APP_VERSION;
}

bool DbMan::isOnMaintenance()
{
    bool onMaintenance = false;
    QString version = this->getVersion();
    query->prepare("SELECT maintenance_mode	FROM main.app_versions WHERE app_version=?;");
    query->bindValue(0, version);
    if(query->exec())
    {
        if(query->next())
            onMaintenance = query->value(0).toBool();
    }

    return onMaintenance;
}

bool DbMan::newRelease()
{
    QString newVersion = this->getVersion();
    if(newVersion > APP_VERSION)
        return true;
    else
        return false;
}

QString DbMan::getLastError()
{
    return lastError;
}

bool DbMan::userAuthenticate(QString natid, QString password)
{
    bool ok = false;
    password =  QString(QCryptographicHash::hash(password.toUtf8(),QCryptographicHash::Sha1).toHex());
    query->prepare("SELECT id, name, lastname, gender, nat_id, password, job_position, telephone, permissions, enabled, admin	FROM main.users WHERE nat_id=? AND password=? AND enabled=true;");
    query->bindValue(0, natid);
    query->bindValue(1, password);
    if(query->exec())
    {
        if(query->next())
        {
            ok = true;

            user["id"] = query->value(0).toInt();
            user["name"] = query->value(1).toString();
            user["lastname"] = query->value(2).toString();
            user["gender"] = query->value(3).toString();
            user["nat_id"] = query->value(4).toString();
            user["job_position"] = query->value(6).toString();
            user["telephone"] = query->value(7).toString();
            user["permissions"] = QJsonDocument::fromJson(query->value(8).toByteArray()).object();
            user["enabled"] = query->value(9).toBool();
            user["admin"] = query->value(10).toBool();
        }
    }

    return ok;
}

QJsonObject DbMan::getUser()
{
    return user;
}

QByteArray DbMan::getUserByteArray()
{
    QJsonDocument doc(user);
    return doc.toJson();
}

QJsonObject DbMan::getUser(int userId)
{
    QJsonObject USER;
    query->prepare("SELECT id, name, lastname, gender, nat_id, job_position, telephone, permissions, enabled, admin FROM main.users WHERE id=?;");
    query->bindValue(0, userId);
    if(query->exec())
    {
        if(query->next())
        {
            USER["id"] = query->value(0).toInt();
            USER["name"] = query->value(1).toString();
            USER["lastname"] = query->value(2).toString();
            USER["gender"] = query->value(3).toString();
            USER["nat_id"] = query->value(4).toString();
            USER["job_position"] = query->value(5).toString();
            USER["telephone"] = query->value(6).toString();
            USER["permissions"] = QJsonDocument::fromJson(query->value(7).toByteArray()).object();
            USER["enabled"] = query->value(8).toBool();
            USER["admin"] = query->value(9).toBool();
        }
    }

    return USER;
}

QByteArray DbMan::getUserByteArray(int userId)
{
    QJsonObject USER = this->getUser(userId);
    QJsonDocument doc(USER);
    return doc.toJson();
}

QString DbMan::getUserName()
{
    return user["name"].toString();
}

bool DbMan::insertUser(QJsonObject user)
{
    // name lastname gender nat_id password passwordConfirm job_position telephone enabled admin permissions

    QString name = user.value("name").toString();
    QString lastname = user.value("lastname").toString();
    QString gender = user.value("gender").toString();
    QString nat_id = user.value("nat_id").toString();
    QString password = user.value("password").toString();
    QString job_position = user.value("job_position").toString();
    QString telephone = user.value("telephone").toString();
    bool enabled = user.value("enabled").toBool();
    bool admin = user.value("admin").toBool();

    QJsonObject perm = user.value("permissions").toObject();

    QString permissions =  QString::fromUtf8(QJsonDocument(perm).toJson()); //QJsonDocument::Compact


    //check
    bool NAME, LASTNAME, NATID, PASS, JOB_POS, EN, ADMIN;
    NAME = (name.isEmpty())? true : false;
    LASTNAME = (lastname.isEmpty())? true : false;
    NATID = (nat_id.isEmpty())? true : false;
    PASS = (password.isEmpty())? true : false;
    JOB_POS = (job_position.isEmpty())? true : false;

    if(NAME || LASTNAME || NATID || PASS || JOB_POS)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    //hash pass
    password =  QString(QCryptographicHash::hash(password.toUtf8(),QCryptographicHash::Sha1).toHex());

    if(admin)
    {
        permissions = "{}";
    }

    query->prepare("INSERT INTO main.users(name, lastname, gender, nat_id, password, job_position, telephone, permissions, enabled, admin) VALUES (:name, :lastname, :gender, :natid, :password, :job_position, :telephone, :permissions, :enabled, :admin);");
    query->bindValue(":name", name, QSql::In);
    query->bindValue(":lastname", lastname, QSql::In);
    query->bindValue(":gender", gender, QSql::In);
    query->bindValue(":natid", nat_id, QSql::In);
    query->bindValue(":password", password, QSql::In);
    query->bindValue(":job_position", job_position, QSql::In);
    query->bindValue(":telephone", telephone, QSql::In);
    query->bindValue(":permissions", permissions, QSql::In);
    query->bindValue(":enabled", enabled, QSql::In);
    query->bindValue(":admin", admin, QSql::In);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

QByteArray DbMan::getUsersByteArray()
{
    QJsonArray array;

    query->prepare("SELECT id, name, lastname, nat_id, job_position, enabled, admin, gender FROM main.users ORDER BY admin DESC, lastname DESC;");
    if(query->exec())
    {
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["name"] = query->value(1).toString();
            obj["lastname"] = query->value(2).toString();
            obj["nat_id"] = query->value(3).toString();
            obj["job_position"] = query->value(4).toString();
            obj["enabled"] = query->value(5).toBool();
            obj["admin"] = query->value(6).toBool();
            obj["gender"] = query->value(7).toString();

            array.append(obj);
        }
    }

    QJsonDocument doc(array);
    return doc.toJson();
}

QJsonArray DbMan::filterUsers(QJsonObject userFilter)
{
    QJsonArray array;


    query->prepare("SELECT id, name, lastname, nat_id, job_position, enabled, admin, gender FROM main.users WHERE name like :name AND lastname like :lastname AND nat_id like :nat_id AND job_position like :job_position ORDER BY admin DESC, lastname DESC;");
    query->bindValue(":name", QString("%%1%").arg(userFilter.value("name").toString()));
    query->bindValue(":lastname",  QString("%%1%").arg(userFilter.value("lastname").toString()));
    query->bindValue(":nat_id", QString("%%1%").arg(userFilter.value("nat_id").toString()));
    query->bindValue(":job_position", QString("%%1%").arg(userFilter.value("job_position").toString()));

    if(query->exec())
    {
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["name"] = query->value(1).toString();
            obj["lastname"] = query->value(2).toString();
            obj["nat_id"] = query->value(3).toString();
            obj["job_position"] = query->value(4).toString();
            obj["enabled"] = query->value(5).toBool();
            obj["admin"] = query->value(6).toBool();
            obj["gender"] = query->value(7).toString();

            array.append(obj);
        }
    }

    return array;
}

bool DbMan::updateUser(QJsonObject user)
{
    //  name lastname gender nat_id job_position telephone enabled admin permissions

    int id = user.value("id").toInt();
    QString name = user.value("name").toString();
    QString lastname = user.value("lastname").toString();
    QString gender = user.value("gender").toString();
    QString nat_id = user.value("nat_id").toString();
    QString job_position = user.value("job_position").toString();
    QString telephone = user.value("telephone").toString();
    bool enabled = user.value("enabled").toBool();
    bool admin = user.value("admin").toBool();
    QJsonObject perm = user.value("permissions").toObject();

    QString permissions =  QString::fromUtf8(QJsonDocument(perm).toJson()); //QJsonDocument::Compact

    //check
    bool NAME, LASTNAME, NATID, PASS, JOB_POS, EN, ADMIN;
    NAME = (name.isEmpty())? true : false;
    LASTNAME = (lastname.isEmpty())? true : false;
    NATID = (nat_id.isEmpty())? true : false;
    JOB_POS = (job_position.isEmpty())? true : false;

    if(NAME || LASTNAME || NATID || JOB_POS)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }


    if(admin)
    {
        permissions = "{}";
    }


    query->prepare("UPDATE main.users SET  name=:name, lastname=:lastname, gender=:gender, nat_id=:nat_id,  job_position=:job_position, telephone=:telephone, permissions=:permissions, enabled=:enabled, admin=:admin WHERE id=:id;");
    query->bindValue(":name", name, QSql::In);
    query->bindValue(":lastname", lastname, QSql::In);
    query->bindValue(":gender", gender, QSql::In);
    query->bindValue(":nat_id", nat_id, QSql::In);
    query->bindValue(":job_position", job_position, QSql::In);
    query->bindValue(":telephone", telephone, QSql::In);
    query->bindValue(":permissions", permissions, QSql::In);
    query->bindValue(":enabled", enabled, QSql::In);
    query->bindValue(":admin", admin, QSql::In);

    query->bindValue(":id", id, QSql::In);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }

}

bool DbMan::deleteUser(int userId)
{
    query->prepare("DELETE FROM main.users WHERE id=?;");
    query->bindValue(0, userId);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::verifyUserPassword(QString password)
{
    password =  QString(QCryptographicHash::hash(password.toUtf8(),QCryptographicHash::Sha1).toHex());
    query->prepare("SELECT id FROM main.users WHERE id=? AND password=? AND enabled=true;");
    query->bindValue(0, user.value("id").toInt());
    query->bindValue(1, password);
    if(query->exec())
    {
        if(query->next())
        {
            int id = query->value(0).toInt();
            if(id >= 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    else
        return false;
}

bool DbMan::changeUserPassword(int id, QString password)
{
    password =  QString(QCryptographicHash::hash(password.toUtf8(),QCryptographicHash::Sha1).toHex());
    query->prepare("UPDATE main.users  SET password=? WHERE id=?;");
    query->bindValue(0, password);
    query->bindValue(1, id);
    if(query->exec())
        return true;
    else
        return false;
}



// LOG
void DbMan::insertLog(QString Target, QString Action, QString ActionDetail)
{
    int UserId = user.value("id").toInt();
    QString CurrentTime = QDate::currentDate().toString();

    query->prepare("INSERT INTO main.logs(user_id, log_time, target, action, action_detail)	VALUES (?, ?, ?, ?);");
    query->bindValue(0, UserId);
    query->bindValue(1, CurrentTime);
    query->bindValue(2, Target);
    query->bindValue(3, Action);
    query->bindValue(4, ActionDetail);

    query->exec();
}



// BRANCHES

QByteArray DbMan::getBranchesJson()
{
    QJsonArray array = this->getBranches();
    QJsonDocument doc(array);
    return doc.toJson();
}

QJsonObject DbMan::getBranchJson(int id)
{
    QJsonObject branch;

    query->prepare("SELECT  city, branch_name, branch_address FROM main.branches WHERE id=?");
    query->bindValue(0, id);
    if(query->exec())
    {
        if (query->next())
        {
            branch["id"] = id;
            branch["city"] = query->value(0).toString();
            branch["branch_name"] = query->value(1).toString();
            branch["address"] = query->value(2).toString();
            branch["description"] = query->value(3).toString();
        }
    }

    return branch;
}

QJsonArray DbMan::getBranches()
{
    QJsonArray array;

    query->prepare("SELECT id, city, branch_name, branch_address	FROM main.branches ORDER BY id;");
    if(query->exec())
    {
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["city"] = query->value(1).toString();
            obj["branch_name"] = query->value(2).toString();
            obj["branch_address"] = query->value(3).toString();
            array.append(obj);
        }
    }
    return array;
}

QByteArray DbMan::getBranchesJsonById(QList<int> branches)
{
    QJsonArray array;

    QStringList branchList;
    for(int i =0; i < branches.length(); i++)
        branchList.append(QString::number(branches.at(i)));

    QString numberList = branchList.join(",");
    QString queryString = "SELECT id, city, branch_name, branch_address FROM main.branches WHERE id IN("+numberList+") ORDER BY id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["city"] = query->value(1).toString();
            obj["branch_name"] = query->value(2).toString();
            obj["branch_address"] = query->value(3).toString();
            array.append(obj);
        }
    }

    QJsonDocument doc(array);
    return doc.toJson();
}

bool DbMan::updateBranch(QJsonObject branch)
{
    int id = branch.value("id").toInt();
    QString name = branch.value("branch_name").toString();
    QString city = branch.value("city").toString();
    QString address = branch.value("branch_address").toString();

    bool ID, NAME, CITY, ADDRESS;
    ID = (id >= 0)? true : false;
    CITY = (city.isEmpty())? false : true;
    ADDRESS = (address.isEmpty())? false : true;
    NAME = (name.isEmpty())? false : true;

    if(!ID || !CITY || !NAME || !ADDRESS)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("UPDATE main.branches 	SET  city=:city, branch_name=:name, branch_address=:address	WHERE id=:id;");
    query->bindValue(":city", city);
    query->bindValue(":name", name);
    query->bindValue(":address", address);

    query->bindValue(":id", id);

    if(query->exec())
    {
        return true;
    }
    else
    {
        lastError = query->lastError().text();
        return false;
    }


}

bool DbMan::deleteBranch(int id)
{
    query->prepare("DELETE FROM main.branches WHERE id=?;");
    query->bindValue(0, id);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::insertBranch(QJsonObject branchObj)
{
    // city name desc address
    QString city = branchObj.value("city").toString();
    QString name = branchObj.value("branch_name").toString();
    QString address = branchObj.value("branch_address").toString();

    bool CITY, NAME, ADDRESS;
    CITY = (city.isEmpty())? false : true;
    NAME = (name.isEmpty())? false : true;
    ADDRESS = (address.isEmpty())? false : true;

    if(!CITY || !NAME || !ADDRESS)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("INSERT INTO main.branches(city, branch_name, branch_address) VALUES (:city, :branch_name, :address);");
    query->bindValue(":city", city);
    query->bindValue(":branch_name", name);
    query->bindValue(":address", address);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

// STEP


QByteArray DbMan::getStepsByteArray(QList<int> branches)
{
    QJsonArray array;
    QStringList branchList;
    for(int i =0; i < branches.length(); i++)
        branchList.append(QString::number(branches.at(i)));

    QString numberList = branchList.join(",");

    QString queryString = "SELECT s.id, s.branch_id, s.step_name, b.branch_name FROM main.steps s LEFT JOIN main.branches b on (s.branch_id=b.id) WHERE s.branch_id IN("+ numberList +") ORDER BY b.id, s.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["branch_name"] = query->value(3).toString();
            array.append(obj);
        }
    }
    QJsonDocument doc(array);
    return doc.toJson();
}

QJsonArray DbMan::getSteps(QList<int> branches)
{
    QJsonArray array;
    QStringList branchList;
    for(int i =0; i < branches.length(); i++)
        branchList.append(QString::number(branches.at(i)));

    QString numberList = branchList.join(",");

    QString queryString = "SELECT s.id, s.branch_id, s.step_name, b.branch_name FROM main.steps s LEFT JOIN main.branches b on (s.branch_id=b.id) WHERE s.branch_id IN("+ numberList +") ORDER BY b.id, s.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["branch_name"] = query->value(3).toString();
            array.append(obj);
        }
    }

    return array;
}

QJsonArray DbMan::getStepsById(QList<int> steps)
{
    QJsonArray array;
    QStringList stepList;
    for(int i =0; i < steps.length(); i++)
        stepList.append(QString::number(steps.at(i)));

    QString numberList = stepList.join(",");

    QString queryString = "SELECT s.id, s.branch_id, s.step_name, b.city, b.branch_name FROM main.steps s LEFT JOIN main.branches b on (s.branch_id=b.id) WHERE s.id IN("+ numberList +") ORDER BY b.id, s.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["city"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            array.append(obj);
        }
    }

    return array;
}

QJsonArray DbMan::getStepsById(QList<int> branches, QList<int> steps)
{
    QJsonArray array;

    //branches
    QStringList branchList;
    for(int i =0; i < branches.length(); i++)
        branchList.append(QString::number(branches.at(i)));
    QString numberListBranch = branchList.join(",");

    //steps
    QStringList stepList;
    for(int i =0; i < steps.length(); i++)
        stepList.append(QString::number(steps.at(i)));
    QString numberListStep = stepList.join(",");

    QString queryString = "SELECT s.id, s.branch_id, s.step_name, b.branch_name FROM main.steps s LEFT JOIN main.branches b on (s.branch_id=b.id) WHERE s.id IN("+ numberListStep +") AND s.branch_id IN("+ numberListBranch +")  ORDER BY b.id, s.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["branch_name"] = query->value(3).toString();
            array.append(obj);
        }
    }

    return array;
}

QJsonArray DbMan::getBranchStepsJson(int branchId)
{
    QJsonArray array;

    query->prepare("SELECT s.id, s.branch_id, s.step_name, b.city, b.branch_name, b.description FROM main.steps s LEFT JOIN main.branches b ON(b.id=s.branch_id) WHERE s.branch_id=? ORDER BY s.id "); //b.branch_name, s.step_name;
    query->bindValue(0, branchId);
    if(query->exec())
    {
        // s.id, s.branch_id, s.step_name, b.city, b.branch_name, b.description
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["branch_city"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            obj["branch_description"] = query->value(5).toString();

            array.append(obj);
        }
    }

    return array;
}

QByteArray DbMan::getStepsJsonById(QList<int> steps)
{
    QJsonArray array;
    QStringList stepsList;
    for(int i =0; i < steps.length(); i++)
        stepsList.append(QString::number(steps.at(i)));

    QString numberList = stepsList.join(",");

    QString queryString = "SELECT s.id, s.branch_id, s.step_name, b.branch_name FROM main.steps s LEFT JOIN main.branches b on (s.branch_id=b.id) WHERE s.id IN("+ numberList +") ORDER BY b.id, s.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["branch_name"] = query->value(3).toString();
            array.append(obj);
        }
    }
    QJsonDocument doc(array);
    return doc.toJson();
}

bool DbMan::insertStep(QJsonObject step)
{
    int branchId = step.value("branch_id").toInt();
    QString step_name = step.value("step_name").toString();

    bool BID, NAME;
    BID = (branchId >= 0)? true : false;
    NAME = (step_name.isEmpty())? false : true;

    if(!BID || !NAME)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("INSERT INTO main.steps(branch_id, step_name)	VALUES ( :branch_id, :step_name);");
    query->bindValue(":branch_id", branchId);
    query->bindValue(":step_name", step_name);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::deleteStep(int stepId)
{
    query->prepare("DELETE FROM main.steps WHERE id=?;");
    query->bindValue(0, stepId);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::updateStep(QJsonObject step)
{
    //
    QString step_name = step.value("step_name").toString();
    int step_id =  step.value("id").toInt();

    bool SID, NAME;
    SID = (step_id >= 0)? true : false;
    NAME = (step_name.isEmpty())? false : true;

    if(!SID || !NAME)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("UPDATE main.steps	SET  step_name=? WHERE id=?;");
    query->bindValue(0, step_name);
    query->bindValue(1, step_id);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

QJsonObject DbMan::getStepJson(int stepId)
{
    QJsonObject obj;
    query->prepare("SELECT s.id, s.branch_id, s.step_name, b.city, b.branch_name, b.description FROM main.steps s LEFT JOIN main.branches b ON(b.id=s.branch_id) WHERE s.id=? ;");
    query->bindValue(0, stepId);
    if(query->exec())
    {
        // s.id, s.branch_id, s.step_name, b.city, b.branch_name, b.description
        if (query->next())
        {
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["step_name"] = query->value(2).toString();
            obj["branch_city"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            obj["branch_description"] = query->value(5).toString();
        }
    }
    return obj;
}


//BASES


QByteArray DbMan::getStudyBasesByteArray(QList<int> branches)
{
    QJsonArray array;
    QStringList branchesList;
    for(int i =0; i < branches.length(); i++)
        branchesList.append(QString::number(branches.at(i)));

    QString numberList = branchesList.join(",");

    QString queryString = "SELECT b.id, b.branch_id,  b.study_base, br.branch_name FROM main.study_bases b  LEFT JOIN main.branches br on (b.branch_id=br.id) WHERE branch_id IN("+ numberList +")  ORDER BY br.id, b.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["study_base"] = query->value(2).toString();
            obj["branch_name"] = query->value(3).toString();
            array.append(obj);
        }
    }
    QJsonDocument doc(array);
    return doc.toJson();
}

QJsonArray DbMan::getStudyBases(QList<int> branches)
{
    QJsonArray array;
    QStringList branchesList;
    for(int i =0; i < branches.length(); i++)
        branchesList.append(QString::number(branches.at(i)));

    QString numberList = branchesList.join(",");

    QString queryString = "SELECT b.id, b.branch_id,  b.study_base,br.city, br.branch_name FROM main.study_bases b  LEFT JOIN main.branches br on (b.branch_id=br.id) WHERE branch_id IN("+ numberList +")  ORDER BY br.id, b.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["study_base"] = query->value(2).toString();
            obj["city"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            array.append(obj);
        }
    }
    return array;
}

QJsonArray DbMan::getStudyBasesById(QList<int> bases)
{
    QJsonArray array;
    QStringList basesList;
    for(int i =0; i < bases.length(); i++)
        basesList.append(QString::number(bases.at(i)));

    QString numberList = basesList.join(",");

    QString queryString = "SELECT b.id, b.branch_id,  b.study_base,br.city, br.branch_name FROM main.study_bases b  LEFT JOIN main.branches br on (b.branch_id=br.id) WHERE b.id IN("+ numberList +")  ORDER BY br.id, b.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["study_base"] = query->value(2).toString();
            obj["city"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            array.append(obj);
        }
    }
    return array;
}

QJsonArray DbMan::getStudyBasesById(QList<int> branches, QList<int> bases)
{
    QJsonArray array;
    //branches
    QStringList branchList;
    for(int i =0; i < branches.length(); i++)
        branchList.append(QString::number(branches.at(i)));
    QString numberListBranch = branchList.join(",");

    QStringList basesList;
    for(int i =0; i < bases.length(); i++)
        basesList.append(QString::number(bases.at(i)));

    QString numberList = basesList.join(",");

    QString queryString = "SELECT b.id, b.branch_id,  b.study_base,br.city, br.branch_name FROM main.study_bases b  LEFT JOIN main.branches br on (b.branch_id=br.id) WHERE b.id IN("+ numberList +") AND  b.branch_id IN("+ numberListBranch +")  ORDER BY br.id, b.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["branch_id"] = query->value(1).toInt();
            obj["study_base"] = query->value(2).toString();
            obj["city"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            array.append(obj);
        }
    }
    return array;
}

QByteArray DbMan::getBasisJsonById(QList<int> basis)
{
    QJsonArray array;
    QStringList basisList;
    for(int i =0; i < basis.length(); i++)
        basisList.append(QString::number(basis.at(i)));

    QString numberList = basisList.join(",");

    QString queryString = "SELECT b.id, b.step_id, b.basis_name, s.step_name, br.branch_name FROM main.basis b LEFT JOIN main.steps s on (b.step_id=s.id) LEFT JOIN main.branches br on (s.branch_id=br.id) WHERE b.id IN("+ numberList +") ORDER BY br.id, s.id, b.id;";

    query->prepare(queryString);
    if(query->exec())
    {
        QJsonObject obj;
        while(query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["step_id"] = query->value(1).toInt();
            obj["basis_name"] = query->value(2).toString();
            obj["step_name"] = query->value(3).toString();
            obj["branch_name"] = query->value(4).toString();
            array.append(obj);
        }
    }
    QJsonDocument doc(array);
    return doc.toJson();
}

QJsonObject DbMan::getBasisById(int id)
{
    QJsonObject obj;
    query->prepare("SELECT b.id, b.step_id, b.basis_name, s.step_name,  br.city, br.branch_name FROM main.basis b LEFT  JOIN main.steps s on(b.step_id=s.id) LEFT JOIN main.branches br ON(s.branch_id=br.id) WHERE b.id=?");
    query->bindValue(0, id);
    if(query->exec())
    {
        if(query->next())
        {
            obj["id"] = query->value(0).toInt();
            obj["step_id"] = query->value(1).toInt();
            obj["basis_name"] = query->value(2).toString();
            obj["step_name"] = query->value(3).toString();
            obj["branch_city"] = query->value(4).toString();
            obj["branch_name"] = query->value(5).toString();
        }
    }
    return obj;
}

QJsonArray DbMan::getStepBasis(int stepId)
{
    QJsonArray array;

    query->prepare("SELECT b.id, b.step_id, b.basis_name, s.step_name,  br.city, br.branch_name FROM main.basis b LEFT  JOIN main.steps s on(b.step_id=s.id) LEFT JOIN main.branches br ON(s.branch_id=br.id) WHERE b.step_id=? ORDER BY b.id");
    query->bindValue(0, stepId);
    if(query->exec())
    {
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["step_id"] = query->value(1).toInt();
            obj["basis_name"] = query->value(2).toString();
            obj["step_name"] = query->value(3).toString();
            obj["branch_city"] = query->value(4).toString();
            obj["branch_name"] = query->value(5).toString();

            array.append(obj);
        }
    }

    return array;
}

bool DbMan::insertBasis(QJsonObject basis)
{
    int step_id = basis.value("step_id").toInt();
    QString basis_name = basis.value("basis_name").toString();

    bool BID, NAME;
    BID = (step_id >= 0)? true : false;
    NAME = (basis_name.isEmpty())? false : true;

    if(!BID || !NAME)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("INSERT INTO main.basis(step_id, basis_name)	VALUES ( ?,?);");
    query->bindValue(0, step_id);
    query->bindValue(1, basis_name);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::updateBasis(QJsonObject basis)
{
    QString basis_name = basis.value("basis_name").toString();
    int id =  basis.value("id").toInt();

    bool ID, NAME;
    ID = (id >= 0)? true : false;
    NAME = (basis_name.isEmpty())? false : true;

    if(!ID || !NAME)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("UPDATE main.basis	SET  basis_name=? WHERE id=?;");
    query->bindValue(0, basis_name);
    query->bindValue(1, id);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::deleteBasis(int basisId)
{
    query->prepare("DELETE FROM main.basis WHERE id=?;");
    query->bindValue(0, basisId);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

QJsonArray DbMan::getBasisStudyPeriods(int basisId)
{
    QJsonArray array;

    query->prepare("SELECT p.id, p.basis_id, p.period, b.basis_name as basis, s.step_name as step, CONCAT(br.city ,' ', branch_name) as branch FROM main.study_periods p LEFT JOIN main.basis b ON(p.basis_id=b.id) LEFT JOIN main.steps s ON(b.step_id=s.id) LEFT JOIN main.branches br ON(s.branch_id=br.id) WHERE p.basis_id=? ORDER BY id;");
    query->bindValue(0, basisId);
    if(query->exec())
    {
        QJsonObject obj;
        while (query->next())
        {
            obj.empty();
            obj["id"] = query->value(0).toInt();
            obj["basis_id"] = query->value(1).toInt();
            obj["period"] = query->value(2).toString();
            obj["basis"] = query->value(3).toString();
            obj["step"] = query->value(4).toString();
            obj["branch"] = query->value(5).toString();

            array.append(obj);
        }
    }

    return array;
}

QJsonObject DbMan::getStudyPeriod(int periodId)
{
    QJsonObject obj;
    query->prepare("SELECT p.id, p.basis_id, p.period, b.basis_name as basis, s.step_name as step, CONCAT(br.city ,' ', branch_name) as branch FROM main.study_periods p LEFT JOIN main.basis b ON(p.basis_id=b.id) LEFT JOIN main.steps s ON(b.step_id=s.id) LEFT JOIN main.branches br ON(s.branch_id=br.id) WHERE p.id=?;");
    query->bindValue(0, periodId);
    if(query->exec())
    {
        if(query->next())
        {
            obj["id"] = query->value(0).toInt();
            obj["basis_id"] = query->value(1).toInt();
            obj["period"] = query->value(2).toString();
            obj["basis"] = query->value(3).toString();
            obj["step"] = query->value(4).toString();
            obj["branch"] = query->value(5).toString();
        }
    }
    return obj;
}


//STUDY PERIODS


bool DbMan::studyPeriodUpdate(QJsonObject periodObj)
{
    QString period = periodObj.value("period").toString();
    int id =  periodObj.value("id").toInt();

    bool ID, NAME;
    ID = (id >= 0)? true : false;
    NAME = (period.isEmpty())? false : true;

    if(!ID || !NAME)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("UPDATE main.study_periods	SET  period=? WHERE id=?;");
    query->bindValue(0, period);
    query->bindValue(1, id);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::studyPeriodInsert(QJsonObject periodObj)
{
    int basis_id = periodObj.value("basis_id").toInt();
    QString period = periodObj.value("period").toString();

    bool BID, NAME;
    BID = (basis_id >= 0)? true : false;
    NAME = (period.isEmpty())? false : true;

    if(!BID || !NAME)
    {
        lastError = "اطلاعات ورودی کامل نمی‌‌باشد.";
        return false;
    }

    query->prepare("INSERT INTO main.study_periods(basis_id, period)	VALUES ( ?,?);");
    query->bindValue(0, basis_id);
    query->bindValue(1, period);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

bool DbMan::studyPeriodDelete(int periodId)
{
    query->prepare("DELETE FROM main.study_periods WHERE id=?;");
    query->bindValue(0, periodId);

    if(query->exec())
        return true;
    else
    {
        lastError = query->lastError().text();
        return false;
    }
}

