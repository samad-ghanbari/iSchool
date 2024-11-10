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

function periodsUpdate(branchId)
{
    periodsModel.clear();
    var jsondata = dbMan.getBranchPeriods(branchId);
    //sp.id, sp.branch_id, sp.study_period, sp.passed, b.city, b.branch_name, b.branch_address
    for(var obj of jsondata)
    {
        periodsModel.append({Id: obj.id, BranchId: obj.branch_id, StudyPeriod: obj.study_period, Passed: obj.passed, City: obj.city, BranchName: obj.branch_name  })
    }
}


function checkPeriodInsertEntries(Period)
{
    if(Period["branch_id"]  < 0)
    {
        periodInfoDialogId.dialogTitle = "خطا"
        periodInfoDialogId.dialogText = "انتخاب شعبه به درستی صورت نگرفته است."
        periodInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Period["study_period"])
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

    if(!Period["study_period"])
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
    periodDelegate.studyPeriod = PeriodObj["study_period"];
    periodDelegate.passed = PeriodObj["passed"];
}
