import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/chapter_bloc/chapter_bloc.dart';
import 'package:islom/bloc/book_bloc/book_bloc.dart';
import 'package:islom/bloc/book_bloc/book_event.dart';
import 'package:islom/bloc/counter_bloc/counter_bloc.dart';
import 'package:islom/bloc/quran_bloc/quran_bloc.dart';
import 'package:islom/bloc/quran_bloc/quran_event.dart';
import 'package:islom/bloc/surah_bloc/one_surah_bloc.dart';
import 'package:islom/bloc/time_bloc/time_bloc.dart';
import 'package:islom/bloc/time_bloc/time_event.dart';
import 'package:islom/utils/router/router.dart';
import 'package:islom/view/chapter_page.dart';
import 'package:islom/view/dua_page.dart';
import 'package:islom/view/hadis_page.dart';
import 'package:islom/view/one_surah_page.dart';
import 'package:islom/view/quran_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String address = "Tashkent,UZB";
  final String date = "08-01-2025";

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
        BlocProvider(
          create: (context) => BookBloc()..add(LoadBookEvent()),
          child: HadisPage(),
        ),
        BlocProvider(
          create: (context) => ChapterBloc(),
          child: ChapterPage(),
        ),
        BlocProvider(
          create: (context) => PrayerTimeBloc()
            ..add(
              LoadPrayerTimeEvent(address: address, date: date),
            ),
        ),
        BlocProvider(
          create: (context) => CountdownBloc(),
          child: DuaPage(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
