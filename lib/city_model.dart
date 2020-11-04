//省
class Province {
  String code;
  String name;
  String pinyin;
  List<City> areas;

  Province({this.code, this.name, this.pinyin, this.areas});

  Province.fromJson(Map<String, dynamic> json,
      {Map<String, City> cityMap,
      Map<String, District> districtMap,Map<String, Street> streetMap}) {
    code = json['code'];
    name = json['name'];
    pinyin = json['pinyin'];
    if (json['areas'] != null) {
      areas = new List<City>();
      json['areas'].forEach((v) {
        var city = City.fromJson(v, districtMap: districtMap,streetMap: streetMap);
        cityMap[city.code] = city;
        areas.add(city);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['pinyin'] = this.pinyin;
    if (this.areas != null) {
      data['areas'] = this.areas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//市
class City {
  String code;
  String name;
  String pinyin;
  List<District> areas;

  City({this.code, this.name, this.pinyin, this.areas});

  City.fromJson(Map<String, dynamic> json,{Map<String, District> districtMap,Map<String, Street> streetMap}) {
    code = json['code'];
    name = json['name'];
    pinyin = json['pinyin'];
    if (json['areas'] != null) {
      areas = new List<District>();
      json['areas'].forEach((v) {
        var city = District.fromJson(v,streetMap: streetMap);
        districtMap[city.code] = city;
        areas.add(city);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['pinyin'] = this.pinyin;
    if (this.areas != null) {
      data['areas'] = this.areas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//区
class District {
  String code;
  String name;
  String pinyin;
  List<Street> areas;

  District({this.code, this.name, this.pinyin, this.areas});

  District.fromJson(Map<String, dynamic> json,
      {Map<String, Street> streetMap}) {
    code = json['code'];
    name = json['name'];
    pinyin = json['pinyin'];
    if (json['areas'] != null) {
      areas = new List<Street>();
      json['areas'].forEach((v) {
        var street = Street.fromJson(v);
        streetMap[code] = street;
        areas.add(street);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['pinyin'] = this.pinyin;
    if (this.areas != null) {
      data['areas'] = this.areas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//街道
class Street {
  String code;
  String name;
  String pinyin;

  Street({this.code, this.name, this.pinyin});

  Street.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    pinyin = json['pinyin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['pinyin'] = this.pinyin;
    return data;
  }
}
