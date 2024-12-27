function updateBranchModel()
{
    branchModel.clear();
    var branches = userPage.user["permissions"]["branch"];
    var jsondata = dbMan.getBranchesById(branches);
    for(var obj of jsondata)
    {
        branchModel.append(obj); //id, city, branch_name, branch_address
    }
}

function updateStepModel()
{
    stepModel.clear();
    var steps = user["permissions"]["step"];
    var jsondata = dbMan.getStepsById(steps);
    for(var obj of jsondata)
    {
        stepModel.append({Id: obj.id, Step_name: obj.step_name, City: obj.city,  Branch_name: obj.branch_name });
    }

}
function updateStudyBaseModel()
{
    studyBaseModel.clear();
    var array = user["permissions"]["study_base"];
    var jsondata = dbMan.getStudyBasesById(array);
    for(var obj of jsondata)
    {
        studyBaseModel.append({Id: obj.id, City: obj.city, Branch_name: obj.branch_name, Study_base: obj.study_base });
    }
}
