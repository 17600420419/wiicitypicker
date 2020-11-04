
import 'package:shared_preferences/shared_preferences.dart';
///地址信息管理
class CityDataManager {

    static CityDataManager _shared;

    static CityDataManager get shared => _getSharedManager();


    static CityDataManager _getSharedManager() {
      if (_shared == null) {
        _shared = CityDataManager();
      }
      return _shared;
    }

    void saveCitys(String citys) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("citys", citys);
    }

    Future<String> getCitys() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("citys");
    }

}