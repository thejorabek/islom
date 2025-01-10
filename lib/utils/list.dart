import 'package:flutter/material.dart';
import 'package:islom/models/time_model.dart';

class ImagesList {
  static const List<String> imageList = [
    'assets/images/bukhari.jpg',
    'assets/images/muslim.jpg',
    'assets/images/tirmidhi.png',
    'assets/images/dawud.jpg',
    'assets/images/majah.png',
    'assets/images/nasai.webp',
    'assets/images/hanbal.jpg',
    'assets/images/masabih.jpg',
    'assets/images/silsila.jpg',
  ];
}

class IconList {
  static const List<Icon> iconList = [
    Icon(Icons.sunny_snowing, color: Colors.white),
    Icon(Icons.wb_sunny_outlined, color: Colors.white),
    Icon(Icons.mosque_outlined, color: Colors.white),
    Icon(Icons.wb_sunny_outlined, color: Colors.white),
    Icon(Icons.sunny_snowing, color: Colors.white),
    Icon(Icons.nights_stay_outlined, color: Colors.white),
  ];
}

class TimeNames {
  static const List<String> timeNames = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];
}

class DuaList {
  static const List<String> duaList = [
    'لَا إِلٰهَ إِلَّا اللّٰهُ',
    'سُبْحَانَ اللّٰهِ ، اَلْحَمْدُ لِلّٰهِ ، اَللّٰهُ أَكْبَرُ',
    'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللّٰهِ',
    'لَا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيْكَ لَهُ ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيْرٌ',
    'سُبْحَانَ اللهِ ، وَالْحَمْدُ لِلهِ وَلَا إِلٰهَ إِلَّا اللهُ ، وَاللهُ أَكْبَرُ.',
    'سُبْحَانَ اللهِ وَبِحَمْدِهِ ، سُبْحَانَ اللهِ الْعَظِيْم',
    'يَا حَيُّ يَا قَيُّوْمُ ، بِرَحْمَتِكَ أَسْتَغِيْثُ',
    'لَآ إِلٰهَ إِلَّآ أَنْتَ سُبۡحٰنَكَ إِنِّيْ كُنْتُ مِنَ الظّٰلِمِيْنَ',
    'أَسْتَغْفِرُ اللهَ الْعَظِيْمَ الَّذِيْ لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ ، وَأَتُوْبُ إِلَيْهِ'
  ];

  static const List<String> duaTranslation = [
    'There is no god but Allah',
    'Allah is free from imperfection. All praise be to Allah. Allah is the Greatest',
    'There is no power (in averting evil) or strength (in attaining good) except through Allah',
    'There is no god but Allah. He is Alone and He has no partner whatsoever. To Him Alone belong all sovereignty and all praise. He is over all things All-Powerful',
    'Allah is free from imperfection. All praise be to Allah. There is no god worthy of worship but Allah. Allah is the Greatest',
    'Allah is free from imperfection and all praise is due to Him, Allah is free from imperfection, the Greatest',
    'O The Ever Living, The One Who sustains and protects all that exists; I seek assistance through Your Mercy',
    'There is no god worthy of worship except You; You are free from all imperfection. Indeed, I have been of the wrongdoers',
    'I seek forgiveness from Allah, the Greatest, whom there is none worthy of worship except Him, The Ever Living, The One Who sustains and protects all that exists, I turn in repentance towards you'
  ];
}

class GetTimes {
  static String getTiming(Timings timings, String timeName) {
    switch (timeName.toLowerCase()) {
      case 'fajr':
        return timings.fajr;
      case 'sunrise':
        return timings.sunrise;
      case 'dhuhr':
        return timings.dhuhr;
      case 'asr':
        return timings.asr;
      case 'maghrib':
        return timings.maghrib;
      case 'isha':
        return timings.isha;
      default:
        return 'N/A';
    }
  }
}
