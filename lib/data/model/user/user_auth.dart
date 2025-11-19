import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ventures/common/base/base_user_model.dart';

part 'user_auth.g.dart';

@JsonSerializable()
final class AuthUser extends Equatable implements BaseUserModel<AuthUser> {
  const AuthUser({
    required this.uid,
    required this.email,
    required this.isEmailVerified,
    required this.createdAt,
    required this.authProvider,
    this.displayName,
    this.photoUrl,
  });

  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool? isEmailVerified;
  final DateTime? createdAt;
  final String? authProvider;

  @override
  AuthUser fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthUserToJson(this);

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoUrl,
    isEmailVerified,
    createdAt,
    authProvider,
  ];

  AuthUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isEmailVerified,
    DateTime? createdAt,
    String? authProvider,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      authProvider: authProvider ?? this.authProvider,
    );
  }
}
