/****************************************************************************
** Meta object code from reading C++ file 'dbman.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.16)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../lib/database/dbman.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'dbman.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.16. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_DbMan_t {
    QByteArrayData data[289];
    char stringdata0[4252];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_DbMan_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_DbMan_t qt_meta_stringdata_DbMan = {
    {
QT_MOC_LITERAL(0, 0, 5), // "DbMan"
QT_MOC_LITERAL(1, 6, 13), // "isDbConnected"
QT_MOC_LITERAL(2, 20, 0), // ""
QT_MOC_LITERAL(3, 21, 10), // "getVersion"
QT_MOC_LITERAL(4, 32, 13), // "getAppVersion"
QT_MOC_LITERAL(5, 46, 15), // "isOnMaintenance"
QT_MOC_LITERAL(6, 62, 10), // "newRelease"
QT_MOC_LITERAL(7, 73, 12), // "getLastError"
QT_MOC_LITERAL(8, 86, 16), // "userAuthenticate"
QT_MOC_LITERAL(9, 103, 5), // "natid"
QT_MOC_LITERAL(10, 109, 8), // "password"
QT_MOC_LITERAL(11, 118, 7), // "getUser"
QT_MOC_LITERAL(12, 126, 6), // "userId"
QT_MOC_LITERAL(13, 133, 16), // "getUserByteArray"
QT_MOC_LITERAL(14, 150, 11), // "getUserName"
QT_MOC_LITERAL(15, 162, 11), // "isUserAdmin"
QT_MOC_LITERAL(16, 174, 16), // "isUserSuperAdmin"
QT_MOC_LITERAL(17, 191, 10), // "insertUser"
QT_MOC_LITERAL(18, 202, 4), // "user"
QT_MOC_LITERAL(19, 207, 8), // "getUsers"
QT_MOC_LITERAL(20, 216, 11), // "filterUsers"
QT_MOC_LITERAL(21, 228, 10), // "userFilter"
QT_MOC_LITERAL(22, 239, 10), // "updateUser"
QT_MOC_LITERAL(23, 250, 10), // "deleteUser"
QT_MOC_LITERAL(24, 261, 18), // "verifyUserPassword"
QT_MOC_LITERAL(25, 280, 18), // "changeUserPassword"
QT_MOC_LITERAL(26, 299, 2), // "id"
QT_MOC_LITERAL(27, 302, 17), // "getLastInsertedId"
QT_MOC_LITERAL(28, 320, 17), // "getCommaSeparated"
QT_MOC_LITERAL(29, 338, 10), // "QList<int>"
QT_MOC_LITERAL(30, 349, 4), // "list"
QT_MOC_LITERAL(31, 354, 9), // "insertLog"
QT_MOC_LITERAL(32, 364, 6), // "Target"
QT_MOC_LITERAL(33, 371, 6), // "Action"
QT_MOC_LITERAL(34, 378, 12), // "ActionDetail"
QT_MOC_LITERAL(35, 391, 12), // "listToString"
QT_MOC_LITERAL(36, 404, 11), // "getBranches"
QT_MOC_LITERAL(37, 416, 15), // "getBranchesJson"
QT_MOC_LITERAL(38, 432, 13), // "getBranchJson"
QT_MOC_LITERAL(39, 446, 19), // "getBranchesJsonById"
QT_MOC_LITERAL(40, 466, 8), // "branches"
QT_MOC_LITERAL(41, 475, 15), // "getBranchesById"
QT_MOC_LITERAL(42, 491, 13), // "getUserBranch"
QT_MOC_LITERAL(43, 505, 12), // "updateBranch"
QT_MOC_LITERAL(44, 518, 6), // "branch"
QT_MOC_LITERAL(45, 525, 12), // "deleteBranch"
QT_MOC_LITERAL(46, 538, 12), // "insertBranch"
QT_MOC_LITERAL(47, 551, 9), // "branchObj"
QT_MOC_LITERAL(48, 561, 11), // "filterSteps"
QT_MOC_LITERAL(49, 573, 5), // "steps"
QT_MOC_LITERAL(50, 579, 16), // "filterStudyBases"
QT_MOC_LITERAL(51, 596, 5), // "bases"
QT_MOC_LITERAL(52, 602, 16), // "getStepBranchMap"
QT_MOC_LITERAL(53, 619, 13), // "QMap<int,int>"
QT_MOC_LITERAL(54, 633, 21), // "getStudyBaseBranchMap"
QT_MOC_LITERAL(55, 655, 10), // "studyBases"
QT_MOC_LITERAL(56, 666, 17), // "getStepsByteArray"
QT_MOC_LITERAL(57, 684, 8), // "getSteps"
QT_MOC_LITERAL(58, 693, 12), // "getStepsById"
QT_MOC_LITERAL(59, 706, 14), // "getStepsBranch"
QT_MOC_LITERAL(60, 721, 7), // "stepsId"
QT_MOC_LITERAL(61, 729, 18), // "getBranchStepsJson"
QT_MOC_LITERAL(62, 748, 8), // "branchId"
QT_MOC_LITERAL(63, 757, 16), // "getStepsJsonById"
QT_MOC_LITERAL(64, 774, 10), // "insertStep"
QT_MOC_LITERAL(65, 785, 4), // "step"
QT_MOC_LITERAL(66, 790, 10), // "deleteStep"
QT_MOC_LITERAL(67, 801, 6), // "stepId"
QT_MOC_LITERAL(68, 808, 10), // "updateStep"
QT_MOC_LITERAL(69, 819, 11), // "getStepJson"
QT_MOC_LITERAL(70, 831, 19), // "getBranchStudyBases"
QT_MOC_LITERAL(71, 851, 15), // "deleteStudyBase"
QT_MOC_LITERAL(72, 867, 11), // "studyBaseId"
QT_MOC_LITERAL(73, 879, 15), // "updateStudyBase"
QT_MOC_LITERAL(74, 895, 4), // "base"
QT_MOC_LITERAL(75, 900, 15), // "insertStudyBase"
QT_MOC_LITERAL(76, 916, 12), // "getStudyBase"
QT_MOC_LITERAL(77, 929, 22), // "getStudyBasesByteArray"
QT_MOC_LITERAL(78, 952, 18), // "getStudyBaseBranch"
QT_MOC_LITERAL(79, 971, 6), // "baseId"
QT_MOC_LITERAL(80, 978, 13), // "getStudyBases"
QT_MOC_LITERAL(81, 992, 17), // "getStudyBasesById"
QT_MOC_LITERAL(82, 1010, 16), // "getBranchPeriods"
QT_MOC_LITERAL(83, 1027, 12), // "periodUpdate"
QT_MOC_LITERAL(84, 1040, 9), // "periodObj"
QT_MOC_LITERAL(85, 1050, 9), // "getPeriod"
QT_MOC_LITERAL(86, 1060, 8), // "periodId"
QT_MOC_LITERAL(87, 1069, 12), // "periodInsert"
QT_MOC_LITERAL(88, 1082, 12), // "periodDelete"
QT_MOC_LITERAL(89, 1095, 10), // "getClasses"
QT_MOC_LITERAL(90, 1106, 7), // "step_id"
QT_MOC_LITERAL(91, 1114, 7), // "base_id"
QT_MOC_LITERAL(92, 1122, 9), // "period_id"
QT_MOC_LITERAL(93, 1132, 15), // "getClassesBrief"
QT_MOC_LITERAL(94, 1148, 9), // "withEmpty"
QT_MOC_LITERAL(95, 1158, 23), // "getClassMaxSortPriority"
QT_MOC_LITERAL(96, 1182, 11), // "classInsert"
QT_MOC_LITERAL(97, 1194, 8), // "classObj"
QT_MOC_LITERAL(98, 1203, 11), // "classDelete"
QT_MOC_LITERAL(99, 1215, 7), // "classId"
QT_MOC_LITERAL(100, 1223, 11), // "classUpdate"
QT_MOC_LITERAL(101, 1235, 16), // "getCourseClasses"
QT_MOC_LITERAL(102, 1252, 9), // "course_id"
QT_MOC_LITERAL(103, 1262, 16), // "getClassBranchId"
QT_MOC_LITERAL(104, 1279, 8), // "class_id"
QT_MOC_LITERAL(105, 1288, 15), // "getClassCourses"
QT_MOC_LITERAL(106, 1304, 12), // "getClassName"
QT_MOC_LITERAL(107, 1317, 20), // "getClassStudentsName"
QT_MOC_LITERAL(108, 1338, 17), // "QMap<int,QString>"
QT_MOC_LITERAL(109, 1356, 15), // "getClassDetails"
QT_MOC_LITERAL(110, 1372, 17), // "getClassDetailMap"
QT_MOC_LITERAL(111, 1390, 17), // "classDetailInsert"
QT_MOC_LITERAL(112, 1408, 3), // "Obj"
QT_MOC_LITERAL(113, 1412, 10), // "teacher_id"
QT_MOC_LITERAL(114, 1423, 18), // "classDetailsInsert"
QT_MOC_LITERAL(115, 1442, 12), // "classTeacher"
QT_MOC_LITERAL(116, 1455, 17), // "classDetailDelete"
QT_MOC_LITERAL(117, 1473, 15), // "class_detail_id"
QT_MOC_LITERAL(118, 1489, 17), // "classDetailUpdate"
QT_MOC_LITERAL(119, 1507, 12), // "ref_class_id"
QT_MOC_LITERAL(120, 1520, 21), // "getClassStudentsCount"
QT_MOC_LITERAL(121, 1542, 14), // "getBaseCourses"
QT_MOC_LITERAL(122, 1557, 14), // "getStepCourses"
QT_MOC_LITERAL(123, 1572, 13), // "getAllCourses"
QT_MOC_LITERAL(124, 1586, 10), // "student_id"
QT_MOC_LITERAL(125, 1597, 22), // "getAllCoursesMinimised"
QT_MOC_LITERAL(126, 1620, 9), // "except_id"
QT_MOC_LITERAL(127, 1630, 10), // "getCourses"
QT_MOC_LITERAL(128, 1641, 12), // "getCourseIds"
QT_MOC_LITERAL(129, 1654, 12), // "courseInsert"
QT_MOC_LITERAL(130, 1667, 6), // "course"
QT_MOC_LITERAL(131, 1674, 29), // "sharedCourseCoefficientAppend"
QT_MOC_LITERAL(132, 1704, 9), // "shared_id"
QT_MOC_LITERAL(133, 1714, 27), // "sharedTestCoefficientAppend"
QT_MOC_LITERAL(134, 1742, 12), // "courseDelete"
QT_MOC_LITERAL(135, 1755, 12), // "isStepCourse"
QT_MOC_LITERAL(136, 1768, 12), // "courseUpdate"
QT_MOC_LITERAL(137, 1781, 19), // "getClassLeftCourses"
QT_MOC_LITERAL(138, 1801, 13), // "getCourseName"
QT_MOC_LITERAL(139, 1815, 26), // "getCourseSharedCoefficient"
QT_MOC_LITERAL(140, 1842, 25), // "QMap<QString,QList<int> >"
QT_MOC_LITERAL(141, 1868, 20), // "getCourseFinalWeight"
QT_MOC_LITERAL(142, 1889, 17), // "getBranchTeachers"
QT_MOC_LITERAL(143, 1907, 22), // "getBranchTeachersBrief"
QT_MOC_LITERAL(144, 1930, 13), // "teacherInsert"
QT_MOC_LITERAL(145, 1944, 7), // "teacher"
QT_MOC_LITERAL(146, 1952, 13), // "teacherDelete"
QT_MOC_LITERAL(147, 1966, 13), // "teacherUpdate"
QT_MOC_LITERAL(148, 1980, 14), // "filterTeachers"
QT_MOC_LITERAL(149, 1995, 10), // "getTeacher"
QT_MOC_LITERAL(150, 2006, 9), // "teacherId"
QT_MOC_LITERAL(151, 2016, 17), // "getBranchStudents"
QT_MOC_LITERAL(152, 2034, 23), // "getBranchPeriodStudents"
QT_MOC_LITERAL(153, 2058, 9), // "branch_id"
QT_MOC_LITERAL(154, 2068, 5), // "limit"
QT_MOC_LITERAL(155, 2074, 6), // "offset"
QT_MOC_LITERAL(156, 2081, 28), // "getBranchPeriodStudentsCount"
QT_MOC_LITERAL(157, 2110, 12), // "notPeriod_id"
QT_MOC_LITERAL(158, 2123, 5), // "brief"
QT_MOC_LITERAL(159, 2129, 13), // "getStudentsId"
QT_MOC_LITERAL(160, 2143, 13), // "studentInsert"
QT_MOC_LITERAL(161, 2157, 7), // "student"
QT_MOC_LITERAL(162, 2165, 13), // "studentDelete"
QT_MOC_LITERAL(163, 2179, 13), // "studentUpdate"
QT_MOC_LITERAL(164, 2193, 14), // "filterStudents"
QT_MOC_LITERAL(165, 2208, 10), // "getStudent"
QT_MOC_LITERAL(166, 2219, 17), // "getRegisterations"
QT_MOC_LITERAL(167, 2237, 9), // "studentId"
QT_MOC_LITERAL(168, 2247, 15), // "getRegistration"
QT_MOC_LITERAL(169, 2263, 11), // "register_id"
QT_MOC_LITERAL(170, 2275, 15), // "getRegisterInfo"
QT_MOC_LITERAL(171, 2291, 10), // "registerId"
QT_MOC_LITERAL(172, 2302, 21), // "getRegisterDetailInfo"
QT_MOC_LITERAL(173, 2324, 15), // "registerStudent"
QT_MOC_LITERAL(174, 2340, 3), // "obj"
QT_MOC_LITERAL(175, 2344, 13), // "getRegisterId"
QT_MOC_LITERAL(176, 2358, 14), // "registerDelete"
QT_MOC_LITERAL(177, 2373, 18), // "getCourseTeacherId"
QT_MOC_LITERAL(178, 2392, 27), // "registerStudentCourseInsert"
QT_MOC_LITERAL(179, 2420, 25), // "registerStudentEvalInsert"
QT_MOC_LITERAL(180, 2446, 18), // "getRegisterClassId"
QT_MOC_LITERAL(181, 2465, 17), // "getStudentCourses"
QT_MOC_LITERAL(182, 2483, 19), // "insertStudentCourse"
QT_MOC_LITERAL(183, 2503, 24), // "updateStudentBaseCourses"
QT_MOC_LITERAL(184, 2528, 19), // "deleteStudentCourse"
QT_MOC_LITERAL(185, 2548, 17), // "student_course_id"
QT_MOC_LITERAL(186, 2566, 21), // "getStudentLeftCourses"
QT_MOC_LITERAL(187, 2588, 10), // "baseCourse"
QT_MOC_LITERAL(188, 2599, 11), // "getEvalCats"
QT_MOC_LITERAL(189, 2611, 16), // "getEvalCatsBrief"
QT_MOC_LITERAL(190, 2628, 23), // "getEvalCatsByRegisterId"
QT_MOC_LITERAL(191, 2652, 13), // "evalCatInsert"
QT_MOC_LITERAL(192, 2666, 4), // "Eval"
QT_MOC_LITERAL(193, 2671, 13), // "evalCatDelete"
QT_MOC_LITERAL(194, 2685, 13), // "evalCatUpdate"
QT_MOC_LITERAL(195, 2699, 14), // "getEvalCatsMap"
QT_MOC_LITERAL(196, 2714, 21), // "QMap<int,QJsonObject>"
QT_MOC_LITERAL(197, 2736, 6), // "catIds"
QT_MOC_LITERAL(198, 2743, 10), // "getEvalCat"
QT_MOC_LITERAL(199, 2754, 6), // "cat_id"
QT_MOC_LITERAL(200, 2761, 12), // "getEvalsCats"
QT_MOC_LITERAL(201, 2774, 11), // "getCatEvals"
QT_MOC_LITERAL(202, 2786, 11), // "eval_cat_id"
QT_MOC_LITERAL(203, 2798, 15), // "getEvalMaxGrade"
QT_MOC_LITERAL(204, 2814, 7), // "eval_id"
QT_MOC_LITERAL(205, 2822, 10), // "evalInsert"
QT_MOC_LITERAL(206, 2833, 9), // "eval_time"
QT_MOC_LITERAL(207, 2843, 9), // "max_grade"
QT_MOC_LITERAL(208, 2853, 8), // "included"
QT_MOC_LITERAL(209, 2862, 10), // "evalDelete"
QT_MOC_LITERAL(210, 2873, 10), // "evalUpdate"
QT_MOC_LITERAL(211, 2884, 14), // "coursesHasEval"
QT_MOC_LITERAL(212, 2899, 9), // "coursesId"
QT_MOC_LITERAL(213, 2909, 4), // "test"
QT_MOC_LITERAL(214, 2914, 10), // "getEvalMap"
QT_MOC_LITERAL(215, 2925, 12), // "getEvalArray"
QT_MOC_LITERAL(216, 2938, 13), // "getEvalIdList"
QT_MOC_LITERAL(217, 2952, 17), // "getEvalCatEvalIds"
QT_MOC_LITERAL(218, 2970, 18), // "updateEvalStudents"
QT_MOC_LITERAL(219, 2989, 20), // "getClassStudentsEval"
QT_MOC_LITERAL(220, 3010, 20), // "getClassLeftStudents"
QT_MOC_LITERAL(221, 3031, 16), // "getClassStudents"
QT_MOC_LITERAL(222, 3048, 8), // "detailed"
QT_MOC_LITERAL(223, 3057, 18), // "getClassStudentsId"
QT_MOC_LITERAL(224, 3076, 11), // "getStudents"
QT_MOC_LITERAL(225, 3088, 19), // "setStudentEvalGrade"
QT_MOC_LITERAL(226, 3108, 4), // "seid"
QT_MOC_LITERAL(227, 3113, 5), // "grade"
QT_MOC_LITERAL(228, 3119, 29), // "setStudentEvalNormalisedGrade"
QT_MOC_LITERAL(229, 3149, 17), // "deleteStudentEval"
QT_MOC_LITERAL(230, 3167, 15), // "student_eval_id"
QT_MOC_LITERAL(231, 3183, 17), // "insertStudentEval"
QT_MOC_LITERAL(232, 3201, 22), // "studentEvalDenormalise"
QT_MOC_LITERAL(233, 3224, 20), // "studentEvalNormalise"
QT_MOC_LITERAL(234, 3245, 4), // "norm"
QT_MOC_LITERAL(235, 3250, 17), // "getMaxStudentEval"
QT_MOC_LITERAL(236, 3268, 10), // "normalised"
QT_MOC_LITERAL(237, 3279, 19), // "getStudentEvalGrade"
QT_MOC_LITERAL(238, 3299, 27), // "StudentEvalEvaluationInsert"
QT_MOC_LITERAL(239, 3327, 21), // "getStudentCourseEvals"
QT_MOC_LITERAL(240, 3349, 11), // "categorised"
QT_MOC_LITERAL(241, 3361, 19), // "getCategorisedEvals"
QT_MOC_LITERAL(242, 3381, 24), // "updateStudentCourseEvals"
QT_MOC_LITERAL(243, 3406, 18), // "getStudentEvalsMap"
QT_MOC_LITERAL(244, 3425, 8), // "eval_ids"
QT_MOC_LITERAL(245, 3434, 19), // "getStudentsEvalsMap"
QT_MOC_LITERAL(246, 3454, 32), // "QMap<int,QMap<int,QJsonObject> >"
QT_MOC_LITERAL(247, 3487, 11), // "students_id"
QT_MOC_LITERAL(248, 3499, 8), // "evals_id"
QT_MOC_LITERAL(249, 3508, 26), // "refreshEvaluationsStudents"
QT_MOC_LITERAL(250, 3535, 20), // "getStudentCourseStat"
QT_MOC_LITERAL(251, 3556, 25), // "getStudentCourseStatArray"
QT_MOC_LITERAL(252, 3582, 19), // "getStudentCourseAvg"
QT_MOC_LITERAL(253, 3602, 14), // "getStudentStat"
QT_MOC_LITERAL(254, 3617, 18), // "getStudentInfoStat"
QT_MOC_LITERAL(255, 3636, 11), // "coursesStat"
QT_MOC_LITERAL(256, 3648, 9), // "test_flag"
QT_MOC_LITERAL(257, 3658, 21), // "getStudentCoursesList"
QT_MOC_LITERAL(258, 3680, 18), // "QList<QJsonObject>"
QT_MOC_LITERAL(259, 3699, 14), // "getSemesterAvg"
QT_MOC_LITERAL(260, 3714, 4), // "avgs"
QT_MOC_LITERAL(261, 3719, 24), // "getStudentCourseSemester"
QT_MOC_LITERAL(262, 3744, 20), // "getStudentCourseRank"
QT_MOC_LITERAL(263, 3765, 20), // "getStudentFinalGrade"
QT_MOC_LITERAL(264, 3786, 19), // "getStudents_Classes"
QT_MOC_LITERAL(265, 3806, 12), // "getCourseAvg"
QT_MOC_LITERAL(266, 3819, 20), // "getStudentsCourseRef"
QT_MOC_LITERAL(267, 3840, 13), // "QList<double>"
QT_MOC_LITERAL(268, 3854, 11), // "final_based"
QT_MOC_LITERAL(269, 3866, 22), // "getStudentsCourseFinal"
QT_MOC_LITERAL(270, 3889, 15), // "jsonArrayToList"
QT_MOC_LITERAL(271, 3905, 5), // "array"
QT_MOC_LITERAL(272, 3911, 15), // "listToJsonArray"
QT_MOC_LITERAL(273, 3927, 27), // "getClassCourseStudentsEvals"
QT_MOC_LITERAL(274, 3955, 20), // "exportStudentStatPdf"
QT_MOC_LITERAL(275, 3976, 8), // "filename"
QT_MOC_LITERAL(276, 3985, 15), // "semester_number"
QT_MOC_LITERAL(277, 4001, 13), // "teacher_print"
QT_MOC_LITERAL(278, 4015, 25), // "getStudentStatHeaderTable"
QT_MOC_LITERAL(279, 4041, 9), // "pageWidth"
QT_MOC_LITERAL(280, 4051, 25), // "getStudentStatCourseTable"
QT_MOC_LITERAL(281, 4077, 30), // "getStudentStatCourseTotalTable"
QT_MOC_LITERAL(282, 4108, 11), // "courseTotal"
QT_MOC_LITERAL(283, 4120, 18), // "class_member_count"
QT_MOC_LITERAL(284, 4139, 23), // "getStudentStatTestTable"
QT_MOC_LITERAL(285, 4163, 28), // "getStudentStatTestTotalTable"
QT_MOC_LITERAL(286, 4192, 9), // "testTotal"
QT_MOC_LITERAL(287, 4202, 37), // "getStudentStatSharedCoefficie..."
QT_MOC_LITERAL(288, 4240, 11) // "sharedArray"

    },
    "DbMan\0isDbConnected\0\0getVersion\0"
    "getAppVersion\0isOnMaintenance\0newRelease\0"
    "getLastError\0userAuthenticate\0natid\0"
    "password\0getUser\0userId\0getUserByteArray\0"
    "getUserName\0isUserAdmin\0isUserSuperAdmin\0"
    "insertUser\0user\0getUsers\0filterUsers\0"
    "userFilter\0updateUser\0deleteUser\0"
    "verifyUserPassword\0changeUserPassword\0"
    "id\0getLastInsertedId\0getCommaSeparated\0"
    "QList<int>\0list\0insertLog\0Target\0"
    "Action\0ActionDetail\0listToString\0"
    "getBranches\0getBranchesJson\0getBranchJson\0"
    "getBranchesJsonById\0branches\0"
    "getBranchesById\0getUserBranch\0"
    "updateBranch\0branch\0deleteBranch\0"
    "insertBranch\0branchObj\0filterSteps\0"
    "steps\0filterStudyBases\0bases\0"
    "getStepBranchMap\0QMap<int,int>\0"
    "getStudyBaseBranchMap\0studyBases\0"
    "getStepsByteArray\0getSteps\0getStepsById\0"
    "getStepsBranch\0stepsId\0getBranchStepsJson\0"
    "branchId\0getStepsJsonById\0insertStep\0"
    "step\0deleteStep\0stepId\0updateStep\0"
    "getStepJson\0getBranchStudyBases\0"
    "deleteStudyBase\0studyBaseId\0updateStudyBase\0"
    "base\0insertStudyBase\0getStudyBase\0"
    "getStudyBasesByteArray\0getStudyBaseBranch\0"
    "baseId\0getStudyBases\0getStudyBasesById\0"
    "getBranchPeriods\0periodUpdate\0periodObj\0"
    "getPeriod\0periodId\0periodInsert\0"
    "periodDelete\0getClasses\0step_id\0base_id\0"
    "period_id\0getClassesBrief\0withEmpty\0"
    "getClassMaxSortPriority\0classInsert\0"
    "classObj\0classDelete\0classId\0classUpdate\0"
    "getCourseClasses\0course_id\0getClassBranchId\0"
    "class_id\0getClassCourses\0getClassName\0"
    "getClassStudentsName\0QMap<int,QString>\0"
    "getClassDetails\0getClassDetailMap\0"
    "classDetailInsert\0Obj\0teacher_id\0"
    "classDetailsInsert\0classTeacher\0"
    "classDetailDelete\0class_detail_id\0"
    "classDetailUpdate\0ref_class_id\0"
    "getClassStudentsCount\0getBaseCourses\0"
    "getStepCourses\0getAllCourses\0student_id\0"
    "getAllCoursesMinimised\0except_id\0"
    "getCourses\0getCourseIds\0courseInsert\0"
    "course\0sharedCourseCoefficientAppend\0"
    "shared_id\0sharedTestCoefficientAppend\0"
    "courseDelete\0isStepCourse\0courseUpdate\0"
    "getClassLeftCourses\0getCourseName\0"
    "getCourseSharedCoefficient\0"
    "QMap<QString,QList<int> >\0"
    "getCourseFinalWeight\0getBranchTeachers\0"
    "getBranchTeachersBrief\0teacherInsert\0"
    "teacher\0teacherDelete\0teacherUpdate\0"
    "filterTeachers\0getTeacher\0teacherId\0"
    "getBranchStudents\0getBranchPeriodStudents\0"
    "branch_id\0limit\0offset\0"
    "getBranchPeriodStudentsCount\0notPeriod_id\0"
    "brief\0getStudentsId\0studentInsert\0"
    "student\0studentDelete\0studentUpdate\0"
    "filterStudents\0getStudent\0getRegisterations\0"
    "studentId\0getRegistration\0register_id\0"
    "getRegisterInfo\0registerId\0"
    "getRegisterDetailInfo\0registerStudent\0"
    "obj\0getRegisterId\0registerDelete\0"
    "getCourseTeacherId\0registerStudentCourseInsert\0"
    "registerStudentEvalInsert\0getRegisterClassId\0"
    "getStudentCourses\0insertStudentCourse\0"
    "updateStudentBaseCourses\0deleteStudentCourse\0"
    "student_course_id\0getStudentLeftCourses\0"
    "baseCourse\0getEvalCats\0getEvalCatsBrief\0"
    "getEvalCatsByRegisterId\0evalCatInsert\0"
    "Eval\0evalCatDelete\0evalCatUpdate\0"
    "getEvalCatsMap\0QMap<int,QJsonObject>\0"
    "catIds\0getEvalCat\0cat_id\0getEvalsCats\0"
    "getCatEvals\0eval_cat_id\0getEvalMaxGrade\0"
    "eval_id\0evalInsert\0eval_time\0max_grade\0"
    "included\0evalDelete\0evalUpdate\0"
    "coursesHasEval\0coursesId\0test\0getEvalMap\0"
    "getEvalArray\0getEvalIdList\0getEvalCatEvalIds\0"
    "updateEvalStudents\0getClassStudentsEval\0"
    "getClassLeftStudents\0getClassStudents\0"
    "detailed\0getClassStudentsId\0getStudents\0"
    "setStudentEvalGrade\0seid\0grade\0"
    "setStudentEvalNormalisedGrade\0"
    "deleteStudentEval\0student_eval_id\0"
    "insertStudentEval\0studentEvalDenormalise\0"
    "studentEvalNormalise\0norm\0getMaxStudentEval\0"
    "normalised\0getStudentEvalGrade\0"
    "StudentEvalEvaluationInsert\0"
    "getStudentCourseEvals\0categorised\0"
    "getCategorisedEvals\0updateStudentCourseEvals\0"
    "getStudentEvalsMap\0eval_ids\0"
    "getStudentsEvalsMap\0"
    "QMap<int,QMap<int,QJsonObject> >\0"
    "students_id\0evals_id\0refreshEvaluationsStudents\0"
    "getStudentCourseStat\0getStudentCourseStatArray\0"
    "getStudentCourseAvg\0getStudentStat\0"
    "getStudentInfoStat\0coursesStat\0test_flag\0"
    "getStudentCoursesList\0QList<QJsonObject>\0"
    "getSemesterAvg\0avgs\0getStudentCourseSemester\0"
    "getStudentCourseRank\0getStudentFinalGrade\0"
    "getStudents_Classes\0getCourseAvg\0"
    "getStudentsCourseRef\0QList<double>\0"
    "final_based\0getStudentsCourseFinal\0"
    "jsonArrayToList\0array\0listToJsonArray\0"
    "getClassCourseStudentsEvals\0"
    "exportStudentStatPdf\0filename\0"
    "semester_number\0teacher_print\0"
    "getStudentStatHeaderTable\0pageWidth\0"
    "getStudentStatCourseTable\0"
    "getStudentStatCourseTotalTable\0"
    "courseTotal\0class_member_count\0"
    "getStudentStatTestTable\0"
    "getStudentStatTestTotalTable\0testTotal\0"
    "getStudentStatSharedCoefficientString\0"
    "sharedArray"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_DbMan[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
     219,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0, 1109,    2, 0x0a /* Public */,
       3,    0, 1110,    2, 0x0a /* Public */,
       4,    0, 1111,    2, 0x0a /* Public */,
       5,    0, 1112,    2, 0x0a /* Public */,
       6,    0, 1113,    2, 0x0a /* Public */,
       7,    0, 1114,    2, 0x0a /* Public */,
       8,    2, 1115,    2, 0x0a /* Public */,
      11,    0, 1120,    2, 0x0a /* Public */,
      11,    1, 1121,    2, 0x0a /* Public */,
      13,    0, 1124,    2, 0x0a /* Public */,
      13,    1, 1125,    2, 0x0a /* Public */,
      14,    0, 1128,    2, 0x0a /* Public */,
      15,    0, 1129,    2, 0x0a /* Public */,
      16,    0, 1130,    2, 0x0a /* Public */,
      17,    1, 1131,    2, 0x0a /* Public */,
      19,    0, 1134,    2, 0x0a /* Public */,
      20,    1, 1135,    2, 0x0a /* Public */,
      22,    1, 1138,    2, 0x0a /* Public */,
      23,    1, 1141,    2, 0x0a /* Public */,
      24,    1, 1144,    2, 0x0a /* Public */,
      25,    2, 1147,    2, 0x0a /* Public */,
      27,    0, 1152,    2, 0x0a /* Public */,
      28,    1, 1153,    2, 0x0a /* Public */,
      31,    3, 1156,    2, 0x0a /* Public */,
      35,    1, 1163,    2, 0x0a /* Public */,
      36,    0, 1166,    2, 0x0a /* Public */,
      37,    0, 1167,    2, 0x0a /* Public */,
      38,    1, 1168,    2, 0x0a /* Public */,
      39,    1, 1171,    2, 0x0a /* Public */,
      41,    1, 1174,    2, 0x0a /* Public */,
      42,    1, 1177,    2, 0x0a /* Public */,
      43,    1, 1180,    2, 0x0a /* Public */,
      45,    1, 1183,    2, 0x0a /* Public */,
      46,    1, 1186,    2, 0x0a /* Public */,
      48,    2, 1189,    2, 0x0a /* Public */,
      50,    2, 1194,    2, 0x0a /* Public */,
      52,    1, 1199,    2, 0x0a /* Public */,
      54,    1, 1202,    2, 0x0a /* Public */,
      56,    1, 1205,    2, 0x0a /* Public */,
      57,    1, 1208,    2, 0x0a /* Public */,
      58,    1, 1211,    2, 0x0a /* Public */,
      58,    2, 1214,    2, 0x0a /* Public */,
      59,    1, 1219,    2, 0x0a /* Public */,
      61,    1, 1222,    2, 0x0a /* Public */,
      63,    1, 1225,    2, 0x0a /* Public */,
      64,    1, 1228,    2, 0x0a /* Public */,
      66,    1, 1231,    2, 0x0a /* Public */,
      68,    1, 1234,    2, 0x0a /* Public */,
      69,    1, 1237,    2, 0x0a /* Public */,
      70,    1, 1240,    2, 0x0a /* Public */,
      71,    1, 1243,    2, 0x0a /* Public */,
      73,    1, 1246,    2, 0x0a /* Public */,
      75,    1, 1249,    2, 0x0a /* Public */,
      76,    1, 1252,    2, 0x0a /* Public */,
      77,    1, 1255,    2, 0x0a /* Public */,
      78,    1, 1258,    2, 0x0a /* Public */,
      80,    1, 1261,    2, 0x0a /* Public */,
      81,    1, 1264,    2, 0x0a /* Public */,
      81,    2, 1267,    2, 0x0a /* Public */,
      82,    1, 1272,    2, 0x0a /* Public */,
      83,    1, 1275,    2, 0x0a /* Public */,
      85,    1, 1278,    2, 0x0a /* Public */,
      87,    1, 1281,    2, 0x0a /* Public */,
      88,    1, 1284,    2, 0x0a /* Public */,
      89,    3, 1287,    2, 0x0a /* Public */,
      93,    4, 1294,    2, 0x0a /* Public */,
      93,    3, 1303,    2, 0x2a /* Public | MethodCloned */,
      95,    3, 1310,    2, 0x0a /* Public */,
      96,    1, 1317,    2, 0x0a /* Public */,
      98,    1, 1320,    2, 0x0a /* Public */,
     100,    1, 1323,    2, 0x0a /* Public */,
     101,    1, 1326,    2, 0x0a /* Public */,
     103,    1, 1329,    2, 0x0a /* Public */,
     105,    1, 1332,    2, 0x0a /* Public */,
     106,    1, 1335,    2, 0x0a /* Public */,
     107,    1, 1338,    2, 0x0a /* Public */,
     109,    1, 1341,    2, 0x0a /* Public */,
     110,    1, 1344,    2, 0x0a /* Public */,
     111,    1, 1347,    2, 0x0a /* Public */,
     111,    3, 1350,    2, 0x0a /* Public */,
     114,    2, 1357,    2, 0x0a /* Public */,
     116,    1, 1362,    2, 0x0a /* Public */,
     118,    1, 1365,    2, 0x0a /* Public */,
     114,    2, 1368,    2, 0x0a /* Public */,
     120,    1, 1373,    2, 0x0a /* Public */,
     121,    3, 1376,    2, 0x0a /* Public */,
     122,    2, 1383,    2, 0x0a /* Public */,
     123,    3, 1388,    2, 0x0a /* Public */,
     123,    4, 1395,    2, 0x0a /* Public */,
     125,    3, 1404,    2, 0x0a /* Public */,
     125,    4, 1411,    2, 0x0a /* Public */,
     127,    3, 1420,    2, 0x0a /* Public */,
     128,    3, 1427,    2, 0x0a /* Public */,
     129,    1, 1434,    2, 0x0a /* Public */,
     131,    2, 1437,    2, 0x0a /* Public */,
     133,    2, 1442,    2, 0x0a /* Public */,
     134,    1, 1447,    2, 0x0a /* Public */,
     135,    1, 1450,    2, 0x0a /* Public */,
     136,    1, 1453,    2, 0x0a /* Public */,
     137,    4, 1456,    2, 0x0a /* Public */,
     138,    1, 1465,    2, 0x0a /* Public */,
     139,    1, 1468,    2, 0x0a /* Public */,
     141,    1, 1471,    2, 0x0a /* Public */,
     142,    1, 1474,    2, 0x0a /* Public */,
     143,    2, 1477,    2, 0x0a /* Public */,
     143,    1, 1482,    2, 0x2a /* Public | MethodCloned */,
     144,    1, 1485,    2, 0x0a /* Public */,
     146,    1, 1488,    2, 0x0a /* Public */,
     147,    1, 1491,    2, 0x0a /* Public */,
     148,    1, 1494,    2, 0x0a /* Public */,
     149,    1, 1497,    2, 0x0a /* Public */,
     151,    1, 1500,    2, 0x0a /* Public */,
     152,    2, 1503,    2, 0x0a /* Public */,
     152,    4, 1508,    2, 0x0a /* Public */,
     156,    2, 1517,    2, 0x0a /* Public */,
     151,    3, 1522,    2, 0x0a /* Public */,
     151,    2, 1529,    2, 0x2a /* Public | MethodCloned */,
     159,    3, 1534,    2, 0x0a /* Public */,
     160,    1, 1541,    2, 0x0a /* Public */,
     162,    1, 1544,    2, 0x0a /* Public */,
     163,    1, 1547,    2, 0x0a /* Public */,
     164,    1, 1550,    2, 0x0a /* Public */,
     165,    1, 1553,    2, 0x0a /* Public */,
     166,    2, 1556,    2, 0x0a /* Public */,
     168,    1, 1561,    2, 0x0a /* Public */,
     170,    1, 1564,    2, 0x0a /* Public */,
     172,    1, 1567,    2, 0x0a /* Public */,
     173,    1, 1570,    2, 0x0a /* Public */,
     175,    5, 1573,    2, 0x0a /* Public */,
     176,    1, 1584,    2, 0x0a /* Public */,
     177,    2, 1587,    2, 0x0a /* Public */,
     178,    3, 1592,    2, 0x0a /* Public */,
     179,    2, 1599,    2, 0x0a /* Public */,
     180,    1, 1604,    2, 0x0a /* Public */,
     181,    1, 1607,    2, 0x0a /* Public */,
     182,    4, 1610,    2, 0x0a /* Public */,
     183,    1, 1619,    2, 0x0a /* Public */,
     184,    1, 1622,    2, 0x0a /* Public */,
     186,    2, 1625,    2, 0x0a /* Public */,
     186,    1, 1630,    2, 0x2a /* Public | MethodCloned */,
     188,    3, 1633,    2, 0x0a /* Public */,
     189,    3, 1640,    2, 0x0a /* Public */,
     190,    1, 1647,    2, 0x0a /* Public */,
     191,    1, 1650,    2, 0x0a /* Public */,
     193,    1, 1653,    2, 0x0a /* Public */,
     194,    1, 1656,    2, 0x0a /* Public */,
     195,    2, 1659,    2, 0x0a /* Public */,
     195,    1, 1664,    2, 0x2a /* Public | MethodCloned */,
     198,    1, 1667,    2, 0x0a /* Public */,
     200,    1, 1670,    2, 0x0a /* Public */,
     201,    2, 1673,    2, 0x0a /* Public */,
     201,    1, 1678,    2, 0x2a /* Public | MethodCloned */,
     203,    1, 1681,    2, 0x0a /* Public */,
     205,    1, 1684,    2, 0x0a /* Public */,
     205,    6, 1687,    2, 0x0a /* Public */,
     209,    1, 1700,    2, 0x0a /* Public */,
     210,    1, 1703,    2, 0x0a /* Public */,
     211,    2, 1706,    2, 0x0a /* Public */,
     214,    2, 1711,    2, 0x0a /* Public */,
     215,    2, 1716,    2, 0x0a /* Public */,
     216,    2, 1721,    2, 0x0a /* Public */,
     217,    1, 1726,    2, 0x0a /* Public */,
     218,    5, 1729,    2, 0x0a /* Public */,
     219,    2, 1740,    2, 0x0a /* Public */,
     220,    2, 1745,    2, 0x0a /* Public */,
     221,    2, 1750,    2, 0x0a /* Public */,
     221,    1, 1755,    2, 0x2a /* Public | MethodCloned */,
     223,    1, 1758,    2, 0x0a /* Public */,
     224,    3, 1761,    2, 0x0a /* Public */,
     225,    2, 1768,    2, 0x0a /* Public */,
     228,    2, 1773,    2, 0x0a /* Public */,
     229,    1, 1778,    2, 0x0a /* Public */,
     231,    2, 1781,    2, 0x0a /* Public */,
     232,    1, 1786,    2, 0x0a /* Public */,
     233,    2, 1789,    2, 0x0a /* Public */,
     235,    2, 1794,    2, 0x0a /* Public */,
     235,    1, 1799,    2, 0x2a /* Public | MethodCloned */,
     237,    2, 1802,    2, 0x0a /* Public */,
     237,    1, 1807,    2, 0x2a /* Public | MethodCloned */,
     238,    2, 1810,    2, 0x0a /* Public */,
     239,    3, 1815,    2, 0x0a /* Public */,
     239,    2, 1822,    2, 0x2a /* Public | MethodCloned */,
     241,    2, 1827,    2, 0x0a /* Public */,
     242,    2, 1832,    2, 0x0a /* Public */,
     243,    2, 1837,    2, 0x0a /* Public */,
     245,    2, 1842,    2, 0x0a /* Public */,
     249,    2, 1847,    2, 0x0a /* Public */,
     250,    3, 1852,    2, 0x0a /* Public */,
     250,    2, 1859,    2, 0x2a /* Public | MethodCloned */,
     251,    3, 1864,    2, 0x0a /* Public */,
     251,    2, 1871,    2, 0x2a /* Public | MethodCloned */,
     252,    4, 1876,    2, 0x0a /* Public */,
     252,    3, 1885,    2, 0x2a /* Public | MethodCloned */,
     253,    2, 1892,    2, 0x0a /* Public */,
     254,    2, 1897,    2, 0x0a /* Public */,
     257,    1, 1902,    2, 0x0a /* Public */,
     259,    3, 1905,    2, 0x0a /* Public */,
     259,    2, 1912,    2, 0x2a /* Public | MethodCloned */,
     261,    3, 1917,    2, 0x0a /* Public */,
     261,    2, 1924,    2, 0x2a /* Public | MethodCloned */,
     262,    4, 1929,    2, 0x0a /* Public */,
     263,    4, 1938,    2, 0x0a /* Public */,
     264,    3, 1947,    2, 0x0a /* Public */,
     265,    3, 1954,    2, 0x0a /* Public */,
     266,    4, 1961,    2, 0x0a /* Public */,
     266,    3, 1970,    2, 0x2a /* Public | MethodCloned */,
     269,    3, 1977,    2, 0x0a /* Public */,
     270,    1, 1984,    2, 0x0a /* Public */,
     272,    1, 1987,    2, 0x0a /* Public */,
     273,    2, 1990,    2, 0x0a /* Public */,
     274,    5, 1995,    2, 0x0a /* Public */,
     274,    4, 2006,    2, 0x2a /* Public | MethodCloned */,
     278,    3, 2015,    2, 0x0a /* Public */,
     280,    4, 2022,    2, 0x0a /* Public */,
     280,    3, 2031,    2, 0x2a /* Public | MethodCloned */,
     281,    3, 2038,    2, 0x0a /* Public */,
     284,    2, 2045,    2, 0x0a /* Public */,
     285,    2, 2050,    2, 0x0a /* Public */,
     287,    2, 2055,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::QString,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,    9,   10,
    QMetaType::QJsonObject,
    QMetaType::QJsonObject, QMetaType::Int,   12,
    QMetaType::QByteArray,
    QMetaType::QByteArray, QMetaType::Int,   12,
    QMetaType::QString,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool, QMetaType::QJsonObject,   18,
    QMetaType::QJsonArray,
    QMetaType::QJsonArray, QMetaType::QJsonObject,   21,
    QMetaType::Bool, QMetaType::QJsonObject,   18,
    QMetaType::Bool, QMetaType::Int,   12,
    QMetaType::Bool, QMetaType::QString,   10,
    QMetaType::Bool, QMetaType::Int, QMetaType::QString,   26,   10,
    QMetaType::Int,
    QMetaType::QString, 0x80000000 | 29,   30,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,   32,   33,   34,
    QMetaType::QString, 0x80000000 | 29,   30,
    QMetaType::QJsonArray,
    QMetaType::QByteArray,
    QMetaType::QJsonObject, QMetaType::Int,   26,
    QMetaType::QByteArray, 0x80000000 | 29,   40,
    QMetaType::QJsonArray, 0x80000000 | 29,   40,
    0x80000000 | 29, QMetaType::Int,   12,
    QMetaType::Bool, QMetaType::QJsonObject,   44,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::QJsonObject,   47,
    0x80000000 | 29, 0x80000000 | 29, 0x80000000 | 29,   40,   49,
    0x80000000 | 29, 0x80000000 | 29, 0x80000000 | 29,   40,   51,
    0x80000000 | 53, 0x80000000 | 29,   49,
    0x80000000 | 53, 0x80000000 | 29,   55,
    QMetaType::QByteArray, 0x80000000 | 29,   40,
    QMetaType::QJsonArray, 0x80000000 | 29,   40,
    QMetaType::QJsonArray, 0x80000000 | 29,   49,
    QMetaType::QJsonArray, 0x80000000 | 29, 0x80000000 | 29,   40,   49,
    0x80000000 | 29, 0x80000000 | 29,   60,
    QMetaType::QJsonArray, QMetaType::Int,   62,
    QMetaType::QByteArray, 0x80000000 | 29,   49,
    QMetaType::Bool, QMetaType::QJsonObject,   65,
    QMetaType::Bool, QMetaType::Int,   67,
    QMetaType::Bool, QMetaType::QJsonObject,   65,
    QMetaType::QJsonObject, QMetaType::Int,   67,
    QMetaType::QJsonArray, QMetaType::Int,   62,
    QMetaType::Bool, QMetaType::Int,   72,
    QMetaType::Bool, QMetaType::QJsonObject,   74,
    QMetaType::Bool, QMetaType::QJsonObject,   74,
    QMetaType::QJsonObject, QMetaType::Int,   26,
    QMetaType::QByteArray, 0x80000000 | 29,   40,
    0x80000000 | 29, 0x80000000 | 29,   79,
    QMetaType::QJsonArray, 0x80000000 | 29,   40,
    QMetaType::QJsonArray, 0x80000000 | 29,   51,
    QMetaType::QJsonArray, 0x80000000 | 29, 0x80000000 | 29,   40,   51,
    QMetaType::QJsonArray, QMetaType::Int,   62,
    QMetaType::Bool, QMetaType::QJsonObject,   84,
    QMetaType::QJsonObject, QMetaType::Int,   86,
    QMetaType::Bool, QMetaType::QJsonObject,   84,
    QMetaType::Bool, QMetaType::Int,   86,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Bool,   90,   91,   92,   94,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::Bool, QMetaType::QJsonObject,   97,
    QMetaType::Bool, QMetaType::Int,   99,
    QMetaType::Bool, QMetaType::QJsonObject,   97,
    QMetaType::QJsonArray, QMetaType::Int,  102,
    QMetaType::Int, QMetaType::Int,  104,
    0x80000000 | 29, QMetaType::Int,  104,
    QMetaType::QString, QMetaType::Int,  104,
    0x80000000 | 108, QMetaType::Int,  104,
    QMetaType::QJsonArray, QMetaType::Int,  104,
    0x80000000 | 53, QMetaType::Int,  104,
    QMetaType::Bool, QMetaType::QJsonObject,  112,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, QMetaType::Int,  104,  102,  113,
    QMetaType::Bool, QMetaType::QJsonObject, QMetaType::Int,  115,  102,
    QMetaType::Bool, QMetaType::Int,  117,
    QMetaType::Bool, QMetaType::QJsonObject,  112,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  104,  119,
    QMetaType::Int, QMetaType::Int,  104,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   67,   79,   86,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,   67,   86,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   67,   79,   86,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,   67,   79,   86,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   67,   79,   86,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   67,   79,   86,  126,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    0x80000000 | 29, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::Bool, QMetaType::QJsonObject,  130,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  102,  132,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  102,  132,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::QJsonObject,  130,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  104,   90,   91,   92,
    QMetaType::QString, QMetaType::Int,  102,
    0x80000000 | 140, QMetaType::Int,  102,
    QMetaType::Double, QMetaType::Int,  102,
    QMetaType::QJsonArray, QMetaType::Int,   62,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Bool,   62,   94,
    QMetaType::QJsonArray, QMetaType::Int,   62,
    QMetaType::Bool, QMetaType::QJsonObject,  145,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::QJsonObject,  145,
    QMetaType::QJsonArray, QMetaType::QJsonObject,  145,
    QMetaType::QJsonObject, QMetaType::Int,  150,
    QMetaType::QJsonArray, QMetaType::Int,   62,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  153,   92,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  153,   92,  154,  155,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  153,   92,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  153,  157,  158,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  153,  157,
    0x80000000 | 29, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::Bool, QMetaType::QJsonObject,  161,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::QJsonObject,  161,
    QMetaType::QJsonArray, QMetaType::QJsonObject,  161,
    QMetaType::QJsonObject, QMetaType::Int,   26,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,   62,  167,
    QMetaType::QJsonObject, QMetaType::Int,  169,
    QMetaType::QJsonObject, QMetaType::Int,  171,
    QMetaType::QJsonObject, QMetaType::Int,  171,
    QMetaType::Bool, QMetaType::QJsonObject,  174,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,   90,   91,   92,  104,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Int, QMetaType::Int, QMetaType::Int,  169,  102,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,  169,  104,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  124,  104,
    QMetaType::Int, QMetaType::Int,  169,
    QMetaType::QJsonArray, QMetaType::Int,  169,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,  169,  102,  113,
    QMetaType::Bool, QMetaType::Int,  169,
    QMetaType::Bool, QMetaType::Int,  185,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Bool,  169,  187,
    QMetaType::QJsonArray, QMetaType::Int,  169,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    0x80000000 | 29, QMetaType::Int,  169,
    QMetaType::Bool, QMetaType::QJsonObject,  192,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::QJsonObject,  192,
    0x80000000 | 196, QMetaType::Int, 0x80000000 | 29,  102,  197,
    0x80000000 | 196, QMetaType::Int,  102,
    QMetaType::QJsonObject, QMetaType::Int,  199,
    QMetaType::QStringList, 0x80000000 | 29,   30,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  202,  104,
    QMetaType::QJsonArray, QMetaType::Int,  202,
    QMetaType::Float, QMetaType::Int,  204,
    QMetaType::Bool, QMetaType::QJsonObject,  192,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::QString, QMetaType::Double, QMetaType::Bool,  202,  102,  104,  206,  207,  208,
    QMetaType::Bool, QMetaType::Int,   26,
    QMetaType::Bool, QMetaType::QJsonObject,  192,
    0x80000000 | 29, 0x80000000 | 29, QMetaType::Bool,  212,  213,
    0x80000000 | 196, QMetaType::Int, QMetaType::Int,  104,  102,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  104,  102,
    0x80000000 | 29, QMetaType::Int, QMetaType::Int,  104,  102,
    0x80000000 | 29, QMetaType::Int,  202,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,  104,  204,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  104,  204,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  104,  204,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Bool,  104,  222,
    QMetaType::QJsonArray, QMetaType::Int,  104,
    0x80000000 | 29, QMetaType::Int,  104,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::Bool, QMetaType::Int, QMetaType::Double,  226,  227,
    QMetaType::Bool, QMetaType::Int, QMetaType::Double,  226,  227,
    QMetaType::Bool, QMetaType::Int,  230,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  204,  124,
    QMetaType::Bool, QMetaType::Int,  204,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  204,  234,
    QMetaType::Float, QMetaType::Int, QMetaType::Bool,  204,  236,
    QMetaType::Float, QMetaType::Int,  204,
    QMetaType::Float, QMetaType::Int, QMetaType::Bool,  226,  236,
    QMetaType::Float, QMetaType::Int,  226,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  204,  104,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  124,  102,  240,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  124,  102,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::Int,  124,  102,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  124,  102,
    0x80000000 | 196, QMetaType::Int, 0x80000000 | 29,  124,  244,
    0x80000000 | 246, 0x80000000 | 29, 0x80000000 | 29,  247,  248,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,  104,  202,
    QMetaType::QJsonObject, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  124,  102,  222,
    QMetaType::QJsonObject, QMetaType::Int, QMetaType::Int,  124,  102,
    QMetaType::QJsonObject, QMetaType::Int, QMetaType::Int, 0x80000000 | 29,  124,  102,  197,
    QMetaType::QJsonObject, QMetaType::Int, QMetaType::Int,  124,  102,
    QMetaType::Double, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  124,  102,  202,  234,
    QMetaType::Double, QMetaType::Int, QMetaType::Int, QMetaType::Int,  124,  102,  202,
    QMetaType::QJsonObject, QMetaType::Int, 0x80000000 | 29,  169,  197,
    QMetaType::QJsonObject, QMetaType::QJsonArray, QMetaType::Bool,  255,  256,
    0x80000000 | 258, QMetaType::Int,  169,
    QMetaType::Double, QMetaType::QJsonObject, QMetaType::QJsonArray, QMetaType::Bool,  130,  260,  256,
    QMetaType::Double, QMetaType::QJsonObject, QMetaType::QJsonArray,  130,  260,
    QMetaType::Double, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  124,  102,  256,
    QMetaType::Double, QMetaType::Int, QMetaType::Int,  124,  102,
    QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  124,  104,  102,  256,
    QMetaType::Double, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  124,  104,  102,  256,
    0x80000000 | 53, QMetaType::Int, QMetaType::Int, QMetaType::Int,   90,   91,   92,
    QMetaType::Double, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  102,  104,  256,
    0x80000000 | 267, QMetaType::Int, QMetaType::Int, QMetaType::Bool, QMetaType::Bool,  102,  104,  256,  268,
    0x80000000 | 267, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  102,  104,  256,
    0x80000000 | 267, QMetaType::Int, QMetaType::Int, QMetaType::Bool,  102,  104,  256,
    0x80000000 | 29, QMetaType::QJsonArray,  271,
    QMetaType::QJsonArray, 0x80000000 | 29,   30,
    QMetaType::QJsonObject, QMetaType::Int, QMetaType::Int,  104,  102,
    QMetaType::Bool, QMetaType::QString, QMetaType::Int, 0x80000000 | 29, QMetaType::QString, QMetaType::Bool,  275,  169,  197,  276,  277,
    QMetaType::Bool, QMetaType::QString, QMetaType::Int, 0x80000000 | 29, QMetaType::QString,  275,  169,  197,  276,
    QMetaType::QJsonArray, QMetaType::Int, QMetaType::QString, QMetaType::Double,  169,  276,  279,
    QMetaType::QJsonArray, QMetaType::QJsonObject, QMetaType::QString, QMetaType::Double, QMetaType::Bool,  130,  276,  279,  277,
    QMetaType::QJsonArray, QMetaType::QJsonObject, QMetaType::QString, QMetaType::Double,  130,  276,  279,
    QMetaType::QJsonArray, QMetaType::QJsonObject, QMetaType::Int, QMetaType::Double,  282,  283,  279,
    QMetaType::QJsonArray, QMetaType::QJsonObject, QMetaType::Double,  213,  279,
    QMetaType::QJsonArray, QMetaType::QJsonObject, QMetaType::Double,  286,  279,
    QMetaType::QJsonArray, QMetaType::QJsonArray, QMetaType::Double,  288,  279,

       0        // eod
};

