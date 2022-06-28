import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';

class CustomCardAbsen extends StatelessWidget {
  const CustomCardAbsen(
      {Key? key,
      required this.title,
      required this.textStyle,
      required this.jumlah})
      : super(key: key);

  final String title;
  final TextStyle textStyle;
  final int jumlah;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 122,
      decoration: BoxDecoration(
        border: Border.all(
          color: kBorderColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "$jumlah",
            style: textStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
