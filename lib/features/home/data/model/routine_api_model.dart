import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/routine_entity.dart';

final routineApiModelProvider = Provider((ref) => RoutineApiModel.empty());

@JsonSerializable()
class RoutineApiModel {
  @JsonKey(name: '_id') // might be unnecessary here
  final String? id;
  final String day;
  final String startTime;
  final String endTime;
  final String location;
  final String source;

  const RoutineApiModel({
    this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.source,
  });

  RoutineApiModel.empty()
      : this(day: '', startTime: '', endTime: '', location: '', source: '');

  // convert JSON to routine entity
  factory RoutineApiModel.fromJson(Map<String, dynamic> json) {
    return RoutineApiModel(
      id: json['_id'],
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      location: json['location'],
      source: json['source'],
    );
  }

  // convert routine entity to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'source': source,
    };
  }

  // convert to entity
  RoutineEntity toEntity() {
    return RoutineEntity(
      id: id,
      day: day,
      startTime: startTime,
      endTime: endTime,
      location: location,
      source: source,
    );
  }

// conversion of list of routine api model to list of entity
  List<RoutineEntity> toEntityList(List<RoutineApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
