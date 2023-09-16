class WaterSupplyTime {
  String day;

  String time;

  String location;
  String? source;

  WaterSupplyTime({
    required this.day,
    required this.time,
    required this.location,
    this.source,
  });
}
