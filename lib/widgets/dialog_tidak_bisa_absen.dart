import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/widgets/my_button.dart';

Future<dynamic> dialogTidakBisaAbsen(BuildContext context, double jarak) {
  int jarakRound = jarak.round();
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFFEDED),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.symmetric(horizontal: 17),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                width: 50,
                height: 50,
                // margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icon_failed.png"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Tidak Bisa Absen",
                style: dialogRedTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Anda diluar radius absen",
                style: dialogRedTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Jarak anda : $jarakRound m",
                style: dialogRedTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 50),
              MyButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: "Lanjutkan",
              ),
              SizedBox(height: 30),
            ],
          )
        ],
      );
    },
  );
}
