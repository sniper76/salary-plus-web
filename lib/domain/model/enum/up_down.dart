import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum UpDown {
  @JsonValue('Up')
  up('Up', Icons.arrow_upward, Color(0xffFF0000)),
  @JsonValue('Down')
  down('Down', Icons.arrow_downward, Color(0xff439CFB)),
  @JsonValue('-')
  hyphen('-', Icons.remove, Color(0xff999999));

  const UpDown(this.value, this.icon, this.color);

  final String value;
  final IconData icon;
  final Color color;
}
