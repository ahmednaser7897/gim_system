//flutter packages pub run build_runner build
//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';

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
