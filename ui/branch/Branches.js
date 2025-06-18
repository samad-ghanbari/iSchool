function updateBranches()
{
    branchesModel.clear();
    var jsondata = dbMan.getBranches();
    for(var obj of jsondata)
    {
        //id, city, branch_name, branch_address
        branchesModel.append(obj);
    }
}

function checkBranchEntries(Branch)
{
    if(!Branch["branch_name"])
    {
        branchNameTF.placeholderText="ورود فیلد الزامی می‌باشد"
        branchNameTF.placeholderTextColor = "red"
        branchNameTF.focus = true;

        branchInfoDialogId.dialogTitle = "خطا"
        branchInfoDialogId.dialogText = "ورود نام شعبه الزامی می‌باشد"
        branchInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Branch["city"])
    {
        branchCityTF.placeholderText="ورود فیلد الزامی می‌باشد"
        branchCityTF.placeholderTextColor = "red"
        branchCityTF.focus = true;

        branchInfoDialogId.dialogTitle = "خطا"
        branchInfoDialogId.dialogText = "ورود نام شهر الزامی می‌باشد"
        branchInfoDialogId.dialogSuccess = false
        return false;
    }

    if(!Branch["branch_address"])
    {
        branchAddressTF.placeholderText="ورود فیلد الزامی می‌باشد"
        branchAddressTF.placeholderTextColor = "red"
        branchAddressTF.focus = true;

        branchInfoDialogId.dialogTitle = "خطا"
        branchInfoDialogId.dialogText = "ورود آدرس الزامی می‌باشد"
        branchInfoDialogId.dialogSuccess = false
        return false;
    }

    return true;
}


function updateWidget(branchObj)
{
    branchDelegate.branchCity = branchObj["city"];
    branchDelegate.branchName = branchObj["branch_name"];
    branchDelegate.branchAddress = branchObj["branch_address"];

}
