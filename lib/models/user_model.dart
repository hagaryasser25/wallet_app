import 'package:flutter/cupertino.dart';

class Userss {
  Userss({
    String? id,
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    _id = id;
    _uid = uid;
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
  }

  Userss.fromJson(dynamic json) {
    _id = json['id'];
    _uid = json['uid'];
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
  }

  String? _id;
  String? _uid;
  String? _name;
  String? _email;
  String? _phoneNumber;

  String? get id => _id;
  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uid'] = _uid;
    map['name'] = _name;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;

    return map;
  }
}