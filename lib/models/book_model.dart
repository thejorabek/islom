import 'dart:convert';

BookModel BookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String BookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  int status;
  String message;
  List<Book> books;

  BookModel({
    required this.status,
    required this.message,
    required this.books,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        status: json["status"],
        message: json["message"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Book {
  int id;
  String bookName;
  String writerName;
  String? aboutWriter;
  String writerDeath;
  String bookSlug;
  String hadithsCount;
  String chaptersCount;

  Book({
    required this.id,
    required this.bookName,
    required this.writerName,
    required this.aboutWriter,
    required this.writerDeath,
    required this.bookSlug,
    required this.hadithsCount,
    required this.chaptersCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        bookName: json["bookName"],
        writerName: json["writerName"],
        aboutWriter: json["aboutWriter"],
        writerDeath: json["writerDeath"],
        bookSlug: json["bookSlug"],
        hadithsCount: json["hadiths_count"],
        chaptersCount: json["chapters_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookName": bookName,
        "writerName": writerName,
        "aboutWriter": aboutWriter,
        "writerDeath": writerDeath,
        "bookSlug": bookSlug,
        "hadiths_count": hadithsCount,
        "chapters_count": chaptersCount,
      };
}
