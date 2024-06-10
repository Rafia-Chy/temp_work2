
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/repository/repository.dart';
import 'package:travel_app/view/places_screen.dart';

import 'bloc/places_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final Dio dio = Dio();
  final PlacesRepository repository = PlacesRepository(dio);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/lang',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(repository: repository)),
  );
}

class MyApp extends StatelessWidget {
  final PlacesRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlacesBloc(repository: repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel App',
        localizationsDelegates: [
          EasyLocalization.of(context)!.delegate,
        ],
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        locale: const Locale('en', 'US'),
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
