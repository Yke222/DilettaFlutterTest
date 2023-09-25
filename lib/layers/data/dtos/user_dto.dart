import 'package:diletta_store/layers/domain/entities/user_entity.dart';

/// Responsible for serializing a remotely obtained user to a domain entity.
class UserDTO extends UserEntity {
  final String uid;
  final String? displayName;

  UserDTO({
    required this.uid,
    required super.email,
    required this.displayName,
  }) : super(id: uid, name: displayName);
}
