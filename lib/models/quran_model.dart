class AllSurahListModel {
  AllSurahListModel({
    this.code,
    this.status,
    this.data,
  });

  int? code;
  String? status;
  List<Datum>? data;

  factory AllSurahListModel.fromJson(Map<String, dynamic> json) => AllSurahListModel(
        code: json["code"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        numberOfAyahs: json["numberOfAyahs"],
        revelationType: json["revelationType"],
      );
}

class EnumValues {
  EnumValues({this.map});
  String? map;

  factory EnumValues.fromJson(Map<String, dynamic> json) => EnumValues(
        map: json["map"],
      );
}
