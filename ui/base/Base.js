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


function basesUpdate(stepId)
{
    baseModel.clear();
    var jsondata = dbMan.getStepBases(stepId, true);
    // b.id, b.step_id, b.field_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name
    var temp;
    for(var obj of jsondata)
    {
        baseModel.append(obj)
    }
}


function checkBaseInsertEntries(Base)
{
    if(Base["step_id"]  < 0)
    {
        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "انتخاب دوره به درستی صورت نگرفته است."
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Base["base_name"])
    {
        baseTF.placeholderText="ورود فیلد الزامی می‌باشد"
        baseTF.placeholderTextColor = "red"
        baseTF.focus = true;

        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "ورود نام پایه الزامی می‌باشد"
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    if(Base["field_based"]){
        if(Base["field_id"]  < 0)
        {
            baseInfoDialogId.dialogTitle = "خطا"
            baseInfoDialogId.dialogText = "انتخاب رشته به درستی صورت نگرفته است."
            baseInfoDialogId.dialogSuccess = false
            return false;
        }
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


    if(!Base["base_name"])
    {
        baseTF.placeholderText="ورود فیلد الزامی می‌باشد"
        baseTF.placeholderTextColor = "red"
        baseTF.focus = true;

        baseInfoDialogId.dialogTitle = "خطا"
        baseInfoDialogId.dialogText = "ورود نام پایه الزامی می‌باشد"
        baseInfoDialogId.dialogSuccess = false
        return false;
    }

    if(Base["field_based"]){
        if(Base["field_id"]  < 0)
        {
            baseInfoDialogId.dialogTitle = "خطا"
            baseInfoDialogId.dialogText = "انتخاب رشته به درستی صورت نگرفته است."
            baseInfoDialogId.dialogSuccess = false
            return false;
        }
    }

    return true;
}

function baseUpdate(BaseObj)
{
    baseDelegate.base_model = BaseObj;
}
