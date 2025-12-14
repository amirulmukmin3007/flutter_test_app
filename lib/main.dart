import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/config/theme.dart';
import 'package:flutter_test_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_test_app/features/cart/repositories/cart_repository.dart';
import 'package:flutter_test_app/features/display/bloc/display_bloc.dart';
import 'package:flutter_test_app/features/display/repositories/display_repository.dart';
import 'package:flutter_test_app/shared/screens/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DisplayBloc(repository: DisplayRepository())
                  ..add(DisplayLoadData()),
          ),
          BlocProvider(
            create: (context) =>
                CartBloc(repository: CartRepository())..add(CartLoadData()),
          ),
        ],
        child: const MainApp(),
      ),
    );
  });
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
