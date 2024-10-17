
// //access
function updateAccessBranch(init = true) {
    var jsondata = dbMan.getBranchesJson();
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessBranchModel.append({ id: obj.id, city: obj.city, branch_name: obj.branch_name, address: obj.address, description: obj.description})

    if(!init)
    {
        //update
        updateAccessStep();
        updatePermissionBranch();
    }
}

function updateAccessStep(init = true) {

    // should get steps of enabled branch
    var jsondata = dbMan.getStepsJson(accessBranch);
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessStepModel.append({ id: obj.id, branch_id: obj.branch_id, step_name: obj.step_name, branch_name: obj.branch_name})

    if(!init)
    {
        //update
        updateAccessBasis();
        updatePermissionStep();
    }
}

function updateAccessBasis(init = true) {

    var jsondata = dbMan.getBasisJson(accessStep);
    jsondata = JSON.parse(jsondata);
    for(var obj of jsondata)
        accessBasisModel.append({ id: obj.id, step_id: obj.step_id, basis_name: obj.basis_name, step_name: obj.step_name, branch_name: obj.branch_name })

    if(!init)
    {
        updatePermissionBasis();
    }
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
        userNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        userNameId.placeholderTextColor = "red"
        userNameId.focus = true;

        userInfoDialogId.dialogTitle = "خطا"
        userInfoDialogId.dialogText = "ورود نام کاربر الزامی می‌باشد"
        userInfoDialogId.dialogSuccess = false
        return false;
    }
    if(!user["lastname"])
    {
        userLastNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        userLastNameId.placeholderTextColor = "red"
        userLastNameId.focus = true;

        userInfoDialogId.dialogTitle = "خطا"
        userInfoDialogId.dialogText = "ورود نام‌خانوادگی الزامی می‌باشد"
        userInfoDialogId.dialogSuccess = false

        return false;
    }

    if(!user["nat_id"])
    {
        userNatidId.placeholderText="ورود فیلد الزامی می‌باشد"
        userNatidId.placeholderTextColor = "red"
        userNatidId.focus = true;

        userInfoDialogId.dialogTitle = "خطا"
        userInfoDialogId.dialogText = "ورود کد ملی الزامی می‌باشد"
        userInfoDialogId.dialogSuccess = false
        return false;
    }


    if(!user["job_position"])
    {
        userNameId.placeholderText="ورود فیلد الزامی می‌باشد"
        userNameId.placeholderTextColor = "red"
        userNameId.focus = true;

        userInfoDialogId.dialogTitle = "خطا"
        userInfoDialogId.dialogText = "ورود سمت شغلی الزامی می‌باشد"
        userInfoDialogId.dialogSuccess = false

        return false;
    }

    if(user["email"])
    {
        if(!user["email"].includes("@"))
        {
            userNameId.placeholderText="پست الکترونیکی نامعتبر است"
            userNameId.placeholderTextColor = "red"
            userNameId.focus = true;

            userInfoDialogId.dialogTitle = "خطا"
            userInfoDialogId.dialogText = "پست الکترونیکی نامعتبر است"
            userInfoDialogId.dialogSuccess = false

            return false;

        }

        if(!user["email"].includes("."))
        {
            userNameId.placeholderText="پست الکترونیکی نامعتبر است"
            userNameId.placeholderTextColor = "red"
            userNameId.focus = true;

            userInfoDialogId.dialogTitle = "خطا"
            userInfoDialogId.dialogText = "پست الکترونیکی نامعتبر است"
            userInfoDialogId.dialogSuccess = false

            return false;
        }
        return true;
    }
    return true;
}


