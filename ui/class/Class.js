function updateBranchCB()
{
    branchCBoxModel.clear();
    stepCBoxModel.clear();
    baseCBoxModel.clear();
    periodCBoxModel.clear();

    classModel.clear();

    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchCBoxModel.append({value: obj.id,  text: temp })
    }
}

function updateStepCB(branchId)
{
    stepCBoxModel.clear();
    baseCB.currentIndex = -1
    periodCB.currentIndex = -1

    classModel.clear();

    var jsondata = dbMan.getBranchStepsJson(branchId);
    //s.id, s.branch_id, s.step_name, b.city, b.branch_name
    var temp;
    for(var obj of jsondata)
    {
        stepCBoxModel.append({value: obj.id,  text: obj.step_name })
    }
}

function updateBaseCB(branchId)
{
    baseCBoxModel.clear();
    periodCB.currentIndex = -1

    classModel.clear();

    var jsondata = dbMan.getBranchStudyBases(branchId);
    //sb.id, sb.branch_id, sb.study_base, b.city, b.branch_name
    baseCBoxModel.append({value: 0,  text: " - " });

    var temp;
    for(var obj of jsondata)
    {
        baseCBoxModel.append({value: obj.id,  text: obj.study_base })
    }

}


function updatePeriodCB(branch_id)
{
    periodCBoxModel.clear();
    classModel.clear();
    var jsondata = dbMan.getBranchPeriods(branch_id);
    var temp;
    for(var obj of jsondata)
    {
        //sp.id, sp.branch_id, sp.study_period, sp.passed, b.city, b.branch_name, b.branch_address
        temp = obj.study_period;
        periodCBoxModel.append({value: obj.id,  text: temp })
    }
    periodCB.currentIndex = -1
}

function updateClassModel(step_id, base_id, period_id)
{
    classModel.clear();
    var jsondata = dbMan.getClasses(step_id, base_id, period_id);
    //
    for(var obj of jsondata)
    {
        //c.id, c.step_id, c.study_base_id, c.study_period_id, c.class_name, c.class_desc, c.sort_priority, st.step_name, sb.study_base, sp.study_period
        classModel.append({
                              Id: obj.id,
                              Step_id: obj.study_period_id,
                              Study_base_id: obj.study_base_id,
                              Study_period_id: obj.study_period_id,
                              Class_name: obj.class_name,
                              Class_desc: obj.class_desc,
                              Sort_priority: obj.sort_priority,
                              Step_name: obj.step_name,
                              Study_base: obj.study_base,
                              Study_period: obj.study_period
                          })
    }
}

//class detail

function updateClassDetailModel(class_id)
{
    classDetailModel.clear();
    var jsondata = dbMan.getClassDetails(class_id);
    //
    for(var obj of jsondata)
    {
        // id, cd.class_id, cd.course_id, cd.teacher_id, co.course_name, t.teacher
        classDetailModel.append({
                              Id: obj.id,
                              Class_id: obj.class_id,
                              Course_id: obj.course_id,
                              Teacher_id: obj.teacher_id,
                              Course_name: obj.course_name,
                              Teacher: obj.teacher,
                          })
    }
}

function updateCourseCB()
{

}