void DbMan::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<DbMan *>(_o);
        (void)_t;
        switch (_id) {
        case 0: { bool _r = _t->isDbConnected();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 1: { QString _r = _t->getVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 2: { QString _r = _t->getAppVersion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->isOnMaintenance();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->newRelease();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { QString _r = _t->getLastError();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 6: { bool _r = _t->userAuthenticate((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 7: { QJsonObject _r = _t->getUser();
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 8: { QJsonObject _r = _t->getUser((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 9: { QByteArray _r = _t->getUserByteArray();
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 10: { QByteArray _r = _t->getUserByteArray((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 11: { QString _r = _t->getUserName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 12: { bool _r = _t->isUserAdmin();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 13: { bool _r = _t->isUserSuperAdmin();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 14: { bool _r = _t->insertUser((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 15: { QJsonArray _r = _t->getUsers();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 16: { QJsonArray _r = _t->filterUsers((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 17: { bool _r = _t->updateUser((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 18: { bool _r = _t->deleteUser((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 19: { bool _r = _t->verifyUserPassword((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 20: { bool _r = _t->changeUserPassword((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 21: { int _r = _t->getLastInsertedId();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 22: { QString _r = _t->getCommaSeparated((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 23: _t->insertLog((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 24: { QString _r = _t->listToString((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: { QJsonArray _r = _t->getBranches();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 26: { QByteArray _r = _t->getBranchesJson();
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 27: { QJsonObject _r = _t->getBranchJson((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 28: { QByteArray _r = _t->getBranchesJsonById((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 29: { QJsonArray _r = _t->getBranchesById((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 30: { QList<int> _r = _t->getUserBranch((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 31: { bool _r = _t->updateBranch((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 32: { bool _r = _t->deleteBranch((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 33: { bool _r = _t->insertBranch((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 34: { QList<int> _r = _t->filterSteps((*reinterpret_cast< QList<int>(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 35: { QList<int> _r = _t->filterStudyBases((*reinterpret_cast< QList<int>(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 36: { QMap<int,int> _r = _t->getStepBranchMap((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QMap<int,int>*>(_a[0]) = std::move(_r); }  break;
        case 37: { QMap<int,int> _r = _t->getStudyBaseBranchMap((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QMap<int,int>*>(_a[0]) = std::move(_r); }  break;
        case 38: { QByteArray _r = _t->getStepsByteArray((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 39: { QJsonArray _r = _t->getSteps((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 40: { QJsonArray _r = _t->getStepsById((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 41: { QJsonArray _r = _t->getStepsById((*reinterpret_cast< QList<int>(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 42: { QList<int> _r = _t->getStepsBranch((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 43: { QJsonArray _r = _t->getBranchStepsJson((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 44: { QByteArray _r = _t->getStepsJsonById((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 45: { bool _r = _t->insertStep((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 46: { bool _r = _t->deleteStep((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 47: { bool _r = _t->updateStep((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 48: { QJsonObject _r = _t->getStepJson((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 49: { QJsonArray _r = _t->getBranchStudyBases((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 50: { bool _r = _t->deleteStudyBase((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 51: { bool _r = _t->updateStudyBase((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 52: { bool _r = _t->insertStudyBase((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 53: { QJsonObject _r = _t->getStudyBase((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 54: { QByteArray _r = _t->getStudyBasesByteArray((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = std::move(_r); }  break;
        case 55: { QList<int> _r = _t->getStudyBaseBranch((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 56: { QJsonArray _r = _t->getStudyBases((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 57: { QJsonArray _r = _t->getStudyBasesById((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 58: { QJsonArray _r = _t->getStudyBasesById((*reinterpret_cast< QList<int>(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 59: { QJsonArray _r = _t->getBranchPeriods((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 60: { bool _r = _t->periodUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 61: { QJsonObject _r = _t->getPeriod((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 62: { bool _r = _t->periodInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 63: { bool _r = _t->periodDelete((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 64: { QJsonArray _r = _t->getClasses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 65: { QJsonArray _r = _t->getClassesBrief((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 66: { QJsonArray _r = _t->getClassesBrief((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 67: { int _r = _t->getClassMaxSortPriority((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 68: { bool _r = _t->classInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 69: { bool _r = _t->classDelete((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 70: { bool _r = _t->classUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 71: { QJsonArray _r = _t->getCourseClasses((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 72: { int _r = _t->getClassBranchId((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 73: { QList<int> _r = _t->getClassCourses((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 74: { QString _r = _t->getClassName((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 75: { QMap<int,QString> _r = _t->getClassStudentsName((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QMap<int,QString>*>(_a[0]) = std::move(_r); }  break;
        case 76: { QJsonArray _r = _t->getClassDetails((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 77: { QMap<int,int> _r = _t->getClassDetailMap((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QMap<int,int>*>(_a[0]) = std::move(_r); }  break;
        case 78: { bool _r = _t->classDetailInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 79: { bool _r = _t->classDetailInsert((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 80: { bool _r = _t->classDetailsInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 81: { bool _r = _t->classDetailDelete((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 82: { bool _r = _t->classDetailUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 83: { bool _r = _t->classDetailsInsert((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 84: { int _r = _t->getClassStudentsCount((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 85: { QJsonArray _r = _t->getBaseCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 86: { QJsonArray _r = _t->getStepCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 87: { QJsonArray _r = _t->getAllCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 88: { QJsonArray _r = _t->getAllCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 89: { QJsonArray _r = _t->getAllCoursesMinimised((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 90: { QJsonArray _r = _t->getAllCoursesMinimised((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 91: { QJsonArray _r = _t->getCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 92: { QList<int> _r = _t->getCourseIds((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 93: { bool _r = _t->courseInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 94: { bool _r = _t->sharedCourseCoefficientAppend((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 95: { bool _r = _t->sharedTestCoefficientAppend((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 96: { bool _r = _t->courseDelete((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 97: { bool _r = _t->isStepCourse((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 98: { bool _r = _t->courseUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 99: { QJsonArray _r = _t->getClassLeftCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 100: { QString _r = _t->getCourseName((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 101: { QMap<QString,QList<int> > _r = _t->getCourseSharedCoefficient((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QMap<QString,QList<int> >*>(_a[0]) = std::move(_r); }  break;
        case 102: { double _r = _t->getCourseFinalWeight((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 103: { QJsonArray _r = _t->getBranchTeachers((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 104: { QJsonArray _r = _t->getBranchTeachersBrief((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 105: { QJsonArray _r = _t->getBranchTeachersBrief((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 106: { bool _r = _t->teacherInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 107: { bool _r = _t->teacherDelete((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 108: { bool _r = _t->teacherUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 109: { QJsonArray _r = _t->filterTeachers((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 110: { QJsonObject _r = _t->getTeacher((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 111: { QJsonArray _r = _t->getBranchStudents((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 112: { QJsonArray _r = _t->getBranchPeriodStudents((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 113: { QJsonArray _r = _t->getBranchPeriodStudents((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 114: { int _r = _t->getBranchPeriodStudentsCount((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 115: { QJsonArray _r = _t->getBranchStudents((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 116: { QJsonArray _r = _t->getBranchStudents((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 117: { QList<int> _r = _t->getStudentsId((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 118: { bool _r = _t->studentInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 119: { bool _r = _t->studentDelete((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 120: { bool _r = _t->studentUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 121: { QJsonArray _r = _t->filterStudents((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 122: { QJsonObject _r = _t->getStudent((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 123: { QJsonArray _r = _t->getRegisterations((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 124: { QJsonObject _r = _t->getRegistration((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 125: { QJsonObject _r = _t->getRegisterInfo((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 126: { QJsonObject _r = _t->getRegisterDetailInfo((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 127: { bool _r = _t->registerStudent((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 128: { int _r = _t->getRegisterId((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])),(*reinterpret_cast< const int(*)>(_a[5])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 129: { bool _r = _t->registerDelete((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 130: { int _r = _t->getCourseTeacherId((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 131: { bool _r = _t->registerStudentCourseInsert((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 132: { bool _r = _t->registerStudentEvalInsert((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 133: { int _r = _t->getRegisterClassId((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 134: { QJsonArray _r = _t->getStudentCourses((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 135: { bool _r = _t->insertStudentCourse((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 136: { bool _r = _t->updateStudentBaseCourses((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 137: { bool _r = _t->deleteStudentCourse((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 138: { QJsonArray _r = _t->getStudentLeftCourses((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 139: { QJsonArray _r = _t->getStudentLeftCourses((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 140: { QJsonArray _r = _t->getEvalCats((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 141: { QJsonArray _r = _t->getEvalCatsBrief((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 142: { QList<int> _r = _t->getEvalCatsByRegisterId((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 143: { bool _r = _t->evalCatInsert((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 144: { bool _r = _t->evalCatDelete((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 145: { bool _r = _t->evalCatUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 146: { QMap<int,QJsonObject> _r = _t->getEvalCatsMap((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QMap<int,QJsonObject>*>(_a[0]) = std::move(_r); }  break;
        case 147: { QMap<int,QJsonObject> _r = _t->getEvalCatsMap((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QMap<int,QJsonObject>*>(_a[0]) = std::move(_r); }  break;
        case 148: { QJsonObject _r = _t->getEvalCat((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 149: { QStringList _r = _t->getEvalsCats((*reinterpret_cast< const QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = std::move(_r); }  break;
        case 150: { QJsonArray _r = _t->getCatEvals((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 151: { QJsonArray _r = _t->getCatEvals((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 152: { float _r = _t->getEvalMaxGrade((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 153: { bool _r = _t->evalInsert((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 154: { bool _r = _t->evalInsert((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const double(*)>(_a[5])),(*reinterpret_cast< const bool(*)>(_a[6])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 155: { bool _r = _t->evalDelete((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 156: { bool _r = _t->evalUpdate((*reinterpret_cast< QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 157: { QList<int> _r = _t->coursesHasEval((*reinterpret_cast< QList<int>(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 158: { QMap<int,QJsonObject> _r = _t->getEvalMap((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QMap<int,QJsonObject>*>(_a[0]) = std::move(_r); }  break;
        case 159: { QJsonArray _r = _t->getEvalArray((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 160: { QList<int> _r = _t->getEvalIdList((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 161: { QList<int> _r = _t->getEvalCatEvalIds((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 162: { bool _r = _t->updateEvalStudents((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])),(*reinterpret_cast< const int(*)>(_a[5])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 163: { QJsonArray _r = _t->getClassStudentsEval((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 164: { QJsonArray _r = _t->getClassLeftStudents((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 165: { QJsonArray _r = _t->getClassStudents((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 166: { QJsonArray _r = _t->getClassStudents((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 167: { QList<int> _r = _t->getClassStudentsId((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 168: { QJsonArray _r = _t->getStudents((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 169: { bool _r = _t->setStudentEvalGrade((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const double(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 170: { bool _r = _t->setStudentEvalNormalisedGrade((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const double(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 171: { bool _r = _t->deleteStudentEval((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 172: { bool _r = _t->insertStudentEval((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 173: { bool _r = _t->studentEvalDenormalise((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 174: { bool _r = _t->studentEvalNormalise((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 175: { float _r = _t->getMaxStudentEval((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 176: { float _r = _t->getMaxStudentEval((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 177: { float _r = _t->getStudentEvalGrade((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 178: { float _r = _t->getStudentEvalGrade((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 179: { bool _r = _t->StudentEvalEvaluationInsert((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 180: { QJsonArray _r = _t->getStudentCourseEvals((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 181: { QJsonArray _r = _t->getStudentCourseEvals((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 182: { QJsonArray _r = _t->getCategorisedEvals((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 183: { bool _r = _t->updateStudentCourseEvals((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 184: { QMap<int,QJsonObject> _r = _t->getStudentEvalsMap((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QMap<int,QJsonObject>*>(_a[0]) = std::move(_r); }  break;
        case 185: { QMap<int,QMap<int,QJsonObject> > _r = _t->getStudentsEvalsMap((*reinterpret_cast< const QList<int>(*)>(_a[1])),(*reinterpret_cast< const QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QMap<int,QMap<int,QJsonObject> >*>(_a[0]) = std::move(_r); }  break;
        case 186: { bool _r = _t->refreshEvaluationsStudents((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 187: { QJsonObject _r = _t->getStudentCourseStat((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 188: { QJsonObject _r = _t->getStudentCourseStat((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 189: { QJsonObject _r = _t->getStudentCourseStatArray((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< QList<int>(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 190: { QJsonObject _r = _t->getStudentCourseStatArray((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 191: { double _r = _t->getStudentCourseAvg((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 192: { double _r = _t->getStudentCourseAvg((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 193: { QJsonObject _r = _t->getStudentStat((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 194: { QJsonObject _r = _t->getStudentInfoStat((*reinterpret_cast< const QJsonArray(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 195: { QList<QJsonObject> _r = _t->getStudentCoursesList((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<QJsonObject>*>(_a[0]) = std::move(_r); }  break;
        case 196: { double _r = _t->getSemesterAvg((*reinterpret_cast< const QJsonObject(*)>(_a[1])),(*reinterpret_cast< const QJsonArray(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 197: { double _r = _t->getSemesterAvg((*reinterpret_cast< const QJsonObject(*)>(_a[1])),(*reinterpret_cast< const QJsonArray(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 198: { double _r = _t->getStudentCourseSemester((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 199: { double _r = _t->getStudentCourseSemester((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 200: { int _r = _t->getStudentCourseRank((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 201: { double _r = _t->getStudentFinalGrade((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 202: { QMap<int,int> _r = _t->getStudents_Classes((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QMap<int,int>*>(_a[0]) = std::move(_r); }  break;
        case 203: { double _r = _t->getCourseAvg((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 204: { QList<double> _r = _t->getStudentsCourseRef((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])),(*reinterpret_cast< const bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QList<double>*>(_a[0]) = std::move(_r); }  break;
        case 205: { QList<double> _r = _t->getStudentsCourseRef((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QList<double>*>(_a[0]) = std::move(_r); }  break;
        case 206: { QList<double> _r = _t->getStudentsCourseFinal((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const bool(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QList<double>*>(_a[0]) = std::move(_r); }  break;
        case 207: { QList<int> _r = _t->jsonArrayToList((*reinterpret_cast< QJsonArray(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<int>*>(_a[0]) = std::move(_r); }  break;
        case 208: { QJsonArray _r = _t->listToJsonArray((*reinterpret_cast< QList<int>(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 209: { QJsonObject _r = _t->getClassCourseStudentsEvals((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 210: { bool _r = _t->exportStudentStatPdf((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< QList<int>(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const bool(*)>(_a[5])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 211: { bool _r = _t->exportStudentStatPdf((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< QList<int>(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 212: { QJsonArray _r = _t->getStudentStatHeaderTable((*reinterpret_cast< const int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const double(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 213: { QJsonArray _r = _t->getStudentStatCourseTable((*reinterpret_cast< QJsonObject(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const double(*)>(_a[3])),(*reinterpret_cast< const bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 214: { QJsonArray _r = _t->getStudentStatCourseTable((*reinterpret_cast< QJsonObject(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const double(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 215: { QJsonArray _r = _t->getStudentStatCourseTotalTable((*reinterpret_cast< QJsonObject(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const double(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 216: { QJsonArray _r = _t->getStudentStatTestTable((*reinterpret_cast< QJsonObject(*)>(_a[1])),(*reinterpret_cast< const double(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 217: { QJsonArray _r = _t->getStudentStatTestTotalTable((*reinterpret_cast< QJsonObject(*)>(_a[1])),(*reinterpret_cast< const double(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 218: { QJsonArray _r = _t->getStudentStatSharedCoefficientString((*reinterpret_cast< QJsonArray(*)>(_a[1])),(*reinterpret_cast< const double(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 22:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 24:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 28:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 29:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 34:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 35:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 36:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 37:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 38:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 39:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 40:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 41:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 42:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 44:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 54:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 55:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 56:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 57:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 58:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 146:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 149:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 157:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 184:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 185:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 189:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 193:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 208:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 210:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        case 211:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<int> >(); break;
            }
            break;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject DbMan::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_DbMan.data,
    qt_meta_data_DbMan,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *DbMan::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *DbMan::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_DbMan.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int DbMan::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 219)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 219;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 219)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 219;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
