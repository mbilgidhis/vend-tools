import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';

import 'package:vend_tools_v2/pages/home.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('id')],
        path: 'assets/language', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: VendTools()
    ),
  );
}

class VendTools extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vend Tools',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoreList(),
    );
  }
}