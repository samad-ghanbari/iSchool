
function loadStudents(){
    filterModel.clear();

    var cond = {};
    var base_id = filter_baseCB.currentValue;
    var period_id = filter_periodCB.currentValue;
    var class_id = filter_classCB.currentValue;
    var name = nameTF.text;
    var lastname = lastnameTF.text;

    if(base_id > -1){
        cond["base_id"] = base_id;
        filterModel.append({_key: "پایه‌تحصیلی", _value: filter_baseCB.currentText, _type: "base"})
    }
    if(period_id > -1){
        cond["period_id"] = period_id;
        filterModel.append({_key: "سال‌تحصیلی", _value: filter_periodCB.currentText, _type: "period"})
    }
    if(class_id > -1){
        cond["class_id"] = class_id;
        filterModel.append({_key: "کلاس", _value: filter_classCB.currentText , _type: "class"})
    }
    if(name !== ""){
        cond["name"] = name;
        filterModel.append({_key: "نام", _value: name, _type: "name"})
    }
    if(lastname !== ""){
        cond["lastname"] = lastname;
        filterModel.append({_key: "نام‌خانوادگی", _value: lastname, _type: "lastname"})
    }

    studentModel.clear();
    studentsPage.offset = 0;
    studentsPage.pageNumber = 1
    // cond : base_id period_id class_id name lastname
    studentsPage.studentsCount = dbMan.getStudentsCount(stepCB.currentValue, cond);
    studentCountLbl.text = studentsPage.studentsCount + " نفر "
    var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);

    for(var obj of jsondata){
        studentModel.append(obj);
    }

    studentSearchDrawer.close();
}

