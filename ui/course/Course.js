function updateBranchCB()
{
    branchCBoxModel.clear();
    stepCBoxModel.clear();
    baseCBoxModel.clear();
    periodCBoxModel.clear();

    coursesModel.clear();

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

    coursesModel.clear();

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

    coursesModel.clear();

    var jsondata = dbMan.getBranchStudyBases(branchId);
    //sb.id, sb.branch_id, sb.study_base, b.city, b.branch_name
    baseCBoxModel.append({value: 0,  text: " - " });

    var temp;
    for(var obj of jsondata)
    {
        baseCBoxModel.append({value: obj.id,  text: obj.study_base })
    }

}

function updatePeriodCB(branchId)
{
    periodCBoxModel.clear();

    coursesModel.clear();

    var jsondata = dbMan.getBranchPeriods(branchId);
    //sp.id, sp.branch_id, sp.study_period, sp.passed, b.city, b.branch_name, b.branch_address
    var temp;
    for(var obj of jsondata)
    {
        if(!obj.passed)
            periodCBoxModel.append({value: obj.id,  text: obj.study_period })
    }
}

function updateCourse(stepId, baseId, periodId)
{
    coursesModel.clear();

    var jsondata = dbMan.getAllCourses(stepId, baseId, periodId);
    // co.id, co.course_name, co.step_id, co.study_base_id, co.study_period_id, co.course_coefficient,
    // co.test_coefficient,  co.shared_coefficient, co.final_weight, st.branch_id, st.step_name, sb.study_base, sp.study_period

    for(var obj of jsondata)
    {
            coursesModel.append({
                                        Id: obj.id,
                                        Course_name: obj.course_name,
                                        Step_id: obj.step_id,
                                        Study_base_id: obj.study_base_id,
                                        Study_period_id: obj.study_period_id,
                                        Course_coefficient: obj.course_coefficient,
                                        Test_coefficient: obj.test_coefficient,
                                        Shared_coefficient: obj.shared_coefficient,
                                        Final_weight: obj.final_weight,
                                        Branch_id: obj.branch_id,
                                        Step_name: obj.step_name,
                                        Study_base: obj.study_base,
                                        Study_period: obj.study_period,
                                    });

    }
}

