import 'package:get/get.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/location_part_view.dart';

class LocationPartController extends GetxController {
  LocationPartView? view;

  Stream<List<Map<String, dynamic>>> getHeadLocation() {
    return supabase
        .from('head_location')
        .stream(primaryKey: ['id']).order('created_at', ascending: true);
  }
}
