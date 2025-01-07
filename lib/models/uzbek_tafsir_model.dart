class UzbekTafsirModel {
    UzbekTafsirModel({
        this.result,
    });

    List<Result>? result;

    factory UzbekTafsirModel.fromJson(Map<String, dynamic> json) => UzbekTafsirModel(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.sura,
        this.aya,
        this.arabicText,
        this.translation,
        this.footnotes,
    });

    String? id;
    String? sura;
    String? aya;
    String? arabicText;
    String? translation;
    String? footnotes;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        sura: json["sura"],
        aya: json["aya"],
        arabicText: json["arabic_text"],
        translation: json["translation"],
        footnotes: json["footnotes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sura": sura,
        "aya": aya,
        "arabic_text": arabicText,
        "translation": translation,
        "footnotes": footnotes,
    };
}
