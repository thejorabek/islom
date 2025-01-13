import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/surah_bloc/one_surah_bloc.dart';
import 'package:islom/bloc/surah_bloc/one_surah_event.dart';
import 'package:islom/view/dua_helper_page.dart';
import 'package:islom/view/dua_page.dart';
import 'package:islom/view/hadis_page.dart';
import 'package:islom/view/main_page.dart';
import 'package:islom/view/one_surah_page.dart';
import 'package:islom/view/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: 'main',
      path: '/main',
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      name: 'hadith',
      path: '/hadith',
      builder: (context, state) => HadisPage(),
    ),
    GoRoute(
      name: 'dua',
      path: '/dua',
      builder: (context, state) => DuaPage(),
    ),
    GoRoute(
      name: 'dua_helper',
      path: '/dua_helper',
      builder: (context, state) => DuaHelperPage(),
    ),
    GoRoute(
          path: '/surah/:number',
          builder: (context, state) {
            final surahNumber = int.parse(state.pathParameters['number']!);
            return BlocProvider(
              create: (context) => OneSurahBloc()..add(LoadOneSurahEvent(surahNumber)),
              child: OneSurahPage(surahNumber: surahNumber),
            );
          },
        ),
  ],
);