//flutter packages pub run build_runner build
//dart run build_runner build
import 'package:gim_system/model/diets_model.dart';
import 'package:gim_system/model/exercises_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UserModel {
  String? id;
  String? gymId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? gender;
  String? createdAt;
  bool? ban;
  String? age;
  String? weight;
  String? height;
  //String? bodyFatPercentage;
  double? bmi;
  String? bmiRuselt;
  String? goal;
  String? fitnesLevel;
  List<DietModel>? dites;
  List<UserExercises>? userExercises;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.image,
      this.gender,
      this.createdAt,
      this.ban,
      this.age,
      this.gymId,
      //this.bodyFatPercentage,
      this.bmi,
      this.bmiRuselt,
      this.goal,
      this.height,
      this.weight,
      this.dites,
      this.fitnesLevel});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
