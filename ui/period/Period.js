function updateBranchCB()
{
    branchCBoxModel.clear();
    periodsModel.clear();
    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address, description
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchCBoxModel.append({value: obj.id,  text: temp })
    }
}

function periodsUpdate(step_id)
{
    periodsModel.clear();
    var jsondata = dbMan.getStepPeriods(step_id, true);
    // p.id, p.step_id, p.period_name, p.passed, s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
    for(var obj of jsondata)
    {
        periodsModel.append(obj)
    }
}


function checkPeriodInsertEntries(Period)
{
    if(Period["step_id"]  < 0)
    {
        periodInfoDialogId.dialogTitle = "خطا"
        periodInfoDialogId.dialogText = "انتخاب شعبه به درستی صورت نگرفته است."
        periodInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Period["period_name"])
    {
        periodNameTF.placeholderText="ورود فیلد الزامی می‌باشد"
        periodNameTF.placeholderTextColor = "red"
        periodNameTF.focus = true;

        periodInfoDialogId.dialogTitle = "خطا"
        periodInfoDialogId.dialogText = "ورود سال تحصیلی الزامی می‌باشد"
        periodInfoDialogId.dialogSuccess = false
        return false;
    }

    return true;
}

function checkPeriodUpdateEntries(Period)
{
    if(Period["id"]  < 0)
    {
        periodInfoDialogId.dialogTitle = "خطا"
        periodInfoDialogId.dialogText = "انتخاب سال تحصیلی به درستی صورت نگرفته است."
        periodInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Period["period_name"])
    {
        periodTF.placeholderText="ورود فیلد الزامی می‌باشد"
        periodTF.placeholderTextColor = "red"
        periodTF.focus = true;

        periodInfoDialogId.dialogTitle = "خطا"
        periodInfoDialogId.dialogText = "ورود سال تحصیلی الزامی می‌باشد"
        periodInfoDialogId.dialogSuccess = false
        return false;
    }


    return true;
}

function updateWidget(PeriodObj)
{
    periodDelegate.periodModel = PeriodObj
}
