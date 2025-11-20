import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; 
import 'package:json_annotation/json_annotation.dart';
import 'package:ventures/common/base/base_user_model.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
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
    this.imageGenUsage = 0,
    this.ttsUsage = 0,
    this.docAnalysisUsage = 0,
    this.maxFreeLimitPerFeature = 3,
    List<String>? errorReports,
  }) : errorReports = errorReports ?? [];

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  final SubscriptionType subscriptionType;

  // Sayaçlar
  final int imageGenUsage;
  final int ttsUsage;
  final int docAnalysisUsage;

  final int maxFreeLimitPerFeature;

  final List<String> errorReports;

  @override
  UserInfoModel fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  bool hasCredit(FeatureType type) {
    if (subscriptionType == SubscriptionType.premium) return true;

    switch (type) {
      case FeatureType.imageGeneration:
        return imageGenUsage < maxFreeLimitPerFeature;
      case FeatureType.textToSpeech:
        return ttsUsage < maxFreeLimitPerFeature;
      case FeatureType.documentAnalysis:
        return docAnalysisUsage < maxFreeLimitPerFeature;
    }
  }

  UserInfoModel consumeCredit(FeatureType type) {
    if (subscriptionType == SubscriptionType.premium) return this;

    switch (type) {
      case FeatureType.imageGeneration:
        return copyWith(imageGenUsage: imageGenUsage + 1);
      case FeatureType.textToSpeech:
        return copyWith(ttsUsage: ttsUsage + 1);
      case FeatureType.documentAnalysis:
        return copyWith(docAnalysisUsage: docAnalysisUsage + 1);
    }
  }

  UserInfoModel upgradeToPremium() {
    return copyWith(subscriptionType: SubscriptionType.premium);
  }

  UserInfoModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    SubscriptionType? subscriptionType,
    int? imageGenUsage,
    int? ttsUsage,
    int? docAnalysisUsage,
    int? maxFreeLimitPerFeature,
    List<String>? errorReports,
  }) {
    return UserInfoModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      imageGenUsage: imageGenUsage ?? this.imageGenUsage,
      ttsUsage: ttsUsage ?? this.ttsUsage,
      docAnalysisUsage: docAnalysisUsage ?? this.docAnalysisUsage,
      maxFreeLimitPerFeature:
          maxFreeLimitPerFeature ?? this.maxFreeLimitPerFeature,
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
    imageGenUsage,
    ttsUsage,
    docAnalysisUsage,
    maxFreeLimitPerFeature,
    errorReports,
  ];
}
