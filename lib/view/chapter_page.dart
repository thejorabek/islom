import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/chapter_bloc/chapter_bloc.dart';
import 'package:islom/bloc/chapter_bloc/chapter_state.dart';

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
      appBar: AppBar(title: Text('Chapters',style: TextStyle(fontFamily: 'Quicksand'),)),
      body: BlocBuilder<ChapterBloc, ChapterState>(
        builder: (context, state) {
          if (state is ChapterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChapterLoaded) {
            final chapters = state.chapterModel.chapters;
            return 
            ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(15)),
                    height: height*.07,
                    child: ListTile(
                      title: Text(chapter.chapterEnglish,style: TextStyle(fontFamily: 'Quicksand')),
                      subtitle: Text(chapter.chapterUrdu,style: TextStyle(fontFamily: 'Quicksand')),
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
