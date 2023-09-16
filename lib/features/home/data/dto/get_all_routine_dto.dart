import 'package:json_annotation/json_annotation.dart';

import '../model/routine_api_model.dart';
part 'get_all_routine_dto.g.dart';

// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class GetAllRoutineDTO {
  final List<RoutineApiModel> data;

  GetAllRoutineDTO({required this.data});


   // fromJson
  factory GetAllRoutineDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllRoutineDTOFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$GetAllRoutineDTOToJson(this);

}
