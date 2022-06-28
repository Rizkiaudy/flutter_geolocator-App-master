import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geolocator_app/models/user_model.dart';
import 'package:flutter_geolocator_app/service/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user = await ApiService().login(email, password);
      if (user.status == "success") {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailed(user.errors.toString()));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
