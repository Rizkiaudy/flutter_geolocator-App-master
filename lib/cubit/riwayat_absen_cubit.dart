import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geolocator_app/models/absen_model.dart';

part 'riwayat_absen_state.dart';

class RiwayatAbsenCubit extends Cubit<RiwayatAbsenState> {
  RiwayatAbsenCubit() : super(RiwayatAbsenInitial());

  void hitungAbsen(List<Content> content) {
    int hadir = 0;
    int terlambat = 0;
    for (int i = 0; i < content.length; i++) {
      if (content[i].terlambat == false) {
        hadir++;
        emit(RiwayatAbsen(hadir, terlambat, content[i]));
      } else {
        terlambat++;
        emit(RiwayatAbsen(hadir, terlambat, content[i]));
      }
    }
  }
}
