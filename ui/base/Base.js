function branchCBUpdate()
{
    branchCBoxModel.clear();
    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchCBoxModel.append({ value: obj.id, text: temp })
    }
}

function studyBasesUpdate(branchId)
{
    baseModel.clear();
    var jsondata = dbMan.getBranchStudyBases(branchId);
    // sb.id, sb.branch_id, sb.study_base, b.city, b.branch_name
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - " + obj.branch_name;
        baseModel.append({ Id: obj.id, BranchId: obj.branch_id, StudyBase: obj.study_base, Branch: temp })
    }
}


function checkBaseInsertEntries(Base)
{
    if(Base["branch_id"]  < 0)
    {
        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "انتخاب شعبه به درستی صورت نگرفته است."
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Base["study_base"])
    {
        baseTF.placeholderText="ورود فیلد الزامی می‌باشد"
        baseTF.placeholderTextColor = "red"
        baseTF.focus = true;

        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "ورود نام پایه الزامی می‌باشد"
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    return true;
}

function checkBaseUpdateEntries(Base)
{
    if(Base["id"]  < 0)
    {
        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "انتخاب پایه تحصیلی به درستی صورت نگرفته است."
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Base["study_base"])
    {
        baseTF.placeholderText="ورود فیلد الزامی می‌باشد"
        BaseTF.placeholderTextColor = "red"
        BaseTF.focus = true;

        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "ورود نام پایه الزامی می‌باشد"
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    return true;
}

function baseUpdate(BaseObj)
{
    baseDelegate.studyBase = BaseObj["study_base"];
}
