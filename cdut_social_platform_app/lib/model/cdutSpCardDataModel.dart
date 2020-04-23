import 'package:flutter/cupertino.dart';

class CdutSpCardData{
  const CdutSpCardData({
    this.userName,
    this.college,
    this.message,
    this.imageAsset,
    //this.imageAssetPackage,
    this.likeNum,
    this.date,
    this.label
  });
  final String userName;
  final String college;
  final String message;
  final String imageAsset;
  //final String imageAssetPackage;
  final String date;
  final num likeNum;
  final String label;
  factory CdutSpCardData.fromjson(Map<String,dynamic> json){
    return CdutSpCardData(
        userName: json['userName'],
        message: json['message'],
        label: json['label'],
        date: json['date'],
        likeNum: json['likeNum'],
        imageAsset:json['imageAsset'],
    );
  }

}