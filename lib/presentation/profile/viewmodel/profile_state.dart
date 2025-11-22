import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/user/user_info.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.error,
  });

  factory ProfileState.initial() {
    return const ProfileState();
  }

  final bool isLoading;
  final UserInfoModel? user; 
  final String? error;

  ProfileState copyWith({
    bool? isLoading,
    UserInfoModel? user,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error:
          error, 
    );
  }

  @override
  List<Object?> get props => [isLoading, user, error];
}
