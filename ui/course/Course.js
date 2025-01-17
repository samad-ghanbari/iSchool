function updateBranchCB()
{
    branchModel.clear();
    stepModel.clear();
    fieldModel.clear();
    baseModel.clear();
    periodModel.clear();
    coursesModel.clear();

    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchModel.append({value: obj.id,  text: temp })
    }
}

function updateStepCB(branchId)
{
    stepModel.clear();
    fieldModel.clear();
    baseModel.clear();
    periodModel.clear();
    coursesModel.clear();

    var jsondata = dbMan.getBranchSteps(branchId);
    //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
    var temp;
    for(var obj of jsondata)
    {
        stepModel.append({value: obj.id,  text: obj.step_name, field_based: obj.field_based })
    }
}

function updateFieldCB(stepId)
{
    fieldModel.clear();
    baseModel.clear();
    periodModel.clear();
    coursesModel.clear();

    var jsondata = dbMan.getFields(stepId);
    //id, step_id, field_name, enabled, sort_priority
    var temp;
    for(var obj of jsondata)
    {
        fieldModel.append({value: obj.id,  text: obj.field_name})
    }

}

function updateFieldBaseCB(fieldId)
{
    baseModel.clear();
    periodModel.clear();
    coursesModel.clear();

    var jsondata = dbMan.getFieldBases(fieldId, false);
    //b.id, b.step_id, b.field_id, s.branch_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name, br.branch_name, br.city, b.sort_priority
    baseModel.append({value: 0,  text: " - " });

    var temp;
    for(var obj of jsondata)
    {
        baseModel.append({value: obj.id,  text: obj.base_name })
    }
}

function updateBaseCB(stepId)
{
    baseModel.clear();
    periodCB.clear();
    coursesModel.clear();

    var jsondata = dbMan.getStepBases(stepId, false);
    //b.id, b.step_id, b.field_id, s.branch_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name, br.branch_name, br.city, b.sort_priority
    baseModel.append({value: 0,  text: " - " });

    var temp;
    for(var obj of jsondata)
    {
        baseModel.append({value: obj.id,  text: obj.base_name })
    }

}

function updatePeriodCB(stepId)
{
    periodModel.clear();
    coursesModel.clear();

    var jsondata = dbMan.getStepPeriods(stepId, false);
    //p.id, p.step_id, p.period_name, p.passed,s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
    var temp;
    for(var obj of jsondata)
    {
        if(!obj.passed)
            periodModel.append({value: obj.period_id,  text: obj.period_name })
    }
}

function updateCourse(stepId, baseId, periodId)
{
    coursesModel.clear();

    var jsondata = dbMan.getAllCourses(stepId, baseId, periodId);
    //co.id, co.course_name, co.step_id, co.base_id, co.period_id, co.course_coefficient, co.test_coefficient,
    //co.shared_coefficient,  co.final_weight, shared_weight, course_flag, test_flag, base_average, sort_priority

    for(var obj of jsondata)
    {
            coursesModel.append(obj);

    }
}

