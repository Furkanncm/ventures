import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ventures/data/model/user/user_auth.dart';

@immutable
final class SignUpState extends Equatable {
  const SignUpState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  final bool isLoading;
  final String? error;
  final AuthUser? user;

  SignUpState copyWith({
    bool? isLoading,
    String? error,
    AuthUser? user,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, user];
}
