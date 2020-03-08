import 'package:flutter/material.dart';

class CdutSpPage{
  CdutSpPage({this.label,this.iconData,this.color,Key key});
  final String label;
  final IconData iconData;
  final Color color;
  @override
  String toString() {
    return '$runtimeType("$label")';
  }
}