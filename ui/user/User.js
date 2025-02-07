
function updateBranches() {
    branchModel.clear();
    var jsondata = dbMan.getBranches();
    for(var obj of jsondata)
        branchModel.append(obj); // id, city, branch_name, branch_address
}

function updateStep() {
    stepModel.clear();
    // should get steps of enabled branch
    var jsondata = dbMan.getSteps(selectedBranches);
    for(var obj of jsondata)
        stepModel.append(obj);//s.id, s.branch_id, s.step_name, b.city, b.branch_name, s.field_based, s.numeric_graded
}

function updateBases() {
    baseModel.clear();
    var jsondata = dbMan.getBases(selectedSteps);
    var id, text;
    //b.id, b.step_id, br.city, br.branch_name, s.step_name, s.field_based, b.field_id, f.field_name, b.base_name
    for(var obj of jsondata){
        id = obj["id"];
        text = obj["city"] + " - " + obj["branch_name"] + " - " + obj["step_name"];
        if(obj["field_based"])
        {
            text = text + " - " + obj["field_name"];
        }

        text = text + " - " + obj["base_name"];
        baseModel.append({id: id, text: text});
    }
}



// check entries
function checkFormEntries(user, isInsert=true)
{

    // name lastname gender nat_id password confirm job_position telephone enabled admin permissions

    if(!user["name"])
    {
        nameTF.placeholderText="ورود فیلد الزامی می‌باشد"
        nameTF.placeholderTextColor = "red"
        nameTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "ورود نام کاربر الزامی می‌باشد"
        infoDialogId.dialogSuccess = false
        return false;
    }
    if(!user["lastname"])
    {
        lastnameTF.placeholderText="ورود فیلد الزامی می‌باشد"
        lastnameTF.placeholderTextColor = "red"
        lastnameTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "ورود نام‌خانوادگی الزامی می‌باشد"
        infoDialogId.dialogSuccess = false

        return false;
    }

    if(!user["nat_id"])
    {
        natIdTF.placeholderText="ورود فیلد الزامی می‌باشد"
        natIdTF.placeholderTextColor = "red"
        natIdTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "ورود کد ملی الزامی می‌باشد"
        infoDialogId.dialogSuccess = false
        return false;
    }

    if(user["nat_id"].length < 8)
    {
        natIdTF.placeholderText="کد ملی وارد شده معتبر نمی‌باشد."
        natIdTF.placeholderTextColor = "red"
        natIdTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "کد ملی وارد شده معتبر نمی‌باشد."
        infoDialogId.dialogSuccess = false

        return false;
    }

    if(isInsert)
    {
        if(!user["password"])
        {
        passwordTF.placeholderText="ورود فیلد الزامی می‌باشد"
        passwordTF.placeholderTextColor = "red"
        passwordTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "ورود رمز عبور الزامی می‌باشد"
        infoDialogId.dialogSuccess = false

        return false;
        }
    }



    if(isInsert)
    {
        if(user["password"] !== user["confirm"])
        {
        confirmTF.text = "";
        confirmTF.placeholderText="تایید پسورد تطابق ندارد"
        confirmTF.placeholderTextColor = "red"
        confirmTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "تایید پسورد را مجدد وارد نمایید"
        infoDialogId.dialogSuccess = false

        return false;
        }
    }


    if(!user["job_position"])
    {
        jobPositionTF.placeholderText="ورود فیلد الزامی می‌باشد"
        jobPositionTF.placeholderTextColor = "red"
        jobPositionTF.focus = true;

        infoDialogId.dialogTitle = "خطا"
        infoDialogId.dialogText = "ورود سمت شغلی الزامی می‌باشد"
        infoDialogId.dialogSuccess = false

        return false;
    }



    return true;
}
