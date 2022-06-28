import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geolocator_app/models/absen_model.dart';
import 'package:flutter_geolocator_app/service/api_service.dart';

part 'absen_state.dart';

class AbsenCubit extends Cubit<AbsenState> {
  AbsenCubit() : super(AbsenInitial());

  void absensi({required String username}) async {
    try {
      emit(AbsenLoading());
      AbsenModel absen = await ApiService().absen(username);
      if (absen.status == "success") {
        emit(AbsenSuccess(absen));
      } else {
        emit(AbsenFailed(absen.errors.toString()));
      }
    } catch (e) {
      emit(AbsenFailed(e.toString()));
    }
  }

  void dataAbsen({required String username}) async {
    try {
      emit(AbsenLoading());
      AbsenModel dataAbsen = await ApiService().ambilAbsen(username);
      if (dataAbsen.status == "success") {
        emit(AbsenSuccess(dataAbsen));
      } else {
        emit(AbsenFailed(dataAbsen.errors.toString()));
      }
    } catch (e) {
      emit(AbsenFailed(e.toString()));
    }
  }
}
