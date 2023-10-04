//flutter packages pub run build_runner build
//dart run build_runner build

import 'package:json_annotation/json_annotation.dart';

import 'coach_model.dart';
import 'user_model.dart';

part 'gym_model.g.dart';

@JsonSerializable(includeIfNull: false)
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
