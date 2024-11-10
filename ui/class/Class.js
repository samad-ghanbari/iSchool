function updateBranchCB()
{
    branchCBoxModel.clear();
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

function classUpdate(branchId)
{
    classModel.clear();
    var jsondata = dbMan.getBranchClasses(branchId);
    // c.id, c.branch_id, c.class_name, c.class_desc, c.sort_priority, b.city, b.branch_name
    for(var obj of jsondata)
    {
        classModel.append({Id: obj.id, BranchId: obj.branch_id, ClassName: obj.class_name, ClassDesc: obj.class_desc, SortPriority: obj.sort_priority, City: obj.city, BranchName: obj.branch_name  })
    }
}
