// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    ExerciseModel(
      id: json['id'] as String?,
      gymId: json['gymId'] as String?,
      name: json['name'] as String?,
      videoLink: json['videoLink'] as String?,
    );

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('gymId', instance.gymId);
  writeNotNull('name', instance.name);
  writeNotNull('videoLink', instance.videoLink);
  return val;
}

UserExercises _$UserExercisesFromJson(Map json) => UserExercises(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      coachId: json['coachId'] as String?,
      done: json['done'] as bool?,
      date: json['date'] as String?,
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$UserExercisesToJson(UserExercises instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('coachId', instance.coachId);
  writeNotNull('done', instance.done);
  writeNotNull('date', instance.date);
  writeNotNull(
      'exercises', instance.exercises?.map((e) => e.toJson()).toList());
  return val;
}

Exercise _$ExerciseFromJson(Map json) => Exercise(
      count: (json['count'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      exerciseId: json['exerciseId'] as String?,
      done: json['done'] as bool?,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  writeNotNull('total', instance.total);
  writeNotNull('exerciseId', instance.exerciseId);
  writeNotNull('done', instance.done);
  return val;
}
