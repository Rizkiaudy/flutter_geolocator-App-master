import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geolocator_app/models/cuti_model.dart';
import 'package:flutter_geolocator_app/models/user_model.dart';
import 'package:flutter_geolocator_app/service/api_service.dart';

part 'cuti_state.dart';

class CutiCubit extends Cubit<CutiState> {
  CutiCubit() : super(CutiInitial());

  void izin({required String username, required String nama, required String status, required String keterangan, required String tanggal}) async {
    try {
      emit(CutiLoading());
      CutiModel cuti = await ApiService().izin(username, nama, status, keterangan, tanggal);
      if(cuti.status == "success"){
        emit(CutiSuccess(cuti));
      } else{
        emit(CutiFailed(cuti.errors.toString()));
      }
    } catch (e) {
      emit(CutiFailed(e.toString()));
    }
  }

  void cuti({required UserModel user, required String keterangan, required String tanggalMulai, required String tanggalAkhir}) async{
    try {
      emit(CutiLoading());
      CutiModel cuti = await ApiService().cuti(user, keterangan, tanggalMulai, tanggalAkhir);
      if(cuti.status == "success"){
        emit(CutiSuccess(cuti));
      } else{
        emit(CutiFailed(cuti.errors.toString()));
      }
    } catch (e) {
      emit(CutiFailed(e.toString()));
    }
  }
}
