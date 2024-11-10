function updateBranchCB()
{
    branchCBoxModel.clear();
    teacherModel.clear();
    var jsondata = dbMan.getBranches();
    //id, city, branch_name, address
    var temp;
    for(var obj of jsondata)
    {
        temp = obj.city + " - "+ obj.branch_name;
        branchCBoxModel.append({value: obj.id,  text: temp })
    }
}

function teachersUpdate(branchId)
{
    teacherModel.clear();
    var jsondata = dbMan.getBranchTeachers(branchId);
    // t.id, t.branch_id, t.name, t.lastname, t.gender, t.study_degree, t.study_field, t.telephone, t.enabled, b.city, b.branch_name
    for(var obj of jsondata)
    {
        teacherModel.append({
                                Id: obj.id,
                                BranchId: obj.branch_id,
                                Name: obj.name,
                                LastName: obj.lastname,
                                Gender: obj.gender,
                                StudyDegree: obj.study_degree,
                                StudyField: obj.study_field,
                                Telephone: obj.telephone,
                                Enabled: obj.enabled,
                                City: obj.city,
                                BranchName: obj.branch_name
                            });
    }
}

function filterTeachers(teacher)
{
    teacherModel.clear();
    var jsondata = dbMan.filterTeachers(teacher);
    //t.id, t.branch_id, t.name, t.lastname, t.gender, t.study_degree, t.study_field, t.telephone, t.enabled, b.city, b.branch_name
    for(var obj of jsondata)
    {
        teacherModel.append({
                                Id: obj.id,
                                BranchId: obj.branch_id,
                                Name: obj.name,
                                LastName: obj.lastname,
                                Gender: obj.gender,
                                StudyDegree: obj.study_degree,
                                StudyField: obj.study_field,
                                Telephone: obj.telephone,
                                Enabled: obj.enabled,
                                City: obj.city,
                                BranchName: obj.branch_name
                            });
    }
}
