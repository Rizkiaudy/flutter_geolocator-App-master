part of 'riwayat_absen_cubit.dart';

abstract class RiwayatAbsenState extends Equatable {
  const RiwayatAbsenState();

  @override
  List<Object> get props => [];
}

class RiwayatAbsenInitial extends RiwayatAbsenState {}

class RiwayatAbsen extends RiwayatAbsenState {
  final int hadir;
  final int terlambat;
  final Content? content;
  RiwayatAbsen(this.hadir, this.terlambat, this.content);

  @override
  List<Object> get props => [hadir, terlambat, content!];
}
