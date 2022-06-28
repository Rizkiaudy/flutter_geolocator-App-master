part of 'absen_cubit.dart';

abstract class AbsenState extends Equatable {
  const AbsenState();

  @override
  List<Object> get props => [];
}

class AbsenInitial extends AbsenState {}

class AbsenLoading extends AbsenState {}

class AbsenSuccess extends AbsenState {
  final AbsenModel absen;

  AbsenSuccess(this.absen);

  @override
  List<Object> get props => [absen];
}

class AbsenFailed extends AbsenState {
  final String error;
  AbsenFailed(this.error);

  @override
  List<Object> get props => [error];
}
