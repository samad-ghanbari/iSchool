function updateBranchCB()
{
    branchCBoxModel.clear();
    studentModel.clear();
    periodCBoxModel.clear();
    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchCBoxModel.append({value: obj.id,  text: temp })
    }
}

function updatePeriodCB(branch_id)
{
    periodCBoxModel.clear();
    studentModel.clear();
    var jsondata = dbMan.getBranchPeriods(branch_id);
    var temp;
    periodCBoxModel.append({value: -1,  text: "-" })
    for(var obj of jsondata)
    {
        //sp.id, sp.branch_id, sp.study_period, sp.passed, b.city, b.branch_name, b.branch_address
        temp = obj.study_period;
        periodCBoxModel.append({value: obj.id,  text: temp })
    }
}

function updateStudentsModel(branch_id, period_id)
{
    studentModel.clear();
    var jsondata = dbMan.getBranchPeriodStudents(branch_id, period_id);
    //s.id, s.branch_id, s.name, s.lastname, s.fathername, s.gender, s.birthday, s.enabled, b.city, b.branch_name
    for(var obj of jsondata)
    {
        studentModel.append({
                                Id: obj.id,
                                BranchId: obj.branch_id,
                                Name: obj.name,
                                LastName: obj.lastname,
                                FatherName: obj.fathername,
                                Gender: obj.gender,
                                Birthday: obj.birthday,
                                Enabled: obj.enabled,
                                Photo: obj.photo,
                                City: obj.city,
                                BranchName: obj.branch_name
                            });
    }
}


function filterStudents(students)
{
    studentModel.clear();
    var jsondata = dbMan.filterStudents(students);
    //s.id, s.branch_id, s.name, s.lastname, s.fathername, s.gender, s.birthday, s.enabled, b.city, b.branch_name
    for(var obj of jsondata)
    {
        studentModel.append({
                                Id: obj.id,
                                BranchId: obj.branch_id,
                                Name: obj.name,
                                LastName: obj.lastname,
                                FatherName: obj.fathername,
                                Gender: obj.gender,
                                Birthday: obj.birthday,
                                Enabled: obj.enabled,
                                Photo: obj.photo,
                                City: obj.city,
                                BranchName: obj.branch_name
                            });
    }
}


//register

function updateStepCB(branchId)
{
    stepCBoxModel.clear();
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
    var jsondata = dbMan.getBranchStudyBases(branchId);
    //sb.id, sb.branch_id, sb.study_base, b.city, b.branch_name
    var temp;
    for(var obj of jsondata)
    {
        baseCBoxModel.append({value: obj.id,  text: obj.study_base })
    }
}

function updatePeiodCB(branchId)
{
    periodCBoxModel.clear();
    var jsondata = dbMan.getBranchPeriods(branchId);
    //sp.id, sp.branch_id, sp.study_period, sp.passed, b.city, b.branch_name, b.branch_address
    var temp;
    for(var obj of jsondata)
    {
        if(!obj.passed)
            periodCBoxModel.append({value: obj.id,  text: obj.study_period })
    }
}

function updateStudentRegs(branchId, studentId)
{
    //0r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id, s.branch_id
    // 6br.city, br.branch_name, st.step_name, sb.study_base, sp.study_period, sp.passed, cl.class_name

    regsModel.clear();
    var jsondata = dbMan.getRegisterations(branchId, studentId);
    for(var obj of jsondata)
    {
        regsModel.append({
                             Id: obj.id,
                             Student_id: obj.student_id,
                             Step_id: obj.step_id,
                             Study_base_id: obj.study_base_id,
                             Study_period_id: obj.study_period_id,
                             Branch_id: obj.branch_id,
                             City: obj.city,
                             Branch_name: obj.branch_name,
                             Step_name: obj.step_name,
                             Study_base: obj.study_base,
                             Study_period: obj.study_period,
                             Passed: obj.passed,
                             Class_name: obj.class_name
                         });
    }

}


//student courses
function updateStudentCourses(registerId)
{
    scModel.clear();
    var jsondata = dbMan.getStudentCourses(registerId);
    for(var obj of jsondata)
    {
        // 0sc.id, 1sc.student_id, 2sc.register_id, 3sc.course_id, 4sc.teacher_id,
        // 5co.course_name, 6.study_base_id, 7.course_coefficient, 8.test_coefficient, 9.shared_coefficient, 10.final_weight,
        // 11.teacher

        scModel.append({
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


function updateCourseCB(register_id, base_course)
{
    courseCBModel.clear();
    var jsondata = dbMan.getStudentLeftCourses(register_id, base_course);
    // course_id, course_name, course_coefficient, test_coefficient, shared_coefficient, final_weight
    for(var obj of jsondata)
    {
        courseCBModel.append({value: obj.course_id,  text: obj.course_name })
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


function updateClassCB(step_id, base_id, period_id)
{
    classModel.clear();

    var jsondata = dbMan.getClasses(step_id, base_id, period_id);
    //id, branch_id, class_name, class_desc, sort_priority
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.class_name + " - "+ obj.class_desc;
        classModel.append({value: obj.id,  text: temp })
    }
}


// course eval
function updateCourseEvalModel(student_id, course_id)
{
    courseEvalModel.clear();
    var jsondata = dbMan.getStudentCourseEvals(student_id,  course_id);
    //se.id, se.student_id, se.eval_id, se.student_grade, se.normalised_grade, e.eval_cat_id, e.course_id, e.class_id, e.eval_time, e.max_grade, e.included,
    //ec.eval_cat, ec.test_flag, ec.final_flag

    for(var obj of jsondata)
    {
        courseEvalModel.append({
                                   Id: obj.id,
                                   Student_id: obj.student_id,
                                   Eval_id: obj.eval_id,
                                   Student_grade: obj.student_grade,
                                   Normalised_grade: obj.normalised_grade,
                                   Eval_cat_id: obj.eval_cat_id,
                                   Course_id: obj.course_id,
                                   Class_id: obj.class_id,
                                   Eval_time: obj.eval_time,
                                   Max_grade: obj.max_grade,
                                   Included: obj.included,
                                   Eval_cat: obj.eval_cat,
                                   Test_flag: obj.test_flag,
                                   Final_flag: obj.final_flag
                               });


    }
}


//staudent stat
function updateStudentStatModel(registerId)
{
    /*
{
        Course_name : "ریاضی",
        Course_coefficient: 3,
        Test_coefficient: 2,

        Course_continous: 15,
        Test_continous: 16,

        Course_final: 17,
        Test_final: 18,

        Course_semester: 19,
        Test_semester: 20

}
*/

    studentStatModel.clear();
    var jsondata = dbMan.getUserPeriodStat(registerId);
    for(var obj of jsondata)
    {
        studentStatModel.append({
                                    ID : obj.ID,
                                    Course_name : obj.Course_name,
                                    Course_coefficient: obj.Course_coefficient,
                                    Test_coefficient: obj.Test_coefficient,
                                    Base_course: obj.Base_course,

                                    Course_continous: obj.Course_continous,
                                    Test_continous: obj.Test_continous,

                                    Course_final: obj.Course_final,
                                    Test_final: obj.Test_final,

                                    Course_semester: obj.Course_semester,
                                    Test_semester: obj.Test_semester

                                });
    }
}
