import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/user/user_info.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.error,
    this.historyItems = const [],
    this.publicItems = const [],
  });
  final bool isLoading;
  final UserInfoModel? user;
  final String? error;
  final List<String> historyItems;
  final List<String> publicItems;

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
      historyItems: historyItems ?? this.historyItems,
      publicItems: publicItems ?? this.publicItems,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    user,
    error,
    historyItems,
    publicItems,
  ];
}
