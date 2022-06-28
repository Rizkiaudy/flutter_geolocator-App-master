import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/cubit/auth_cubit.dart';
import 'package:flutter_geolocator_app/models/user_model.dart';
import 'package:flutter_geolocator_app/pages/cuti_page.dart';
import 'package:flutter_geolocator_app/service/map_service.dart';
import 'package:flutter_geolocator_app/widgets/custom_card_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    MapService().determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    UserModel user = UserModel();


    Widget profileSection() {
      Widget namaSection() {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              user = state.user;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Halo,", style: whiteTextStyle),
                  SizedBox(height: 4),
                  Text(
                    "${state.user.content!.name}",
                    style: whiteTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text("${state.user.content!.user}", style: whiteTextStyle),
                  SizedBox(height: 4),
                  Text("${state.user.content!.role}", style: whiteTextStyle),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        );
      }

      return Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg-profile.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            namaSection(),
            Container(
              width: 57,
              height: 57,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                image: DecorationImage(
                  image: AssetImage("assets/avatar.png"),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget menuSection() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCardButton(
                  title: "Absensi\nKehadiran",
                  imageUrl: "assets/icon_absen.png",
                  onTap: () {
                    Navigator.pushNamed(context, 'absen-page');
                  },
                ),
                CustomCardButton(
                  title: "Pengajuan\nCuti",
                  imageUrl: "assets/icon_cuti.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => CutiPage(
                          user: user,
                        )),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCardButton(
                  title: "Riwayat\nKehadiran",
                  imageUrl: "assets/icon_riwayat.png",
                  onTap: () {
                    Navigator.pushNamed(context, 'riwayat-page');
                  },
                ),
                CustomCardButton(
                  title: "Pengajuan\nIzin",
                  imageUrl: "assets/icon_izin.png",
                  onTap: () {
                    Navigator.pushNamed(context, 'izin-page');
                  },
                ),
              ],
            ),
            CustomCardButton(
              title: "Logout",
              imageUrl: "assets/icon_logout.png",
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login-page', (route) => false);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            profileSection(),
            SizedBox(height: 32),
            menuSection(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
