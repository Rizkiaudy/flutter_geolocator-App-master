import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/constants.dart';
import 'package:flutter_geolocator_app/cubit/auth_cubit.dart';
import 'package:flutter_geolocator_app/cubit/cuti_cubit.dart';
import 'package:flutter_geolocator_app/widgets/custom_text_form_field.dart';
import 'package:flutter_geolocator_app/widgets/my_button.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class IzinPage extends StatefulWidget {
  const IzinPage({Key? key}) : super(key: key);

  @override
  State<IzinPage> createState() => _IzinPageState();
}

class _IzinPageState extends State<IzinPage> {
  

  String groupValue = "";
  String tanggal = "";
  TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    // ngambil value jam dan tanggal dari device
    initializeDateFormatting();
    // String tanggalSkrg = DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
    String tanggalSkrg = DateFormat("yyyy-MM-d", "id_ID").format(DateTime.now());
    setState(() {
      tanggal = tanggalSkrg;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget formSection() {
      return Column(
        children: [
          SizedBox(height: defaultMargin),
          for (var item in radioValue)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: item,
                  groupValue: groupValue,
                  onChanged: (val) {
                    setState(() {
                      groupValue = item;
                      print(val);
                    });
                  },
                  activeColor: kOrangeColor,
                ),
                Text(
                  item,
                  style: blackTextStyle,
                ),
              ],
            ),
          SizedBox(height: 16),
          CustomTextFormField(
            controller: keteranganController,
            hintText: "Masukkan Keterangan",
            title: "Keterangan Lain",
            minLines: 3,
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
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return MyButton(
                      onTap: () {
                        context.read<CutiCubit>().izin(
                              username: state.user.content!.user!,
                              nama: state.user.content!.name!,
                              status: state.user.content!.role!,
                              keterangan: keteranganController.text,
                              tanggal: tanggal,
                            );
                            print(tanggal);
                      },
                      title: "Submit",
                    );
                  }
                  return MyButton(
                    onTap: () {},
                    title: "Submit",
                  );
                },
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
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengajuan Izin",
          style: titleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kTitleColor),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              SizedBox(height: defaultMargin),
              Container(
                width: double.infinity,
                child: Text(
                  "Silahkan pilih alasan izin",
                  style: blackTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              formSection(),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> radioValue = ["izin", "sakit", "cuti"];
