import 'package:equatable/equatable.dart';

class RoutineEntity extends Equatable {
  final String? id;
  final String day;
  final String startTime;
  final String endTime;
  final String location;
  final String source;

  const RoutineEntity({
    this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.source,
  });

  // convert JSON to routine entity
  factory RoutineEntity.fromJson(Map<String, dynamic> json) {
    return RoutineEntity(
      id: json['_id'],
      day: json['day'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      location: json['location'],
      source: json['source'],
    );
  }

  @override
  List<Object?> get props => [id, day, startTime, endTime, location, source];

  @override
  String toString() {
    return 'Day: $day, Start Time: $startTime, End Time: $endTime, Location: $location, Source: $source';
  }
}
