// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachModel _$CoachModelFromJson(Map<String, dynamic> json) => CoachModel(
      id: json['id'] as String?,
      bio: json['bio'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] as String?,
      ban: json['ban'] as bool?,
      age: json['age'] as String?,
      gymId: json['gymId'] as String?,
    );

Map<String, dynamic> _$CoachModelToJson(CoachModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('gymId', instance.gymId);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('phone', instance.phone);
  writeNotNull('image', instance.image);
  writeNotNull('gender', instance.gender);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('ban', instance.ban);
  writeNotNull('bio', instance.bio);
  writeNotNull('age', instance.age);
  return val;
}
