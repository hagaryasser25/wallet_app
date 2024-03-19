import 'package:flutter/cupertino.dart';

class Wallet{
  Wallet({
    String? uid,
    String? phonNumber,
    String? name,
    String? email,
    int? price,
  }) {
    _uid = uid;
    _phonNumber = phonNumber;
    _name = name;
    _email = email;
    _price = price;
  }

  Wallet.fromJson(dynamic json) {
    _uid = json['uid'];
    _phonNumber = json['phonNumber'];
    _email = json['email'];
    _name = json['name'];
    _price = json['price'];
  }

  String? _uid;
  String? _phonNumber;
  String? _email;
  String? _name;
  int? _price;

  String? get uid => _uid;
  String? get phonNumber => _phonNumber;
  String? get email => _email;
  String? get name => _name;
  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['phonNumber'] = _phonNumber;
    map['email'] = _email;
    map['name'] = _name;
    map['price'] = _price;

    return map;
  }
}
