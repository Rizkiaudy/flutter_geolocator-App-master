import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geolocator_app/cubit/absen_cubit.dart';
import 'package:flutter_geolocator_app/cubit/auth_cubit.dart';
import 'package:flutter_geolocator_app/cubit/cuti_cubit.dart';
import 'package:flutter_geolocator_app/cubit/riwayat_absen_cubit.dart';
import 'package:flutter_geolocator_app/pages/absen_page.dart';
import 'package:flutter_geolocator_app/pages/izin_page.dart';
import 'package:flutter_geolocator_app/pages/login_page.dart';
import 'package:flutter_geolocator_app/pages/main_page.dart';
import 'package:flutter_geolocator_app/pages/riwayat_page.dart';
import 'package:flutter_geolocator_app/pages/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(MyApp()),
  );
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AbsenCubit(),
        ),
        BlocProvider(
          create: (context) => RiwayatAbsenCubit(),
        ),
        BlocProvider(
          create: (context) => CutiCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => SplashScreen(),
          'login-page': (context) => LoginPage(),
          'main-page': (context) => MainPage(),
          'izin-page': (context) => IzinPage(),
          'riwayat-page': (context) => RiwayatPage(),
          'absen-page': (context) => AbsenPage(),
        },
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}