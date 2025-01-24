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

class FastingList {
  static List<Map<String, dynamic>> fastingTime = [
    {"kun": 1, "oy": "Mart", "haftaKuni": "Sha", "saharlik": "05:40", "iftorlik": "18:15"},
    {"kun": 2, "oy": "Mart", "haftaKuni": "Yak", "saharlik": "05:38", "iftorlik": "18:17"},
    {"kun": 3, "oy": "Mart", "haftaKuni": "Du", "saharlik": "05:37", "iftorlik": "18:18"},
    {"kun": 4, "oy": "Mart", "haftaKuni": "Se", "saharlik": "05:35", "iftorlik": "18:19"},
    {"kun": 5, "oy": "Mart", "haftaKuni": "Chor", "saharlik": "05:33", "iftorlik": "18:20"},
    {"kun": 6, "oy": "Mart", "haftaKuni": "Pay", "saharlik": "05:32", "iftorlik": "18:21"},
    {"kun": 7, "oy": "Mart", "haftaKuni": "Juma", "saharlik": "05:30", "iftorlik": "18:22"},
    {"kun": 8, "oy": "Mart", "haftaKuni": "Sha", "saharlik": "05:29", "iftorlik": "18:24"},
    {"kun": 9, "oy": "Mart", "haftaKuni": "Yak", "saharlik": "05:27", "iftorlik": "18:25"},
    {"kun": 10, "oy": "Mart", "haftaKuni": "Du", "saharlik": "05:25", "iftorlik": "18:26"},
    {"kun": 11, "oy": "Mart", "haftaKuni": "Se", "saharlik": "05:24", "iftorlik": "18:27"},
    {"kun": 12, "oy": "Mart", "haftaKuni": "Chor", "saharlik": "05:22", "iftorlik": "18:28"},
    {"kun": 13, "oy": "Mart", "haftaKuni": "Pay", "saharlik": "05:20", "iftorlik": "18:29"},
    {"kun": 14, "oy": "Mart", "haftaKuni": "Juma", "saharlik": "05:18", "iftorlik": "18:30"},
    {"kun": 15, "oy": "Mart", "haftaKuni": "Sha", "saharlik": "05:17", "iftorlik": "18:31"},
    {"kun": 16, "oy": "Mart", "haftaKuni": "Yak", "saharlik": "05:15", "iftorlik": "18:32"},
    {"kun": 17, "oy": "Mart", "haftaKuni": "Du", "saharlik": "05:13", "iftorlik": "18:34"},
    {"kun": 18, "oy": "Mart", "haftaKuni": "Se", "saharlik": "05:11", "iftorlik": "18:35"},
    {"kun": 19, "oy": "Mart", "haftaKuni": "Chor", "saharlik": "05:10", "iftorlik": "18:36"},
    {"kun": 20, "oy": "Mart", "haftaKuni": "Pay", "saharlik": "05:08", "iftorlik": "18:37"},
    {"kun": 21, "oy": "Mart", "haftaKuni": "Juma", "saharlik": "05:06", "iftorlik": "18:38"},
    {"kun": 22, "oy": "Mart", "haftaKuni": "Sha", "saharlik": "05:04", "iftorlik": "18:39"},
    {"kun": 23, "oy": "Mart", "haftaKuni": "Yak", "saharlik": "05:02", "iftorlik": "18:40"},
    {"kun": 24, "oy": "Mart", "haftaKuni": "Du", "saharlik": "05:01", "iftorlik": "18:41"},
    {"kun": 25, "oy": "Mart", "haftaKuni": "Se", "saharlik": "04:59", "iftorlik": "18:42"},
    {"kun": 26, "oy": "Mart", "haftaKuni": "Chor", "saharlik": "04:57", "iftorlik": "18:43"},
    {"kun": 27, "oy": "Mart", "haftaKuni": "Pay", "saharlik": "04:55", "iftorlik": "18:44"},
    {"kun": 28, "oy": "Mart", "haftaKuni": "Juma", "saharlik": "04:53", "iftorlik": "18:46"},
    {"kun": 29, "oy": "Mart", "haftaKuni": "Sha", "saharlik": "04:52", "iftorlik": "18:47"},
    {"kun": 30, "oy": "Mart", "haftaKuni": "Yak", "saharlik": "04:50", "iftorlik": "18:48"},
  ];
}
