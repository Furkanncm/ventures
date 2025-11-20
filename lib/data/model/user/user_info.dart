import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ventures/common/base/base_user_model.dart';
import 'package:ventures/common/utils/enum/subscription_type.dart';

part 'user_info.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
final class UserInfoModel extends Equatable
    implements BaseUserModel<UserInfoModel> {
  UserInfoModel({
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.subscriptionType = SubscriptionType.free,
    this.freeUsageCount = 0,
    this.maxFreeUsage = 5,
    List<String>? errorReports,
  }) : 
       errorReports = errorReports ?? [];

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  final SubscriptionType subscriptionType;
  int freeUsageCount;
  int maxFreeUsage;

  List<String> errorReports;

  @override
  UserInfoModel fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  // Free kullanım kontrolü
  bool canUseFreeFeature() =>
      subscriptionType == SubscriptionType.premium ||
      freeUsageCount < maxFreeUsage;

  void incrementFreeUsage() {
    if (subscriptionType == SubscriptionType.free) {
      freeUsageCount++;
    }
  }


  void reportError(String error) {
    errorReports.add(error);
  }

  // CopyWith metodu
  UserInfoModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    SubscriptionType? subscriptionType,
    int? freeUsageCount,
    int? maxFreeUsage,
    List<String>? errorReports,
  }) {
    return UserInfoModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      freeUsageCount: freeUsageCount ?? this.freeUsageCount,
      maxFreeUsage: maxFreeUsage ?? this.maxFreeUsage,
      errorReports: errorReports ?? List.from(this.errorReports),
    );
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoUrl,
    subscriptionType,
    freeUsageCount,
    maxFreeUsage,
    errorReports,
  ];
}
