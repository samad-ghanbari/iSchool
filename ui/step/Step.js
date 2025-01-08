function stepsUpdate(BranchId)
{
    stepsModel.clear();
    var jsondata = dbMan.getBranchSteps(BranchId);
    //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
    for(var obj of jsondata)
    {
        stepsModel.append(obj)
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
    stepDelegate.numeric_graded = stepObj["numeric_graded"];
    stepDelegate.field_based = stepObj["field_based"];
}
