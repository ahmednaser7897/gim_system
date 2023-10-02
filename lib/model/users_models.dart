//flutter packages pub run build_runner build
//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'users_models.g.dart';

@JsonSerializable()
class AdminModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? gender;
  String? createdAt;
  String? ban;
  double? age;

  AdminModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.age,
    this.phone,
    this.image,
    this.gender,
    this.createdAt,
    this.ban,
  });
  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}

@JsonSerializable()
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
  String? ban;
  double? age;
  FitnessData? fitnessData;

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
      this.fitnessData});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class FitnessData {
  String? id;
  double? weight;
  double? height;
  double? bodyFatPercentage;
  String? goal;

  FitnessData({
    this.id,
    this.bodyFatPercentage,
    this.goal,
    this.height,
    this.weight,
  });
  factory FitnessData.fromJson(Map<String, dynamic> json) =>
      _$FitnessDataFromJson(json);
  Map<String, dynamic> toJson() => _$FitnessDataToJson(this);
}

@JsonSerializable()
class CoachModel {
  String? id;
  String? gymId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? gender;
  String? createdAt;
  String? ban;
  String? bio;
  double? age;

  CoachModel(
      {this.id,
      this.bio,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.image,
      this.gender,
      this.createdAt,
      this.ban,
      this.age,
      this.gymId});
  factory CoachModel.fromJson(Map<String, dynamic> json) =>
      _$CoachModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoachModelToJson(this);
}

@JsonSerializable()
class GymModel {
  String? id;
  String? name;
  String? email;
  String? description;
  String? password;
  String? phone;
  String? image;
  String? openDate;
  String? closeDate;
  String? ban;
  double? rate;
  List<UserModel>? users;
  List<CoachModel>? coachs;

  GymModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.image,
      this.ban,
      this.closeDate,
      this.description,
      this.coachs,
      this.openDate,
      this.rate,
      this.users});
  factory GymModel.fromJson(Map<String, dynamic> json) =>
      _$GymModelFromJson(json);
  Map<String, dynamic> toJson() => _$GymModelToJson(this);
}
