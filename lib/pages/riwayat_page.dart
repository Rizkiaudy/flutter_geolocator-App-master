import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/cubit/absen_cubit.dart';
import 'package:flutter_geolocator_app/cubit/riwayat_absen_cubit.dart';
import 'package:flutter_geolocator_app/widgets/column_builder.dart';
import 'package:flutter_geolocator_app/widgets/custom_card_absen.dart';
import 'package:flutter_geolocator_app/widgets/custom_tanggal_absen.dart';
import 'package:intl/intl.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  void initState() {
    context.read<AbsenCubit>().dataAbsen(username: "017005376");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int hadir = 0, tidakHadir = 0, terlambat = 0;
    Widget cardSection() {
      return Container(
        margin: EdgeInsets.only(top: 31, bottom: defaultMargin),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCardAbsen(
              title: "Hadir",
              textStyle: greenTextStyle,
              jumlah: hadir,
            ),
            CustomCardAbsen(
              title: "Tidak Hadir",
              textStyle: orangeTextStyle,
              jumlah: tidakHadir,
            ),
            CustomCardAbsen(
              title: "Terlambat",
              textStyle: redTextStyle,
              jumlah: terlambat,
            ),
          ],
        ),
      );
    }

    return BlocBuilder<AbsenCubit, AbsenState>(
      builder: (context, state) {
        if (state is AbsenLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AbsenSuccess) {
          context.read<RiwayatAbsenCubit>().hitungAbsen(state.absen.content!);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Riwayat Absensi",
                style: titleTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              iconTheme: IconThemeData(color: kTitleColor),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
            ),
            body: BlocBuilder<RiwayatAbsenCubit, RiwayatAbsenState>(
              builder: (context, state) {
                if (state is RiwayatAbsen) {
                  hadir = state.hadir;
                  terlambat = state.terlambat;
                }
                return SafeArea(
                  child: ListView(
                    children: [
                      cardSection(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: Column(
                          children: [
                            BlocBuilder<AbsenCubit, AbsenState>(
                              builder: (context, state) {
                                if (state is AbsenSuccess) {
                                  return ColumnBuilder(
                                      itemBuilder: ((context, index) {
                                        String tanggal = DateFormat(
                                                "EEEE, d MMMM yyyy", "id_ID")
                                            .format(state.absen.content![index]
                                                .tanggal!);
                                        return CustomTanggalAbsen(
                                          tanggal:
                                              "$tanggal (${state.absen.content![index].jamDatang!})",
                                          isTerlambat: state
                                                      .absen
                                                      .content?[index]
                                                      .terlambat! ==
                                                  "true"
                                              ? true
                                              : false,
                                        );
                                      }),
                                      itemCount: state.absen.content!.length);
                                }
                                return CustomTanggalAbsen(
                                  tanggal: "Minggu, 30 September (07:10:30)",
                                  isTidakHadir: true,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     "Tampilkan Lebih Banyak",
                      //     style: orangeTextStyle.copyWith(fontWeight: semiBold),
                      //   ),
                      // ),
                      SizedBox(height: defaultMargin),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Riwayat Absensi",
              style: titleTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            iconTheme: IconThemeData(color: kTitleColor),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Text("Data Kosong"),
          ),
        );
      },
    );
  }
}
