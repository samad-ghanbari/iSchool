
// eval cats
function updateBranchCB()
{
    branchCBoxModel.clear();
    stepCBoxModel.clear();
    baseCBoxModel.clear();
    periodCBoxModel.clear();

    evalCatsModel.clear();

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

    evalCatsModel.clear();

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

    evalCatsModel.clear();

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

    evalCatsModel.clear();

    var jsondata = dbMan.getBranchPeriods(branchId);
    //sp.id, sp.branch_id, sp.study_period, sp.passed, b.city, b.branch_name, b.branch_address
    var temp;
    for(var obj of jsondata)
    {
        if(!obj.passed)
            periodCBoxModel.append({value: obj.id,  text: obj.study_period })
    }
}

function updateEvalCatsModel(stepId, baseId, periodId)
{
    evalCatsModel.clear();

    var jsondata = dbMan.getEvalCats(stepId, baseId, periodId);

    for(var obj of jsondata)
    {
        //id, eval_cat, step_id, study_base_id, study_period_id, test_flag, final_flag
        evalCatsModel.append({
                                Id: obj.id,
                                Eval_cat: obj.eval_cat,
                                Step_id: obj.step_id,
                                Study_base_id: obj.study_base_id,
                                Study_period_id: obj.study_period_id,
                                Test_flag: obj.test_flag,
                                Final_flag: obj.final_flag,
                                Sort_priority: obj.sort_priority
                            });
    }
}


// evals
function updateEvals(eval_cat_id, class_id)
{
    evalsModel.clear();
    var jsondata = dbMan.getCatEvals(eval_cat_id, class_id);
    for(var obj of jsondata)
    {
        // e.id, e.eval_cat_id, e.course_id, e.class_id, e.eval_time, e.max_grade, e.included,
        // co.course_name, co.course_coefficient, co.test_coefficient, co.shared_coefficient, co.final_weight

        evalsModel.append({
                              Id: obj.id,
                              Eval_cat_id: obj.eval_cat_id,
                              Course_id: obj.course_id,
                              Class_id: obj.class_id,
                              Class_name: obj.class_name,
                              Eval_time: obj.eval_time,
                              Max_grade: obj.max_grade,
                              Included: obj.included,
                              Course_name: obj.course_name,
                              Course_coefficient: obj.course_coefficient,
                              Test_coefficient: obj.test_coefficient,
                              Shared_coefficient: obj.shared_coefficient,
                              Final_weight: obj.final_weight,
                          });
    }
}


function updateClassCB(course_id)
{
    classCBoxModel.clear();
    var jsondata = dbMan.getCourseClasses(course_id);
    for(var obj of jsondata)
    {
        classCBoxModel.append({value: obj.class_id,  text: obj.class_name });
    }
}

function updateAllClassesCB(step_id, base_id, period_id)
{
    evalsModel.clear();
    var jsondata = dbMan.getClasses(step_id, base_id, period_id);

    for(var obj of jsondata)
    {
        //c.id, c.step_id, c.study_base_id, c.study_period_id, c.class_name, c.class_desc, c.sort_priority, st.step_name, sb.study_base, sp.study_period
        allClassCBoxModel.append({value: obj.id,  text: obj.class_name });
    }

     allClassCBoxModel.append({value: -1,  text: "همه کلاس‌ها" });
}

function updateCourseCB(step_id, base_id, period_id)
{
    courseCBoxModel.clear();
    var jsondata = dbMan.getCourses(step_id, base_id, period_id);
    //
    for(var obj of jsondata)
    {
        courseCBoxModel.append({
                              value: obj.id,
                              text: obj.course_name,
                          })
    }
}

function updateClassStudentsEval(class_id, eval_id)
{
    evalStudentsModel.clear();
    var jsondata = dbMan.getClassStudentsEval(class_id, eval_id);
    for(var obj of jsondata)
    {
        //se.id, se.student_id, se.eval_id, se.student_grade, se.normalised_grade, s.student, s.fathername, s.gender, s.photo
        evalStudentsModel.append({
                              Id: obj.id,
                              Student_id: obj.student_id,
                              Eval_id: obj.eval_id,
                              Student_grade: obj.student_grade,
                              Normalised_grade: obj.normalised_grade,
                              Student: obj.student,
                              Fathername: obj.fathername,
                              Gender: obj.gender,
                              Photo: obj.photo
                          });
    }
}

function updateStudentCB(class_id)
{
    studentCBoxModel.clear();
    var jsondata = dbMan.getClassStudents(class_id);
    //
    for(var obj of jsondata)
    {
        studentCBoxModel.append({
                              value: obj.id,
                              text: obj.student,
                          })
    }
}
