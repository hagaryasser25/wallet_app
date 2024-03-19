import 'package:flutter/cupertino.dart';

class Transictions {
  Transictions({
    String? id,
    String? receiverPhone,
    String? senderPhone,
    int? amount,
  }) {
    _id = id;
    _receiverPhone = receiverPhone;
    _senderPhone = senderPhone;
    _amount = amount;
  }

  Transictions.fromJson(dynamic json) {
    _id = json['id'];
    _receiverPhone = json['receiverPhone'];
    _senderPhone = json['senderPhone'];
    _amount = json['amount'];
  }

  String? _id;
  String? _receiverPhone;
  String? _senderPhone;
  int? _amount;

  String? get id => _id;
  String? get receiverPhone => _receiverPhone;
  String? get senderPhone => _senderPhone;
  int? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['receiverPhone'] = _receiverPhone;
    map['senderPhone'] = _senderPhone;
    map['amount'] = _amount;

    return map;
  }
}
