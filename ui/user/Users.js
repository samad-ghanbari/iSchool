
function loadUsers(){
    filterModel.clear();

    var cond = {};

    var name = nameTF.text;
    var lastname = lastnameTF.text;
    var gender = genderCB.currentText;
    var nat_id = natIdTF.text;
    var jobPosition = jobPositionTF.text;
    var telephone = telephone.text;
    var enabled = enabledSW.checked;
    var admin = adminCB.currentValue; // -1  0  1
    var superadmin = superadminCB.currentValue;


    if(name !== ""){
        cond["name"] = name;
        filterModel.append({_key: "نام", _value: name, _type: "name"})
    }
    if(lastname !== ""){
        cond["lastname"] = lastname;
        filterModel.append({_key: "نام‌خانوادگی", _value: lastname, _type: "lastname"})
    }
    if(gender !== ""){
        cond["gender"] = gender;
        filterModel.append({_key: "جنسیت", _value: gender, _type: "gender"})
    }
    if(nat_id !== ""){
        cond["nat_id"] = nat_id;
        filterModel.append({_key: "کدملی", _value: nat_id, _type: "nat_id"})
    }
    if(jobPosition !== ""){
        cond["job_position"] = jobPosition;
        filterModel.append({_key: "سمت شغلی", _value: jobPosition, _type: "job_position"})
    }
    if(telephone !== ""){
        cond["telephone"] = telephone;
        filterModel.append({_key: "شماره تماس", _value: telephone, _type: "telephone"})
    }

    cond["enabled"] = enabled;
    var stat = (enabnled)? "فعال" : "غیرفعال";
    filterModel.append({_key: "وضعیت کاربر", _value: stat, _type: "enabled"})

    if(admin  > -1){
        cond["admin"] = admin;
        filterModel.append({_key: "سطح دسترسی", _value: "کاربر ادمین", _type: "admin"})
    }
    if(superadmin  > -1){
        cond["admin"] = admin;
        filterModel.append({_key: "سطح دسترسی", _value: "کاربر سوپرادمین", _type: "superadmin"})
    }

    usersModel.clear();
    usersPage.offset = 0;
    usersPage.pageNumber = 1
    // cond : base_id period_id class_id name lastname
    usersPage.usersCount = dbMan.getUsersCount(cond);
    usersCountLbl.text = usersPage.usersCount + " نفر "
    var jsondata = dbMan.getUsers( cond, usersPage.limit, usersPage.offset);

    for(var obj of jsondata){
        usersModel.append(obj);
    }

    searchDrawer.close();
}

