import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/surah_bloc/one_surah_bloc.dart';
import 'package:islom/bloc/surah_bloc/one_surah_state.dart';
import 'package:lottie/lottie.dart';

class OneSurahPage extends StatelessWidget {
  final int? surahNumber;

  const OneSurahPage({Key? key, this.surahNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white),
          onPressed: () {
            context.go('/main');
          },
        ),
        title: BlocBuilder<OneSurahBloc, OneSurahState>(
          builder: (context, state) {
            if (state is OneSurahLoaded) {
              return Text(
                state.surah.data?.englishName ?? '',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }
            return Text('');
          },
        ),
      ),
      body: BlocBuilder<OneSurahBloc, OneSurahState>(
        builder: (context, state) {
          if (state is OneSurahLoading) {
            return Center(
              child: Lottie.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3),
            );
          } else if (state is OneSurahLoaded) {
            final surah = state.surah.data;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ...surah?.ayahs?.map((ayah) {
                      return ListTile(
                        title: Container(
                            decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(13)),
                            width: width * 0.9,
                            height: height * 0.04,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Text(
                                    '${ayah.numberInSurah}',
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),Spacer(),
                                IconButton(onPressed: ()=>{}, icon: Icon(Icons.ios_share_outlined,color: Colors.white)),
                                IconButton(onPressed: ()=>{}, icon: Icon(Icons.play_circle_outline_rounded,color: Colors.white)),
                                IconButton(onPressed: ()=>{}, icon: Icon(Icons.bookmark_border_outlined,color: Colors.white)),
                              ],
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            ayah.text ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }) ??
                    [],
              ],
            );
          } else if (state is OneSurahError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No surah details available.'));
          }
        },
      ),
    );
  }
}
