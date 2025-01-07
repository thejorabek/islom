import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/hadith_bloc/hadith_bloc.dart';
import 'package:islom/bloc/hadith_bloc/hadith_state.dart';

class HadisPage extends StatefulWidget {
  const HadisPage({super.key});

  @override
  State<HadisPage> createState() => _HadisPageState();
}

class _HadisPageState extends State<HadisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadith Books', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<HadithBloc, HadithState>(
        builder: (context, state) {
          if (state is HadithLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HadithLoaded) {
            final books = state.hadith.books;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
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
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Writer: ${book.writerName}'),
                        Text('Death: ${book.writerDeath}'),
                        Text('Hadiths: ${book.hadithsCount}'),
                        Text('Chapters: ${book.chaptersCount}'),
                      ],
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
