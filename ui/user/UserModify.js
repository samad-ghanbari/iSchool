
function updateBranches() {
    branchModel.clear();
    var jsondata = dbMan.getBranches();
    for(var obj of jsondata)
        branchModel.append(obj);
}

function updateStep() {
    stepModel.clear();
    // should get steps of enabled branch
    var jsondata = dbMan.getSteps(branchPerm);
    for(var obj of jsondata)
        stepModel.append(obj);
}

function updateStudyBase() {
    baseModel.clear();
    var jsondata = dbMan.getStudyBases(branchPerm);
    for(var obj of jsondata)
        baseModel.append(obj);
}

function checkBranch()
{
    stepPerm = dbMan.filterSteps(branchPerm, stepPerm);
    studyBasePerm = dbMan.filterStudyBases(branchPerm, studyBasePerm);

    selectedSteps = dbMan.filterSteps(branchPerm, selectedSteps);
    selectedBases = dbMan.filterStudyBases(branchPerm, selectedBases);


}

// check entries
function checkFormEntries(user)
{

    // name lastname gender nat_id password passwordConfirm job_position telephone enabled admin permissions

    if(!user["name"])
    {
        updateUserNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        updateUserNameId.placeholderTextColor = "red"
        updateUserNameId.focus = true;

        updateUserInfoDialogId.dialogTitle = "خطا"
        updateUserInfoDialogId.dialogText = "ورود نام کاربر الزامی می‌باشد"
        updateUserInfoDialogId.dialogSuccess = false
        return false;
    }
    if(!user["lastname"])
    {
        updateUserLastNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        updateUserLastNameId.placeholderTextColor = "red"
        updateUserLastNameId.focus = true;

        updateUserInfoDialogId.dialogTitle = "خطا"
        updateUserInfoDialogId.dialogText = "ورود نام‌خانوادگی الزامی می‌باشد"
        updateUserInfoDialogId.dialogSuccess = false

        return false;
    }

    if(!user["nat_id"])
    {
        updateUserNatidId.placeholderText="ورود فیلد الزامی می‌باشد"
        updateUserNatidId.placeholderTextColor = "red"
        updateUserNatidId.focus = true;

        updateUserInfoDialogId.dialogTitle = "خطا"
        updateUserInfoDialogId.dialogText = "ورود کد ملی الزامی می‌باشد"
        updateUserInfoDialogId.dialogSuccess = false
        return false;
    }

    if(user["nat_id"].length < 8)
    {
        updateUserNatidId.placeholderText="کد ملی وارد شده معتبر نمی‌باشد."
        updateUserNatidId.placeholderTextColor = "red"
        updateUserNatidId.focus = true;

        updateUserInfoDialogId.dialogTitle = "خطا"
        updateUserInfoDialogId.dialogText = "کد ملی وارد شده معتبر نمی‌باشد."
        updateUserInfoDialogId.dialogSuccess = false

        return false;
    }


    if(!user["job_position"])
    {
        updateUserNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        updateUserNameId.placeholderTextColor = "red"
        updateUserNameId.focus = true;

        updateUserInfoDialogId.dialogTitle = "خطا"
        updateUserInfoDialogId.dialogText = "ورود سمت شغلی الزامی می‌باشد"
        updateUserInfoDialogId.dialogSuccess = false

        return false;
    }



    return true;
}
