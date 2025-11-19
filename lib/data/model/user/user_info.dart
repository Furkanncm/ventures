import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ventures/common/base/base_user_model.dart';
import 'package:ventures/common/utils/enum/subscription_type.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfoModel extends Equatable implements BaseUserModel<UserInfoModel> {
  UserInfoModel({
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.subscriptionType = SubscriptionType.free,
    this.freeUsageCount = 0,
    this.maxFreeUsage = 5,
    List<Map<String, dynamic>>? publicItems,
    List<Map<String, dynamic>>? historyItems,
    List<String>? errorReports,
  }) : publicItems = publicItems ?? [],
       historyItems = historyItems ?? [],
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

  /// Now we store item maps directly inside the user doc
  List<Map<String, dynamic>> publicItems;
  List<Map<String, dynamic>> historyItems;
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

  void addPublicItem(Map<String, dynamic> item) {
    if (!publicItems.any((e) => e['id'] == item['id'])) publicItems.add(item);
  }

  void addHistoryItem(Map<String, dynamic> item) {
    if (!historyItems.any((e) => e['id'] == item['id'])) historyItems.add(item);
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
    List<Map<String, dynamic>>? publicItems,
    List<Map<String, dynamic>>? historyItems,
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
      publicItems: publicItems ?? List.from(this.publicItems),
      historyItems: historyItems ?? List.from(this.historyItems),
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
    publicItems,
    historyItems,
    errorReports,
  ];
}
