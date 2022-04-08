import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';

class ProvinceProvider {
  static const String TABLE_PROVINCES = "provinces";

  static Future<List<ProvinceDao>> all({int? limit}) async {
    List<Map<String, dynamic>> mapResult =
        await ThailandProvincesDatabase.db!.query(TABLE_PROVINCES, limit: limit);

    List<ProvinceDao> listProvinces = mapProvinceList(mapResult);

    return listProvinces;
  }

  static List<ProvinceDao> mapProvinceList(
      List<Map<String, dynamic>> mapResult) {
    List<ProvinceDao> listProvinces = [];
    for (Map mapRow in mapResult) {
      listProvinces.add(ProvinceDao.fromJson(mapRow as Map<String, dynamic>));
    }
    return listProvinces;
  }

  static Future<List<ProvinceDao>> search({String keyword = "", int? limit}) async {
    List<Map<String, dynamic>> mapResult = await ThailandProvincesDatabase.db!
        .query(TABLE_PROVINCES,
            where: "name_th LIKE ? OR name_en LIKE ?",
            whereArgs: ["%$keyword%", "%$keyword%"],
            limit: limit);

    List<ProvinceDao> listProvinces = mapProvinceList(mapResult);

    return listProvinces;
  }
}
