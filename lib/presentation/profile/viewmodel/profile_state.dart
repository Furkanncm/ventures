import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/user/user_info.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.error,
  });

  // Başlangıç durumu için factory
  factory ProfileState.initial() {
    return const ProfileState();
  }

  final bool isLoading;
  final UserInfoModel? user; // İçinde kredi bilgileri var
  final String? error;

  ProfileState copyWith({
    bool? isLoading,
    UserInfoModel? user,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error, // Hata null gönderilirse temizlensin diye null check yapmıyoruz
    );
  }

  @override
  List<Object?> get props => [isLoading, user, error];
}