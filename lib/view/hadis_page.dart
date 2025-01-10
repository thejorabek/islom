import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/chapter_bloc/chapter_bloc.dart';
import 'package:islom/bloc/chapter_bloc/chapter_event.dart';
import 'package:islom/bloc/book_bloc/book_bloc.dart';
import 'package:islom/bloc/book_bloc/book_state.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';
import 'package:islom/view/chapter_page.dart';
import 'package:lottie/lottie.dart';

class HadisPage extends StatefulWidget {
  const HadisPage({super.key});

  @override
  State<HadisPage> createState() => _HadisPageState();
}

class _HadisPageState extends State<HadisPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.background,
        title: Text('Hadith Books', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Quicksand')),
        leading: IconButton(onPressed: () => context.push('/main'), icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white)),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is HadithLoading) {
            return Center(
              child: Lottie.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3),
            );
          } else if (state is HadithLoaded) {
            final books = state.hadith.books;
            return GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.67,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: context.read<ChapterBloc>()..add(LoadChaptersEvent(book.bookSlug)),
                          child: ChapterPage(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.tile,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.bookName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: height * 0.2,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                ImagesList.imageList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  book.writerName,
                                  maxLines: 1,
                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontFamily: 'Quicksand', color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is HadithError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
