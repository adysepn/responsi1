import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';

import 'package:tokokita/model/tugas.dart';

class TugasBloc {
  static Future<List<Tugas>> getTugass() async {
    String apiUrl = ApiUrl.listTugas;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);

    List<dynamic> listTugas = (jsonObj as Map<String, dynamic>)['data'];

    List<Tugas> tugass = [];
    for (int i = 0; i < listTugas.length; i++) {
      tugass.add(Tugas.fromJson(listTugas[i]));
    }
    return tugass;
  }

  static Future addTugas({Tugas? tugas}) async {
    String apiUrl = ApiUrl.createTugas;

    var body = {
      "title_tugas": tugas!.titleTugas,
      "deskripsi_tugas": tugas.deskTugas,
      "deadline": tugas.deadlineTugas.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);

    return jsonObj['status'];
  }

  static Future<bool> updateTugas({required Tugas tugas}) async {
    String apiUrl = ApiUrl.updateTugas(tugas.id!);

    var body = {
      "title_tugas": tugas.titleTugas,
      "deskripsi_tugas": tugas.deskTugas,
      "deadline": tugas.deadlineTugas.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    // print("json : $jsonObj");
    return jsonObj['status'];
  }

  static Future<bool> deleteTugas({int? id}) async {
    String apiUrl = ApiUrl.deleteTugas(id!);

    var response = await Api().delete(apiUrl);

    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
