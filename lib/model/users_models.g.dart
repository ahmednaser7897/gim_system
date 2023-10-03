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
      age: json['age'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['createdAt'] as String?,
      ban: json['ban'] as bool?,
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('phone', instance.phone);
  writeNotNull('image', instance.image);
  writeNotNull('gender', instance.gender);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('ban', instance.ban);
  writeNotNull('age', instance.age);
  return val;
}

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
      fitnesLevel: json['fitnesLevel'] as String?,
    );

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
  return val;
}

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

GymModel _$GymModelFromJson(Map<String, dynamic> json) => GymModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      ban: json['ban'] as bool?,
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

Map<String, dynamic> _$GymModelToJson(GymModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('description', instance.description);
  writeNotNull('password', instance.password);
  writeNotNull('phone', instance.phone);
  writeNotNull('image', instance.image);
  writeNotNull('openDate', instance.openDate);
  writeNotNull('closeDate', instance.closeDate);
  writeNotNull('ban', instance.ban);
  writeNotNull('rate', instance.rate);
  writeNotNull('users', instance.users);
  writeNotNull('coachs', instance.coachs);
  return val;
}
