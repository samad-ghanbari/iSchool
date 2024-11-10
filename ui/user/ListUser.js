
// LIST USER
var updateUsersModel = function()
{
    userListModel.clear();
    var jsondata = dbMan.getUsers();
    // id, name, lastname, nat_id, job_position, enabled, admin, gender
    var FEMALE;
    for(var obj of jsondata)
    {
        FEMALE = (obj.gender === "خانم")? true : false;
        userListModel.append({ Id: obj.id, Name: obj.name, Lastname: obj.lastname, Nat_id: obj.nat_id, Job_position: obj.job_position, Enabled: obj.enabled, Admin: obj.admin, UserFemale: FEMALE })
    }
}

var filterUsersModel = function(userFilter)
{
    userListModel.clear();
    var jsondata = dbMan.filterUsers(userFilter);
    // id, name, lastname, nat_id, job_position, enabled, admin, gender
    var FEMALE;
    for(var obj of jsondata)
    {
        FEMALE = (obj.gender === "خانم")? true : false;
        userListModel.append({ Id: obj.id, Name: obj.name, Lastname: obj.lastname, Nat_id: obj.nat_id, Job_position: obj.job_position, Enabled: obj.enabled, Admin: obj.admin, UserFemale: FEMALE })
    }
}
