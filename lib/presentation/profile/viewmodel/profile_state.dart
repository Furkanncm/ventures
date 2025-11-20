import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/user/user_info.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.error,
  });
  final bool isLoading;
  final UserInfoModel? user;
  final String? error;

  ProfileState copyWith({
    bool? isLoading,
    UserInfoModel? user,
    String? error,
    List<String>? historyItems,
    List<String>? publicItems,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, error];
}
