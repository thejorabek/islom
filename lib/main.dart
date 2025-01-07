import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/quran_bloc/quran_bloc.dart';
import 'package:islom/bloc/quran_bloc/quran_event.dart';
import 'package:islom/bloc/surah_bloc/one_surah_bloc.dart';
import 'package:islom/utils/router/router.dart';
import 'package:islom/view/one_surah_page.dart';
import 'package:islom/view/quran_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SurahBloc()..add(LoadSurahListEvent()),
          child: QuranPage(),
        ),
        BlocProvider(
          create: (context) => OneSurahBloc(),
          child: OneSurahPage(surahNumber: null),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
