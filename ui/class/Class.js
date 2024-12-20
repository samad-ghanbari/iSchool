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
    //baseCBoxModel.append({value: 0,  text: " - " });

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

function updateCourseCB(step_id, base_id, period_id)
{
    courseCBoxModel.clear();
    var jsondata = dbMan.getBaseCourses(step_id, base_id, period_id);
    //
    for(var obj of jsondata)
    {
        //co.id, co.course_name, co.step_id, co.study_base_id, co.study_period_id, co.course_coefficient, co.test_coefficient,  co.shared_coefficient,  co.final_weight,
        //st.branch_id, st.step_name, sb.study_base, sp.study_period

        courseCBoxModel.append({
                                   value: obj.id,
                                   text: obj.course_name,
                               })
    }
}

function updateTeacherCB(branch_id)
{
    teacherCBoxModel.clear();
    var jsondata = dbMan.getBranchTeachers(branch_id);
    //
    for(var obj of jsondata)
    {
        // /t.id, t.branch_id, t.name, t.lastname, t.gender, t.study_degree, t.study_field, t.telephone, t.enabled, b.city, b.branch_name

        teacherCBoxModel.append({
                                    value: obj.id,
                                    text: obj.name + " " + obj.lastname + " ("+ obj.study_field + ") ",
                                })
    }
}

function getTeacherModel(branch_id)
{
    var jsondata = dbMan.getBranchTeachers(branch_id);
    var model = [];
    //
    for(var obj of jsondata)
    {
        // /t.id, t.branch_id, t.name, t.lastname, t.gender, t.study_degree, t.study_field, t.telephone, t.enabled, b.city, b.branch_name

        model.push({
                       value: obj.id,
                       text: obj.name + " " + obj.lastname + " ("+ obj.study_field + ") ",
                   });
    }
    return model;
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
