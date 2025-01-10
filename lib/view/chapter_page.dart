import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/chapter_bloc/chapter_bloc.dart';
import 'package:islom/bloc/chapter_bloc/chapter_state.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:lottie/lottie.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({super.key});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  final List<String> bookSlugs = [
    "sahih-bukhari",
    "sahih-muslim",
    "al-tirmidhi",
    "abu-dawood",
    "ibn-e-majah",
    "sunan-nasai",
    "mishkat",
    "musnad-ahmad",
    "al-silsila-sahiha"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        title: Text('Chapters', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: CustomColors.background,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(onPressed: ()=>{context.push('/hadith')}, icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: BlocBuilder<ChapterBloc, ChapterState>(
        builder: (context, state) {
          if (state is ChapterLoading) {
            return Center(child: LottieBuilder.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3));
          } else if (state is ChapterLoaded) {
            final chapters = state.chapterModel.chapters;
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: CustomColors.tile, borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        '${chapter.chapterNumber}. ${chapter.chapterEnglish}',
                        style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        chapter.chapterUrdu,
                        style: TextStyle(fontFamily: 'Quicksand', color: Colors.white,fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ChapterError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
