import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/cubit/absen_cubit.dart';
import 'package:flutter_geolocator_app/cubit/auth_cubit.dart';
import 'package:flutter_geolocator_app/service/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/widgets/custom_date_form_field.dart';
import 'package:flutter_geolocator_app/widgets/dialog_bisa_absen.dart';
import 'package:flutter_geolocator_app/widgets/dialog_tidak_bisa_absen.dart';
import 'package:flutter_geolocator_app/widgets/my_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({Key? key}) : super(key: key);

  @override
  _AbsenPageState createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  // controller jam dan tanggal
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerJam = TextEditingController();
  // controller google map
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // ngambil value jam dan tanggal dari device
    initializeDateFormatting();
    DateTime now = DateTime.now();
    String jam = DateFormat('HH:mm:ss').format(now);
    String tanggal =
        DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
    controllerTanggal.text = tanggal;
    controllerJam.text = jam;
    // _determinePosition();
    MapService().getUserLocation();
    super.initState();
  }

  // posisi universitas balikpapan
  // -0.467509, 117.158343
  // -1.2655524, 116.8667499
  static final CameraPosition _posisiUniba = CameraPosition(
    target: LatLng(-1.2649, 116.8678),
    zoom: 17.0,
  );

  Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId("uniba"),
      center: LatLng(-1.2649, 116.8678),
      radius: 300,
      fillColor: Color(0xFF1766FF).withOpacity(0.3),
      strokeColor: Color(0xFF1766FF),
      strokeWidth: 1,
    )
  ]);

  @override
  Widget build(BuildContext context) {
    Widget mapSection() {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.465,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kGreenBGColor,
        ),
        child: GoogleMap(
          initialCameraPosition: _posisiUniba, // map langsung ngarah ke uniba
          mapType: MapType.normal, // tipe mapnya normal
          circles: circles, // radius
          myLocationEnabled: true, // lokasi user
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      );
    }

    Widget lokasiSection() {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: true,
        builder: (BuildContext context, ScrollController controller) {
          return Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
                SizedBox(height: defaultMargin),
                Text(
                  "Jadwal, ${DateFormat.yMMMMEEEEd("id").format(DateTime.now())}",
                  style: titleTextStyle.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Jam Kerja",
                  style: titleTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "08.30 AM - 04.00 PM",
                  style: titleTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomDateFormField(
                  title: "Tanggal",
                  image: "assets/icon_cuti.png",
                  controller: controllerTanggal,
                ),
                CustomDateFormField(
                  title: "Jam",
                  image: "assets/icon_jam.png",
                  controller: controllerJam,
                ),
                SizedBox(height: defaultMargin),
                BlocConsumer<AbsenCubit, AbsenState>(
                  listener: (context, state) {
                    if (state is AbsenSuccess) {
                      dialogBisaAbsen(
                        context,
                        controllerTanggal.text,
                        controllerJam.text,
                      );
                    } else if (state is AbsenFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // backgroundColor: kGreenLightColor,
                          content: Text(state.error),
                        ),
                      );
                    } else if (state is AbsenLoading) {
                      Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AbsenLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return Row(
                              children: [
                                Expanded(
                                  child: MyButton(
                                    onTap: () async {
                                      double jarak =
                                          await MapService().cekKejauhanUser();
                                      if (jarak < 300) {
                                        context.read<AbsenCubit>().absensi(
                                            username:
                                                "${state.user.content!.user}");
                                      } else {
                                        print("user diluar radius");
                                        dialogTidakBisaAbsen(context, jarak);
                                      }
                                    },
                                    title: "Clock In",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MyButton(
                                    onTap: () async {
                                      double jarak =
                                          await MapService().cekKejauhanUser();
                                      if (jarak < 300) {
                                        context
                                            .read<AbsenCubit>()
                                            .absensiKeluar(
                                              username:
                                                  "${state.user.content!.user}",
                                            );
                                      } else {
                                        print("user diluar radius");
                                        dialogTidakBisaAbsen(context, jarak);
                                      }
                                    },
                                    title: "Clock Out",
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: defaultMargin),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kTitleColor),
        title: Text(
          "Absensi Kehadiran",
          style: titleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          mapSection(),
          lokasiSection(),
        ],
      ),
    );
  }
}
