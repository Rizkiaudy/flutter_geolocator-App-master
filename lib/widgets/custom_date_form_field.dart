import 'package:flutter/material.dart';
import 'package:flutter_geolocator_app/constants.dart';

class CustomDateFormField extends StatelessWidget {
  const CustomDateFormField({
    Key? key,
    required this.title,
    required this.controller,
    required this.image,
  }) : super(key: key);

  final String title, image;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintStyle: greyTextStyle.copyWith(fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kOrangeColor),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
