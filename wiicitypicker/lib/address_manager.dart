import 'dart:convert';
import 'package:flutter/material.dart';

import 'city_model.dart';
import 'citys_date.dart';

///地址信息管理
abstract class AddressManager {

  static List<Province> _provinces;
  static Map<String, Province> _provinceMap = Map<String, Province>();
  static Map<String, City> _cityMap = Map<String, City>();
  static Map<String, District> _districtMap = Map<String, District>();
  static Map<String, Street> _streetMap = Map<String, Street>();
  
  static Future<List<Province>> loadAddressData (
      BuildContext context) async {

    if (_provinces != null && _provinces.isNotEmpty) {
      return _provinces;
    }

    var address = await CityDataManager.shared.getCitys();
    var data = json.decode(address);
      var provinces = new List<Province>();
      if (json != null && data is List) {
        data.forEach((v) {
          var province = Province.fromJson(v, cityMap: _cityMap, districtMap: _districtMap,streetMap: _streetMap);
          _provinceMap[province.code] = province;
          provinces.add(province);
        });
        _provinces = provinces;
        return _provinces;
      }
      return List<Province>();
  }

  static Future<Province> getProvince(BuildContext context, String provinceId) async {
    if (_provinceMap.isEmpty) {
      var provinces = await loadAddressData(context);
      if (provinces.isNotEmpty) {
        return _provinceMap[provinceId];
      }
      return null;
    } else {
      return _provinceMap[provinceId];
    }
  }

  static Future<City> getCity(BuildContext context, String cityId) async {
    if (_cityMap.isEmpty) {
      var provinces = await loadAddressData(context);
      if (provinces.isNotEmpty) {
        return _cityMap[cityId];
      }
      return null;
    } else {
      return _cityMap[cityId];
    }
  }

  static Future<District> getDistrict(BuildContext context, String districtId) async {
    if (_districtMap.isEmpty) {
      var provinces = await loadAddressData(context);
      if (provinces.isNotEmpty) {
        return _districtMap[districtId];
      }
      return null;
    } else {
      return _districtMap[districtId];
    }
  }

  static Future<Street> getStreet(BuildContext context, String streetId) async {
    if (_streetMap.isEmpty) {
      var provinces = await loadAddressData(context);
      if (provinces.isNotEmpty) {
        return _streetMap[streetId];
      }
      return null;
    } else {
      return _streetMap[streetId];
    }
  }
}
