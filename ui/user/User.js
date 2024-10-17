
function updateAccessPermission()
{
    accessBranchModel();
    accessStepModel();
    accessBasisModel();

    permissionBranchModel();
    permissionStepModel();
    permissionBasisModel();
}

//a access
function accessBranchModel()
{
    userBranchListModel.clear();
    var Array = user["access"].branch;
    var jsondata = dbMan.getBranchesJsonById(Array);
    jsondata = JSON.parse(jsondata);
    //id, city, branch_name, address, description
    var temp;
    for(var obj of jsondata)
    {
        temp = {id: obj.id, city: obj.city, branch_name: obj.branch_name, address: obj.address, description: obj.description};
        userBranchListModel.append(temp);
    }
}

function accessStepModel()
{
    userStepListModel.clear();
    var Array = user["access"]["step"];
    var jsondata = dbMan.getStepsJsonById(Array);
    jsondata = JSON.parse(jsondata);
    //id, branch_id, step_name, branch_name
    for(var obj of jsondata)
    {
        userStepListModel.append({id: obj.id, branch_id: obj.branch_id, step_name:obj.step_name, branch_name: obj.branch_name});
    }
}

function accessBasisModel()
{
    userBasisListModel.clear();
    var Array = user["access"]["basis"];
    var jsondata = dbMan.getBasisJsonById(Array);
    jsondata = JSON.parse(jsondata);
    //id, step_id, basis_name, step_name, branch_name
    for(var obj of jsondata)
    {
        userBasisListModel.append({id: obj.id, step_id: obj.step_id, basis_name: obj.basis_name, step_name: obj.step_name, branch_name:obj.branch_name});
    }
}

//write Permission

function permissionBranchModel()
{
    userPermBranchListModel.clear();
    var Array = user["write_permission"]["branch"];
    var jsondata = dbMan.getBranchesJsonById(Array);
    jsondata = JSON.parse(jsondata);
    //id, city, branch_name, address, description
    for(var obj of jsondata)
    {
        userPermBranchListModel.append({id: obj.id, city: obj.city, branch_name: obj.branch_name, address: obj.address, description: obj.description});
    }
}

function permissionStepModel()
{
    userPermStepListModel.clear();
    var Array = user["write_permission"]["step"];
    var jsondata = dbMan.getStepsJsonById(Array);
    jsondata = JSON.parse(jsondata);
    //  id, branch_id, step_name, branch_name
    for(var obj of jsondata)
    {
        userPermStepListModel.append({id: obj.id, branch_id: obj.branch_id, step_name:obj.step_name, branch_name: obj.branch_name});
    }

}

function permissionBasisModel()
{
    userPermBasisListModel.clear();
    var Array = user["write_permission"]["basis"];
    var jsondata = dbMan.getBasisJsonById(Array);
    jsondata = JSON.parse(jsondata);
    //  id, step_id, basis_name, step_name, branch_name
    for(var obj of jsondata)
    {
        userPermBasisListModel.append({id: obj.id, step_id: obj.step_id, basis_name: obj.basis_name, step_name: obj.step_name, branch_name:obj.branch_name});
    }

}
