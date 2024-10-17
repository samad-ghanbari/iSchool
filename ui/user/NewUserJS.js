
// //access
function updateAccessBranch() {
    var jsondata = dbMan.getBranchesJson();
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessBranchModel.append({ id: obj.id, city: obj.city, branch_name: obj.branch_name, address: obj.address, description: obj.description})


    //update
    updateAccessStep();
    updatePermissionBranch();

}

function updateAccessStep() {

    // should get steps of enabled branch
    var jsondata = dbMan.getStepsJson(accessBranch);
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessStepModel.append({ id: obj.id, branch_id: obj.branch_id, step_name: obj.step_name, branch_name: obj.branch_name})


    //update
    updateAccessBasis();
    updatePermissionStep();
}

function updateAccessBasis() {

    var jsondata = dbMan.getBasisJson(accessStep);
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessBasisModel.append({ id: obj.id, step_id: obj.step_id, basis_name: obj.basis_name, step_name: obj.step_name, branch_name: obj.branch_name })

    updatePermissionBasis();
}

function updateAccessAppModule() {
    accessappModuleModel.clear();
    // should get steps of enabled branch
    var jsondata = dbMan.getAppModulesJson();
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessappModuleModel.append({ id: obj.id, module_name: obj.module_name, description: obj.description})
}


//Permissions

function updatePermissionBranch()
{
    permissionBranchModel.clear();
    var jsondata = dbMan.getBranchesJsonById(accessBranch);
    jsondata = JSON.parse(jsondata);

    for(var obj of jsondata)
        permissionBranchModel.append({ id: obj.id, city: obj.city, branch_name: obj.branch_name, address: obj.address, description: obj.description});
}

function updatePermissionStep()
{
    permissionStepModel.clear();
    var jsondata = dbMan.getStepsJsonById(accessStep);
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        permissionStepModel.append({ id: obj.id, branch_id: obj.branch_id, step_name: obj.step_name, branch_name: obj.branch_name})
}

function updatePermissionBasis()
{
    permissionBasisModel.clear();
    var jsondata = dbMan.getBasisJsonById(accessBasis);
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        permissionBasisModel.append({ id: obj.id, step_id: obj.step_id, basis_name: obj.basis_name, step_name: obj.step_name, branch_name: obj.branch_name })
}


// check entries
function checkFormEntries(user)
{

    // name lastname natid password email position telephone enabled admin accessBranch accessStep accessBasis permissionBranch permissionStep permissionBasis

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

    if(user["email"])
    {
        if(!user["email"].includes("@"))
        {
            newUserNameId.placeholderText="پست الکترونیکی نامعتبر است"
            newUserNameId.placeholderTextColor = "red"
            newUserNameId.focus = true;

            newUserInfoDialogId.dialogTitle = "خطا"
            newUserInfoDialogId.dialogText = "پست الکترونیکی نامعتبر است"
            newUserInfoDialogId.dialogSuccess = false

            return false;

        }

        if(!user["email"].includes("."))
        {
            newUserNameId.placeholderText="پست الکترونیکی نامعتبر است"
            newUserNameId.placeholderTextColor = "red"
            newUserNameId.focus = true;

            newUserInfoDialogId.dialogTitle = "خطا"
            newUserInfoDialogId.dialogText = "پست الکترونیکی نامعتبر است"
            newUserInfoDialogId.dialogSuccess = false

            return false;
        }



        return true;
    }

    return true;
}
