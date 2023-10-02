//flutter packages pub run build_runner build
//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'users_models.g.dart';

@JsonSerializable(includeIfNull: false)
class AdminModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? gender;
  String? createdAt;
  bool? ban;
  String? age;

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

@JsonSerializable(includeIfNull: false)
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

@JsonSerializable(includeIfNull: false)
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
  bool? ban;
  String? bio;
  String? age;

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

@JsonSerializable(includeIfNull: false)
class GymModel {
  String? id;
  String? name; //
  String? email; //
  String? description; //
  String? password; //
  String? phone; //
  String? image;
  String? openDate; //
  String? closeDate; //
  bool? ban;
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
