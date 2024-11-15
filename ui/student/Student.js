function updateBranchCB()
{
    branchCBoxModel.clear();
    studentModel.clear();
    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchCBoxModel.append({value: obj.id,  text: temp })
    }
}

function studentsUpdate(branchId)
{
    studentModel.clear();
    var jsondata = dbMan.getBranchStudents(branchId);
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
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

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
                             Name: obj.name,
                             Lastname: obj.lastname,
                             Fathername: obj.fathername,
                             Gender: obj.gender,
                             Enabled: obj.enabled,
                             Step_name: obj.step_name,
                             Study_base: obj.study_base,
                             Study_period: obj.study_period,
                             Passed: obj.passed
                         });
    }

}


//student courses
function updateStudentCourses(registerId)
{

    // 0sc.id, sc.student_id, sc.course_id
    // 3co.course_name, co.course_coefficient,  co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
    // 9t.teacher, cl.class_name

    scModel.clear();
    var jsondata = dbMan.getStudentCourses(registerId);
    for(var obj of jsondata)
    {
        scModel.append({
                           Id: obj.id,
                           Student_id: obj.student_id,
                           Course_id: obj.course_id,
                           Course_name: obj.course_name,
                           Course_coefficient: obj.course_coefficient,
                           Test_coefficient: obj.test_coefficient,
                           Class_id: obj.class_id,
                           Step_id: obj.step_id,
                           Study_base_id: obj.study_base_id,
                           Teacher_id: obj.teacher_id,
                           Study_period_id: obj.study_period_id,
                           Teacher: obj.teacher,
                           Class_name: obj.class_name

                       });
    }
}


function updateBaseCourses(registerId, classId)
{

    //update database
    if(dbMan.updateStudentBaseCourses(registerId, classId))
    {
        // update model
        updateStudentCourses(registerId);
        return true;
    }
    else
        return false;
}


function updateCourseCB(student_id, step_id, base_id, period_id)
{
    courseCBModel.clear();
    var jsondata = dbMan.getStudentLeftCourses(student_id, step_id, base_id, period_id);
    // co.id, co.course_name, cl.class_name, t.name, t.lastname
    for(var obj of jsondata)
    {
        courseCBModel.append({value: obj.id,  text: obj.course_name + " (" + obj.teacher + "- " + obj.class_name + ") " })
    }

}


function updateClassCB(branchId)
{
    classModel.clear();

    var jsondata = dbMan.getBranchClasses(branchId);
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
    var jsondata = dbMan.getStudentCourseEvals(student_id, course_id);
    //se.id, se.student_id, se.eval_id, se.student_grade, se.normalised_grade, e.eval_name, e.eval_time, e.course_id, e.max_value
    for(var obj of jsondata)
    {
        courseEvalModel.append({
                                   Id: obj.id,
                                   Student_id: obj.student_id,
                                   Eval_id: obj.eval_id,
                                   Student_grade: obj.student_grade,
                                   Normalised_grade: obj.normalised_grade,
                                   Eval_name: obj.eval_name,
                                   Eval_time: obj.eval_time,
                                   Course_id: obj.course_id,
                                   Max_value: obj.max_value,
                                   Percentage: obj.percentage,
                                   Final_eval: obj.final_eval,
                                   Semester: obj.semester,
                                   Report_included: obj.report_included
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
