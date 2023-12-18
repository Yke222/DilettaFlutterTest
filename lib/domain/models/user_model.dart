import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  static Map<String, dynamic> toMapJson(final UserModel userModel) {
    return {
      'id': userModel.id,
      'name': userModel.name,
      'email': userModel.email,
    };
  }

  static UserModel emptyUser({
    final String? id,
    final String? name,
    final String? email,
  }) {
    return const UserModel(
      id: '',
      name: '',
      email: '',
    );
  }

  UserModel copyWith({
    final String? id,
    final String? name,
    final String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, name, email];
}
