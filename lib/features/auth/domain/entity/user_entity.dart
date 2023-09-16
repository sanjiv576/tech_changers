import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String fullName;
  final String contactNumber;
  final String? userPhoto;
  final String address;
  final String? role;
  final String? location;
  final String? password;

  const UserEntity({
    this.id,
    required this.fullName,
    required this.contactNumber,
    this.userPhoto,
    required this.address,
    this.role,
    this.location,
    this.password,
  });

  // convert json to entity
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['_id'],
      fullName: json['fullName'],
      contactNumber: json['contactNumber'],
      userPhoto: json['userPhoto'],
      address: json['address'],
      role: json['role'],
      location: json['location'],
      password: json['password'],
    );
  }

//  convert entity to json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'contactNumber': contactNumber,
      'userPhoto': userPhoto,
      'address': address,
      'role': role,
      'location': location,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User id: $id, fullName: $fullName, contactNumber: $contactNumber, userPhoto: $userPhoto, address: $address, role: $role, location: $location';
  }

  @override
  List<Object?> get props =>
      [id, fullName, contactNumber, userPhoto, address, role, location];
}
