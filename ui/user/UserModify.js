
function updateBranches() {
    branchesModel.clear();
    var jsondata = dbMan.getBranches();
    for(var obj of jsondata)
        branchesModel.append({ Id: obj.id, City: obj.city, Branch_name: obj.branch_name, Branch_address: obj.branch_address});
}

//read studyStep
function updateReadStep() {
    readStepModel.clear();
    writeStepModel.clear();
    // should get steps of enabled branch
    var jsondata = dbMan.getSteps(selectedBranches);
    for(var obj of jsondata)
        readStepModel.append({ Id: obj.id, Branch_id: obj.branch_id, Step_name: obj.step_name, Branch_name: obj.branch_name});

    updateWriteStepModel();
}

//read study base
function updateReadStudyBase() {
    readBaseModel.clear();
    writeBaseModel.clear();
    var jsondata = dbMan.getStudyBases(selectedBranches);
    for(var obj of jsondata)
        readBaseModel.append({ Id: obj.id, Branch_id: obj.branch_id, Study_base: obj.study_base, City: obj.city, Branch_name: obj.branch_name });

    updateWriteBaseModel();
}

//write
function updateWriteStepModel()
{
    writeStepModel.clear();
    // should get steps of enabled branch
    var jsondata = dbMan.getStepsById(selectedBranches, selectedSteps);
    for(var obj of jsondata)
        writeStepModel.append({ Id: obj.id, Branch_id: obj.branch_id, Step_name: obj.step_name, Branch_name: obj.branch_name});

}

function updateWriteBaseModel()
{
    writeBaseModel.clear();
    var jsondata = dbMan.getStudyBasesById(selectedBranches, selectedBases);
    for(var obj of jsondata)
        writeBaseModel.append({ Id: obj.id, Branch_id: obj.branch_id, Study_base: obj.study_base, City: obj.city, Branch_name: obj.branch_name });
}

function checkBranch()
{
    readStep = dbMan.filterSteps(selectedBranches, readStep);
    readStudyBase = dbMan.filterStudyBases(selectedBranches, readStudyBase);

    selectedSteps = dbMan.filterSteps(selectedBranches, selectedSteps);
    selectedBases = dbMan.filterStudyBases(selectedBranches, selectedBases);

    writeStep = dbMan.filterSteps(selectedBranches, writeStep);
    writeStudyBase = dbMan.filterStudyBases(selectedBranches, writeStudyBase);


}

function checkStep()
{
    var index;
    for(var i of writeStep)
    {
        if(! readStep.includes(i))
        {
            index = writeStep.indexOf(i);
            if(index > -1)
                writeStep.splice(index, 1);
        }
    }
}

function checkBase()
{
    var index;
    for(var i of writeStudyBase)
    {
        if(! readStudyBase.includes(i))
        {
            index = writeStudyBase.indexOf(i);
            if(index > -1)
                writeStudyBase.splice(index, 1);
        }
    }
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
