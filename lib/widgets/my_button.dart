import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.isOrange = true})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final bool isOrange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isOrange ? kOrangeColor : kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kOrangeColor),
        ),
        child: Text(
          title,
          style: isOrange
              ? whiteTextStyle.copyWith(
                  fontWeight: semiBold,
                )
              : orangeTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
        ),
      ),
    );
  }
}
