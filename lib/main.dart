import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketx/api.dart';
import 'package:rocketx/screens/screen_reddit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: const Color(0xFF1A1A1B), cardTheme: const CardTheme(color: Color.fromARGB(221, 0, 0, 0))),
        title: 'RocketX',
        home: RepositoryProvider(
          create: (context) => RocketXAPI.reddit(),
          child: const ScreenReddit(),
        ));
  }
}
