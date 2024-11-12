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

function updateCourses(stepId, baseId, periodId)
{
    coursesModel.clear();

    var jsondata = dbMan.getAllCourses(stepId, baseId, periodId); // base course an dstep course
    // co.id, co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id,
    // cl.class_name, st.branch_id, st.step_name, sb.study_base, sp.study_period, teacher

    for(var obj of jsondata)
    {
        coursesModel.append({
                                Id: obj.id,
                                Course_name: obj.course_name,
                                Class_id: obj.class_id,
                                Step_id: obj.step_id,
                                Study_base_id: obj.study_base_id,
                                Teacher_id: obj.teacher_id,
                                Study_period_id: obj.study_period_id,
                                Class_name: obj.class_name,
                                Branch_id: obj.branch_id,
                                Step_name: obj.step_name,
                                Study_base: obj.study_base,
                                Study_period: obj.study_period,
                                Teacher: obj.teacher
                            });
    }
}

//insert course

function updateEvals(courseId)
{
    evalsModel.clear();
    var jsondata = dbMan.getCourseEvals(courseId);
    for(var obj of jsondata)
    {
        // e.id, e.eval_name, e.eval_time, e.course_id, e.max_value, percentage, final_eval, semester
        // co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id,
        // cl.class_name, t.name, t.lastname
        evalsModel.append({
                              Id: obj.id,
                              Eval_name: obj.eval_name,
                              Eval_time: obj.eval_time,
                              Course_id: obj.course_id,
                              Max_value: obj.max_value,
                              Percentage: obj.percentage,
                              Final_eval: obj.final_eval,
                              Semester: obj.semester,
                              Course_name: obj.course_name,
                              Class_id: obj.class_id,
                              Step_id: obj.step_id,
                              Study_base_id: obj.study_base_id,
                              Teacher_id: obj.teacher_id,
                              Study_period_id: obj.study_period_id,
                              Class_name: obj.class_name,
                              Teacher: obj.teacher

                          });
    }
}
