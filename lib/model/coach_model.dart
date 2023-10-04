//flutter packages pub run build_runner build
//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'coach_model.g.dart';

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
