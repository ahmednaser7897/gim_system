// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
