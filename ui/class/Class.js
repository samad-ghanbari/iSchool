function updateBranchCB()
{
    branchCBoxModel.clear();
    stepCBoxModel.clear();
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
    periodCB.currentIndex = -1

    classModel.clear();

    var jsondata = dbMan.getBranchSteps(branchId);
    //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
    var temp;
    for(var obj of jsondata)
    {
        stepCBoxModel.append({value: obj.id,  text: obj.step_name, field_based: obj.field_based })
    }
}


function updatePeriodCB(step_id)
{
    periodCBoxModel.clear();
    classModel.clear();
    var jsondata = dbMan.getStepPeriods(step_id, false);
    var temp;
    for(var obj of jsondata)
    {
        //p.period_id, p.step_id, p.period_name, p.passed, s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
        periodCBoxModel.append({value: obj.period_id,  text: obj.period_name })
    }
}

function updateClassModel(step_id, period_id)
{
    classModel.clear();
    var jsondata = dbMan.getClasses(step_id, period_id);
    //
    for(var obj of jsondata)
    {
        //cl.id, cl.base_id, b.step_id, b.base_name, b.field_id, f.field_name, cl.period_id, cl.class_name, cl.class_desc, cl.sort_priority
        classModel.append(obj)
    }
}

// class students

function updateClassStudentsModel(class_id)
{
    classStudentsModel.clear();
    var jsondata = dbMan.getClassStudents(class_id, true);
    for(var obj of jsondata)
    {
        // Register_id, Student_id , Student, Fathername, Gender, Birthday, Photo
        classStudentsModel.append({
                                      Register_id: obj.register_id,
                                      Student_id: obj.student_id,
                                      Student: obj.student,
                                      Fathername: obj.fathername,
                                      Gender: obj.gender,
                                      Birthday: obj.birthday,
                                      Photo: obj.photo
                                  });
    }
}

function updateClassStudentCourses(register_id)
{
    cscModel.clear();
    var jsondata = dbMan.getStudentCourses(register_id);
    for(var obj of jsondata)
    {
        // 0sc.Id, 1sc.Student_id, 2sc.Register_id, 3sc.Course_id, 4sc.Teacher_id,
        // 5co.Course_name, 6.Study_base_id, 7.Course_coefficient, 8.Test_coefficient, 9.Shared_coefficient, 10.Final_weight,
        // 11.Teacher

        cscModel.append({
                            Id: obj.id,
                            Student_id: obj.student_id,
                            Register_id: obj.register_id,
                            Course_id: obj.course_id,
                            Teacher_id: obj.teacher_id,
                            Course_name: obj.course_name,
                            Study_base_id: obj.study_base_id,
                            Course_coefficient: obj.course_coefficient,
                            Test_coefficient: obj.test_coefficient,
                            Shared_coefficient: obj.shared_coefficient,
                            Final_weight: obj.final_weight,
                            Teacher: obj.teacher,
                        });
    }
}

function updateClassSCEvalModel(student_id, course_id)
{
    classSCEModel.clear();
    var jsondata = dbMan.getCategorisedEvals(student_id,  course_id);
    //se.id, se.Student_id, se.Eval_id, se.Student_grade, se.Normalised_grade, e.Eval_cat_id, e.Course_id, e.Class_id, e.Eval_time, e.Max_grade, e.Included,
    //ec.Eval_cat, ec.Test_flag, ec.Final_flag

    for(var obj of jsondata)
    {
        classSCEModel.append(obj);
    }
}
