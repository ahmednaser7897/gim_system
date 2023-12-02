// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietModel _$DietModelFromJson(Map<String, dynamic> json) => DietModel(
      id: json['id'] as String?,
      breakfast: json['breakfast'] as String?,
      coachId: json['coachId'] as String?,
      createdAt: json['createdAt'] as String?,
      dinner: json['dinner'] as String?,
      lunch: json['lunch'] as String?,
      notes: json['notes'] as String?,
      userId: json['userId'] as String?,
    )..coachModel = json['coachModel'] == null
        ? null
        : CoachModel.fromJson(json['coachModel'] as Map<String, dynamic>);

Map<String, dynamic> _$DietModelToJson(DietModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('coachId', instance.coachId);
  writeNotNull('breakfast', instance.breakfast);
  writeNotNull('dinner', instance.dinner);
  writeNotNull('lunch', instance.lunch);
  writeNotNull('notes', instance.notes);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('coachModel', instance.coachModel);
  return val;
}
