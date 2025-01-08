import 'dart:convert';

ChapterModel chapterModelFromJson(String str) => ChapterModel.fromJson(json.decode(str));

String chapterModelToJson(ChapterModel data) => json.encode(data.toJson());

class ChapterModel {
  int status;
  String message;
  List<Chapter> chapters;

  ChapterModel({
    required this.status,
    required this.message,
    required this.chapters,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        status: json["status"],
        message: json["message"],
        chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  int id;
  String chapterNumber;
  String chapterEnglish;
  String chapterUrdu;
  String chapterArabic;
  BookSlug bookSlug;

  Chapter({
    required this.id,
    required this.chapterNumber,
    required this.chapterEnglish,
    required this.chapterUrdu,
    required this.chapterArabic,
    required this.bookSlug,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        chapterNumber: json["chapterNumber"],
        chapterEnglish: json["chapterEnglish"],
        chapterUrdu: json["chapterUrdu"],
        chapterArabic: json["chapterArabic"],
        bookSlug: bookSlugValues.map[json["bookSlug"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapterNumber": chapterNumber,
        "chapterEnglish": chapterEnglish,
        "chapterUrdu": chapterUrdu,
        "chapterArabic": chapterArabic,
        "bookSlug": bookSlugValues.reverse[bookSlug],
      };
}

enum BookSlug {
  SAHIH_BUKHARI,
  SAHIH_MUSLIM,
  SUNAN_ABU_DAWOOD,
  JAMI_TIRMIDHI,
  SUNAN_NASAI,
  SUNAN_IBN_MAJAH,
  MISHKAT_AL_MASABIH,
  MUSNAD_AHMAD,
  AL_SILSILA_SAHIHA,
}

final bookSlugValues = EnumValues({
  "sahih-bukhari": BookSlug.SAHIH_BUKHARI,
  "sahih-muslim": BookSlug.SAHIH_MUSLIM,
  "abu-dawood": BookSlug.SUNAN_ABU_DAWOOD,
  "al-tirmidhi": BookSlug.JAMI_TIRMIDHI,
  "sunan-nasai": BookSlug.SUNAN_NASAI,
  "ibn-e-majah": BookSlug.SUNAN_IBN_MAJAH,
  "mishkat": BookSlug.MISHKAT_AL_MASABIH,
  "musnad-ahmad": BookSlug.MUSNAD_AHMAD,
  "al-silsila-sahiha": BookSlug.AL_SILSILA_SAHIHA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
