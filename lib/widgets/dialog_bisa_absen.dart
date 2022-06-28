import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/widgets/my_button.dart';

Future<dynamic> dialogBisaAbsen(
    BuildContext context, String tanggal, String jam) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xFFEFFFEC),
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
                    image: AssetImage("assets/icon_done.png"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Berhasil Absen",
                style: dialogGreenTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanggal : ",
                    style: dialogGreenTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "$tanggal",
                      style: dialogGreenTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Jam       : $jam WITA",
                  style: dialogGreenTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
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
