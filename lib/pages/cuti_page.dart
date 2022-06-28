import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/cubit/cuti_cubit.dart';
import 'package:flutter_geolocator_app/models/user_model.dart';
import 'package:flutter_geolocator_app/widgets/custom_date_picker.dart';
import 'package:flutter_geolocator_app/widgets/custom_text_form_field.dart';
import 'package:flutter_geolocator_app/widgets/my_button.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController tanggalMulaiController = TextEditingController();
  TextEditingController tanggalAkhirController = TextEditingController();

  @override
  void initState() {
    namaController.text = widget.user.content!.name!;
    nipController.text = widget.user.content!.user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget myFormSection() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            CustomTextFormField(
              controller: namaController,
              hintText: "Masukkan Nama",
              title: "Nama",
            ),
            CustomTextFormField(
              controller: nipController,
              hintText: "Masukkan NIP",
              title: "NIP",
            ),
            CustomTextFormField(
              controller: keteranganController,
              hintText: "Masukkan Keterangan",
              title: "Keterangan",
              minLines: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDatePicker(
                    title: "Mulai Dari", dateinput: tanggalMulaiController),
                CustomDatePicker(
                    title: "Sampai", dateinput: tanggalAkhirController),
              ],
            ),
            SizedBox(height: defaultMargin),
            BlocConsumer<CutiCubit, CutiState>(
              listener: (context, state) {
                if (state is CutiSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // backgroundColor: kGreenLightColor,
                      content: Text(state.cuti.msg),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is CutiFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // backgroundColor: kGreenLightColor,
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CutiLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MyButton(
                  onTap: () {
                    context.read<CutiCubit>().cuti(
                          user: widget.user,
                          keterangan: keteranganController.text,
                          tanggalMulai: tanggalMulaiController.text,
                          tanggalAkhir: tanggalAkhirController.text,
                        );
                  },
                  title: "Submit",
                );
              },
            ),
            SizedBox(height: 12),
            MyButton(
              onTap: () {
                Navigator.pop(context);
              },
              title: "Cancel",
              isOrange: false,
            ),
            SizedBox(height: defaultMargin),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kTitleColor),
        title: Text(
          "Pengajuan Cuti",
          style: titleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: defaultMargin),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 88),
              child: Text(
                "Silahkan isi data diri anda beserta alasan cuti",
                style: blackTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            myFormSection(),
          ],
        ),
      ),
    );
  }
}
