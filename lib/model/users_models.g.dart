// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      age: (json['age'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] as String?,
      ban: json['ban'] as String?,
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'image': instance.image,
      'gender': instance.gender,
      'createdAt': instance.createdAt,
      'ban': instance.ban,
      'age': instance.age,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] as String?,
      ban: json['ban'] as String?,
      age: (json['age'] as num?)?.toDouble(),
      gymId: json['gymId'] as String?,
      fitnessData: json['fitnessData'] == null
          ? null
          : FitnessData.fromJson(json['fitnessData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'gymId': instance.gymId,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'image': instance.image,
      'gender': instance.gender,
      'createdAt': instance.createdAt,
      'ban': instance.ban,
      'age': instance.age,
      'fitnessData': instance.fitnessData,
    };

FitnessData _$FitnessDataFromJson(Map<String, dynamic> json) => FitnessData(
      id: json['id'] as String?,
      bodyFatPercentage: (json['bodyFatPercentage'] as num?)?.toDouble(),
      goal: json['goal'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FitnessDataToJson(FitnessData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'height': instance.height,
      'bodyFatPercentage': instance.bodyFatPercentage,
      'goal': instance.goal,
    };

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
      ban: json['ban'] as String?,
      age: (json['age'] as num?)?.toDouble(),
      gymId: json['gymId'] as String?,
    );

Map<String, dynamic> _$CoachModelToJson(CoachModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gymId': instance.gymId,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'image': instance.image,
      'gender': instance.gender,
      'createdAt': instance.createdAt,
      'ban': instance.ban,
      'bio': instance.bio,
      'age': instance.age,
    };

GymModel _$GymModelFromJson(Map<String, dynamic> json) => GymModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      ban: json['ban'] as String?,
      closeDate: json['closeDate'] as String?,
      description: json['description'] as String?,
      coachs: (json['coachs'] as List<dynamic>?)
          ?.map((e) => CoachModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      openDate: json['openDate'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GymModelToJson(GymModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'password': instance.password,
      'phone': instance.phone,
      'image': instance.image,
      'openDate': instance.openDate,
      'closeDate': instance.closeDate,
      'ban': instance.ban,
      'rate': instance.rate,
      'users': instance.users,
      'coachs': instance.coachs,
    };
