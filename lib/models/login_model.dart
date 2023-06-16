// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> response) {
    status = response['status'];
    message = response['message'];
    data = UserData.fromJson(response['data']);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(Map<String, dynamic>? user) {
    id = user?['id'];
    name = user?['name'];
    email = user?['email'];
    phone = user?['phone'];
    image = user?['image'];
    points = user?['points'];
    credit = user?['credit'];
    token = user?['token'];
  }
}
