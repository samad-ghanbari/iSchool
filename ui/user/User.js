function updateReadStepModel()
{
    readStepModel.clear();
    var steps = user["permissions"]["read"]["step"];
    var jsondata = dbMan.getStepsById(steps);
    for(var obj of jsondata)
    {
        readStepModel.append({Id: obj.id, Step_name: obj.step_name, City: obj.city,  Branch_name: obj.branch_name });
    }

}
function updateReadStudyBaseModel()
{
    readStudyBaseModel.clear();
    var array = user["permissions"]["read"]["study_base"];
    var jsondata = dbMan.getStudyBasesById(array);
    for(var obj of jsondata)
    {
        readStudyBaseModel.append({Id: obj.id, City: obj.city, Branch_name: obj.branch_name, Study_base: obj.study_base });
    }

}


//write
function updateWriteStepModel()
{
    writeStepModel.clear();
    var steps = user["permissions"]["write"]["step"];
    var jsondata = dbMan.getStepsById(steps);
    for(var obj of jsondata)
    {
        writeStepModel.append({Id: obj.id, Step_name: obj.step_name, City: obj.city,  Branch_name: obj.branch_name });
    }

}
function updateWriteStudyBaseModel()
{
    writeStudyBaseModel.clear();
    var array = user["permissions"]["write"]["study_base"];
    var jsondata = dbMan.getStudyBasesById(array);
    for(var obj of jsondata)
    {
        writeStudyBaseModel.append({Id: obj.id, City: obj.city, Branch_name: obj.branch_name, Study_base: obj.study_base });
    }

}
8
