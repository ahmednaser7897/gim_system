import 'package:json_annotation/json_annotation.dart';
part 'diets_model.g.dart';

@JsonSerializable(includeIfNull: false)
class DietModel {
  String? id;
  String? userId;
  String? coachId;
  String? breakfast;
  String? dinner;
  String? lunch;
  String? notes;
  String? createdAt;
  DietModel({
    this.id,
    this.breakfast,
    this.coachId,
    this.createdAt,
    this.dinner,
    this.lunch,
    this.notes,
    this.userId,
  });
  factory DietModel.fromJson(Map<String, dynamic> json) =>
      _$DietModelFromJson(json);
  Map<String, dynamic> toJson() => _$DietModelToJson(this);
}
