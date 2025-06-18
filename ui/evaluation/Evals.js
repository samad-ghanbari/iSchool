function updateBranchCB()
{
    branchModel.clear();
    stepModel.clear();
    fieldModel.clear();
    baseModel.clear();
    periodModel.clear();
    evalsModel.clear();

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
    evalsModel.clear();

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
    evalsModel.clear();

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
    evalsModel.clear();

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
    periodModel.clear();
    evalsModel.clear();

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
    evalsModel.clear();

    var jsondata = dbMan.getStepPeriods(stepId, false);
    //p.id, p.step_id, p.period_name, p.passed,s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
    var temp;
    for(var obj of jsondata)
    {
        if(!obj.passed)
            periodModel.append({value: obj.period_id,  text: obj.period_name })
    }
}

function updateEvals(stepId, baseId, periodId)
{
    evalsModel.clear();

    var jsondata = dbMan.getEvals(stepId, baseId, periodId);
    //e.id, e.eval_name, e.step_id, e.base_id, e.period_id, e.course_flag, e.test_flag, e.final_flag, midterm, semester, e.max_grade, e.sort_priority

    for(var obj of jsondata)
    {
            evalsModel.append(obj);
    }
}

