// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
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
      bodyFatPercentage: json['bodyFatPercentage'] as String?,
      goal: json['goal'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      dites: (json['dites'] as List<dynamic>?)
          ?.map((e) => DietModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fitnesLevel: json['fitnesLevel'] as String?,
    )..userExercises = (json['userExercises'] as List<dynamic>?)
        ?.map((e) => UserExercises.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
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
  writeNotNull('age', instance.age);
  writeNotNull('weight', instance.weight);
  writeNotNull('height', instance.height);
  writeNotNull('bodyFatPercentage', instance.bodyFatPercentage);
  writeNotNull('goal', instance.goal);
  writeNotNull('fitnesLevel', instance.fitnesLevel);
  writeNotNull('dites', instance.dites);
  writeNotNull('userExercises', instance.userExercises);
  return val;
}
