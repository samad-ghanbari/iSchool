function stepsUpdate(BranchId)
{
    stepsModel.clear();
    var jsondata = dbMan.getBranchStepsJson(BranchId);
    //jsondata = JSON.parse(jsondata);
    //s.id, s.branch_id, s.step_name, b.city, b.branch_name
    for(var obj of jsondata)
    {
        stepsModel.append({Id: obj.id, BranchId: obj.branch_id, StepName: obj.step_name, BranchCity: obj.branch_city, BranchName: obj.branch_name})
    }
}

function updateBranchCB()
{
    branchCBoxModel.clear();
    var jsondata = dbMan.getBranches();
    //jsondata = JSON.parse(jsondata);
    //id, city, branch_name, address
    for(var obj of jsondata)
    {
        branchCBoxModel.append({value: obj.id,  text: obj.city + " - " + obj.branch_name })
    }
}

function checkStepEntries(Step)
{
    if(Step["branch_id"] < 0)
    {
        stepInfoDialogId.dialogTitle = "خطا"
        stepInfoDialogId.dialogText = "انتخاب شعبه الزامی می‌باشد."
        stepInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Step["step_name"])
    {
        stepNameTF.placeholderText="ورود فیلد الزامی می‌باشد"
        stepNameTF.placeholderTextColor = "red"
        stepNameTF.focus = true;

        stepInfoDialogId.dialogTitle = "خطا"
        stepInfoDialogId.dialogText = "ورود نام دوره الزامی می‌باشد"
        stepInfoDialogId.dialogSuccess = false
        return false;
    }

    return true;
}

function checkStepUpdateEntries(Step)
{
    if(Step["id"] < 0)
    {
        stepInfoDialogId.dialogTitle = "خطا"
        stepInfoDialogId.dialogText = "انتخاب دوره به درستی صورت نگرفته است."
        stepInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Step["step_name"])
    {
        stepNameTF.placeholderText="ورود فیلد الزامی می‌باشد"
        stepNameTF.placeholderTextColor = "red"
        stepNameTF.focus = true;

        stepInfoDialogId.dialogTitle = "خطا"
        stepInfoDialogId.dialogText = "ورود نام دوره الزامی می‌باشد"
        stepInfoDialogId.dialogSuccess = false
        return false;
    }

    return true;
}


function updateWidget(stepObj)
{
    stepDelegate.stepName = stepObj["step_name"];
}
