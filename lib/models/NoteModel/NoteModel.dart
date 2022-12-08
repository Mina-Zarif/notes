import 'package:flutter/cupertino.dart';

class NoteModel {
  NoteModel({this.abstract, this.date, this.time});

  NoteModel.fromJson(json) {
    abstract = json['abstract'];
    date = json['date'];
    time = json['time'];
   }

  String? abstract;
  String? date;
  String? time;

  // FileImage image = Image.asset("assets/images/ProjectImage.png") as FileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'abstract': abstract,
      'date': date,
      'time': time,
    };
    return map;
  }
}
