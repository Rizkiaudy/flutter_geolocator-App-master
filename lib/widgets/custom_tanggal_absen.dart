import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';

class CustomTanggalAbsen extends StatelessWidget {
  const CustomTanggalAbsen(
      {Key? key,
      this.isTerlambat = false,
      this.isTidakHadir = false,
      required this.tanggal})
      : super(key: key);

  final String tanggal;
  final bool isTerlambat, isTidakHadir;

  Color bgColor() {
    if (isTerlambat == true) {
      return kPinkColor;
    } else if (isTidakHadir == true) {
      return kOrangBGColor;
    } else {
      return kGreenBGColor;
    }
  }

  Text childText() {
    if (isTerlambat == true) {
      return Text(
        "Terlambat",
        style: redTextStyle.copyWith(
          fontWeight: semiBold,
          fontSize: 13,
        ),
      );
    } else if (isTidakHadir == true) {
      return Text(
        "Tidak Hadir",
        style: orangeTextStyle.copyWith(
          fontWeight: semiBold,
          fontSize: 13,
        ),
      );
    } else {
      return Text(
        "Hadir",
        style: greenTextStyle.copyWith(
          fontWeight: semiBold,
          fontSize: 13,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 16),
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kDividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              tanggal,
              style: blackTextStyle,
            ),
          ),
          Container(
            width: 102,
            height: 36,
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: bgColor(),
            ),
            child: childText(),
          ),
        ],
      ),
    );
  }
}
