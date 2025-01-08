import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/quran_bloc/quran_bloc.dart';
import 'package:islom/bloc/quran_bloc/quran_state.dart';
import 'package:lottie/lottie.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<SurahBloc, SurahState>(builder: (context, state){
        if (state is SurahLoading) {
            return Center(
                  child: Lottie.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3),
                );
          }else if (state is SurahError) {
            return Center(child: Text(state.message));
          }else if(state is SurahLoaded){
            final surahs = state.surahList.data ?? [];
            return ListView.builder(
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                final surah = surahs[index];
                return ListTile(
                  title: Text('${surah.number}. ${surah.englishName ?? ''}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  subtitle: Text('${surah.numberOfAyahs.toString()} ayahs' ?? ''),
                  trailing: Text(surah.name ?? '',style: TextStyle(fontSize: 18),),
                  onTap: () {
                    context.go('/surah/${surah.number}');
                  },
                );
              },
            );
      }else {
            return Center(child: Text('Press a button to load Surah list.'));
          }
      }),
    );
  }
}