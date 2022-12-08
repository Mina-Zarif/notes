class TaskModel {
  TaskModel({this.title, this.content, this.date, this.time, this.uid});

  String? title;
  String? content;
  String? date;
  String? time;
  String? uid;
  bool check = false;
  bool? bin = false;

  TaskModel.fromJson(json) {
    title = json['title'];
    content = json['content'];
    date = json['date'];
    time = json['time'];
    check = json['check'];
    bin = json['bin'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'content': content,
      'date': date,
      'time': time,
      'check': check,
      'bin': bin,
      'uid': uid,
    };
    return map;
  }
}
