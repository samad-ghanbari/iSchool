
function updateBranches() {
    branchModel.clear();
    var jsondata = dbMan.getBranches();
    for(var obj of jsondata)
        branchModel.append(obj);
}

function updateStep() {
    stepModel.clear();
    // should get steps of enabled branch
    var jsondata = dbMan.getSteps(selectedBranches);
    for(var obj of jsondata)
        stepModel.append(obj);
}

function updateStudyBase() {
    baseModel.clear();
    var jsondata = dbMan.getStudyBases(selectedBranches);
    for(var obj of jsondata)
        baseModel.append(obj);
}

function checkBranch()
{
    stepPerm = dbMan.filterSteps(selectedBranches, stepPerm);
    studyBasePerm = dbMan.filterStudyBases(selectedBranches, studyBasePerm);

    selectedSteps = dbMan.filterSteps(selectedBranches, selectedSteps);
    selectedBases = dbMan.filterStudyBases(selectedBranches, selectedBases);
}

// check entries
function checkFormEntries(user)
{

    // name lastname gender nat_id password passwordConfirm job_position telephone enabled admin permissions

    if(!user["name"])
    {
        newUserNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        newUserNameId.placeholderTextColor = "red"
        newUserNameId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "ورود نام کاربر الزامی می‌باشد"
        newUserInfoDialogId.dialogSuccess = false
        return false;
    }
    if(!user["lastname"])
    {
        newUserLastNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        newUserLastNameId.placeholderTextColor = "red"
        newUserLastNameId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "ورود نام‌خانوادگی الزامی می‌باشد"
        newUserInfoDialogId.dialogSuccess = false

        return false;
    }

    if(!user["nat_id"])
    {
        newUserNatidId.placeholderText="ورود فیلد الزامی می‌باشد"
        newUserNatidId.placeholderTextColor = "red"
        newUserNatidId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "ورود کد ملی الزامی می‌باشد"
        newUserInfoDialogId.dialogSuccess = false
        return false;
    }

    if(user["nat_id"].length < 8)
    {
        newUserNatidId.placeholderText="کد ملی وارد شده معتبر نمی‌باشد."
        newUserNatidId.placeholderTextColor = "red"
        newUserNatidId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "کد ملی وارد شده معتبر نمی‌باشد."
        newUserInfoDialogId.dialogSuccess = false

        return false;
    }

    if(!user["password"])
    {
        newUserPassId.placeholderText="ورود فیلد الزامی می‌باشد"
        newUserPassId.placeholderTextColor = "red"
        newUserPassId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "ورود رمز عبور الزامی می‌باشد"
        newUserInfoDialogId.dialogSuccess = false

        return false;
    }



    if(user["password"] !== user["passwordConfirm"])
    {
        newUserPassConfirmId.text = "";
        newUserPassConfirmId.placeholderText="تایید پسورد تطابق ندارد"
        newUserPassConfirmId.placeholderTextColor = "red"
        newUserPassConfirmId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "تایید پسورد را مجدد وارد نمایید"
        newUserInfoDialogId.dialogSuccess = false

        return false;
    }


    if(!user["job_position"])
    {
        newUserNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        newUserNameId.placeholderTextColor = "red"
        newUserNameId.focus = true;

        newUserInfoDialogId.dialogTitle = "خطا"
        newUserInfoDialogId.dialogText = "ورود سمت شغلی الزامی می‌باشد"
        newUserInfoDialogId.dialogSuccess = false

        return false;
    }



    return true;
}
