// ignore_for_file: public_member_api_docs, sort_constructors_first

//flutter packages pub run build_runner build
//dart run build_runner build

import 'package:json_annotation/json_annotation.dart';
part 'exercises_model.g.dart';

@JsonSerializable(includeIfNull: false)
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

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);
}

@JsonSerializable(includeIfNull: false, anyMap: true, explicitToJson: true)
class UserExercises {
  String? id;
  String? userId;
  String? coachId;
  bool? done;
  String? date;
  List<Exercise>? exercises;
  UserExercises({
    this.id,
    this.userId,
    this.coachId,
    this.done,
    this.date,
    this.exercises,
  });
  factory UserExercises.fromJson(Map<String, dynamic> json) =>
      _$UserExercisesFromJson(json);
  Map<String, dynamic> toJson() => _$UserExercisesToJson(this);
}

@JsonSerializable(includeIfNull: false, anyMap: true, explicitToJson: true)
class Exercise {
  double? count;
  double? total;
  String? exerciseId;
  bool? done;
  Exercise({
    this.count,
    this.total,
    this.exerciseId,
    this.done,
  });
  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
