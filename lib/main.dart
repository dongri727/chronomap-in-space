import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_home_page.dart';
import 'scalable/bloc_provider.dart';
import 'scalable/timeline/timeline.dart';
import 'serverpod_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpodClient();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,//左向きを許可
    DeviceOrientation.landscapeRight,//右向きを許可
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      t: Timeline(Theme.of(context).platform),
      child: MaterialApp(
        title: 'Chronomap in Space',
        theme: ThemeData(

          textTheme: GoogleFonts.tsukimiRoundedTextTheme(
              Theme.of(context).textTheme
          ),

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}