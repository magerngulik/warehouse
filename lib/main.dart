import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

var id = supabase.auth.currentUser!.id;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bhuatqvawwgnevdocvnn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJodWF0cXZhd3dnbmV2ZG9jdm5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg2MzY0NTIsImV4cCI6MjAxNDIxMjQ1Mn0.pQjCCt9S9BrH3wnxtMG6SJHIscVsMpvqEmqOlYuDShg',
  );

  var userId = supabase.auth.currentUser;
  Widget mainapp;
  if (userId != null) {
    mainapp = const LoginView();
    // mainapp = const TestingView();
  } else {
    mainapp = const LoginView();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: mainapp,
      ),
    );
  });
}

final supabase = Supabase.instance.client;
