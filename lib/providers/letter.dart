import 'package:flutter/cupertino.dart';

class Letter {
  final String receiverMailAddress;
  final String senderMailAddress;
  final String placeType;
  final String placeId;
  final String id;

  Letter({
    @required this.id,
    @required this.receiverMailAddress,
    @required this.senderMailAddress,
    @required this.placeId,
    @required this.placeType,
  });

  static Letter fromJson(Map<String, dynamic> json) => Letter(
      id: json['id'],
      receiverMailAddress: json['receiverMailAddress'],
      senderMailAddress: json['senderMailAddress'],
      placeId: json['placeId'],
      placeType: json['placeType']);
}
