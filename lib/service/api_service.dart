import 'dart:convert';

import 'package:flutter_geolocator_app/models/absen_model.dart';
import 'package:flutter_geolocator_app/models/cuti_model.dart';
import 'package:flutter_geolocator_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // String endpoint = "https://90bd-36-85-7-25.ap.ngrok.io/api/";
   String endpoint = "https://simpegdummy.uniba-bpn.ac.id/api/";

  Future<UserModel> login(String username, String password) async {
    try {
      var url = Uri.parse(endpoint + 'login');
      var response = await http
          .post(url, body: {'username': username, 'password': password});
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      print(parsed);
      UserModel user = UserModel.fromJson(parsed);
      return user;
    } catch (e) {
      throw (e);
    }
  }

  Future<AbsenModel> absen(String username) async {
    try {
      var url = Uri.parse(endpoint + 'absen');
      var response = await http.post(url, body: {'username': username});
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      AbsenModel absen = AbsenModel.fromJson(parsed);
      return absen;
    } catch (e) {
      throw (e);
    }
  }

  Future<AbsenModel> ambilAbsen(String username) async {
    try {
      var url = Uri.parse(endpoint + 'data-absen');
      var response = await http.post(url, body: {'username': username});
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      print(parsed);
      AbsenModel dataAbsen = AbsenModel.fromJson(parsed);
      return dataAbsen;
    } catch (e) {
      throw (e);
    }
  }

  Future<CutiModel> izin(String username, String nama, String status, String keterangan, String tanggal) async {
    try {
      var url = Uri.parse(endpoint + 'sip-izin');
      var response = await http.post(url, body: {
        'username' : username,
        'nama' : nama,
        'NIP' : username,
        'status' : status,
        'keterangan' : keterangan,
        'tanggal' : tanggal
      });
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      CutiModel dataCuti = CutiModel.fromJson(parsed);
      return dataCuti;
    } catch (e) {
      throw(e);
    }
  }

  Future<CutiModel> cuti(UserModel user, String keterangan, String tanggalMulai, String tanggalAkhir) async {
    try {
      var url = Uri.parse(endpoint + 'sip-cuti');
      var response = await http.post(url, body: {
        'username' : user.content!.user,
        'nama' : user.content!.name,
        'NIP' : user.content!.user,
        'keterangan' : keterangan,
        'tanggal_mulai_cuti' : tanggalMulai,
        'tanggal_akhir_cuti' : tanggalAkhir,
      });
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      CutiModel dataCuti = CutiModel.fromJson(parsed);
      return dataCuti;
    } catch (e) {
      throw(e);
    }
  }
}
