part of 'cuti_cubit.dart';

abstract class CutiState extends Equatable {
  const CutiState();

  @override
  List<Object> get props => [];
}

class CutiInitial extends CutiState {}

class CutiLoading extends CutiState {}

class CutiSuccess extends CutiState {
  final CutiModel cuti;

  CutiSuccess(this.cuti);

  @override
  List<Object> get props => [cuti];
}

class CutiFailed extends CutiState {
  final String error;

  CutiFailed(this.error);

  @override
  List<Object> get props => [error];
}
