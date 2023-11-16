import 'package:skripsi_warehouse/main.dart';

class WarehouseServices {
  static Stream<List<Map<String, dynamic>>> getStream(String tblName) {
    return supabase
        .from(tblName)
        .stream(primaryKey: ['id']).order('created_at', ascending: true);
  }

  static Stream<List<Map<String, dynamic>>> getStreamById(
      {required String tblName, required int id, required String column}) {
    return supabase
        .from(tblName)
        .stream(primaryKey: ['id'])
        .eq(column, id)
        .order('created_at', ascending: true);
  }

  static Future<Map<String, dynamic>> getLastDataLocationByForeignKey(
      {required String tblName,
      required int idForeign,
      required String columnForeign}) async {
    final result = await supabase
        .from(tblName)
        .select('*')
        .eq(columnForeign, idForeign)
        .order('created_at', ascending: false)
        .limit(1)
        .single();

    return result;
  }

  static Future addHistoryTransaction(
      {required int partId,
      required int locationId,
      required int quantity,
      required int stock,
      required String description,
      required String userId}) async {
    Map dataUpload = {
      "part_id": partId,
      "location_id": locationId,
      "quantity": quantity,
      "stock": stock,
      "description": description,
      "user_id": userId
    };
    await supabase.from('history').insert(dataUpload);
  }
}
