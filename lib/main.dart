import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/config/theme.dart';
import 'package:flutter_test_app/features/display/bloc/display_bloc.dart';
import 'package:flutter_test_app/features/display/repositories/display_repository.dart';
import 'package:flutter_test_app/shared/screens/splashscreen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DisplayBloc(displayRepository: DisplayRepository())
                ..add(DisplayLoadData()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: flutterTestAppTheme(),
      home: Splashscreen(),
    );
  }
}
