// ignore_for_file: public_member_api_docs, sort_constructors_first

//flutter packages pub run build_runner build
//dart run build_runner build
import 'dart:convert';

//import 'package:json_annotation/json_annotation.dart';

class ExerciseModel {
  String? id;
  String? gymId;
  String? name;
  String? videoLink;
  ExerciseModel({
    this.id,
    this.gymId,
    this.name,
    this.videoLink,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gymId': gymId,
      'name': name,
      'videoLink': videoLink,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] != null ? map['id'] as String : null,
      gymId: map['gymId'] != null ? map['gymId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      videoLink: map['videoLink'] != null ? map['videoLink'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
