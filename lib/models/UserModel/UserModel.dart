class UserModel {
  UserModel({this.email, this.uid, this.username});

  UserModel.fromJson(dynamic json) {
    json['username'] = username;
    json['uid'] = uid;
    json['email'] = email;
  }

  String? username;
  String? uid ;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'username': username,
      'uid': uid,
      'email': email,
    };
    return map;
  }
}
