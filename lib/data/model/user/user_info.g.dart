// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      subscriptionType:
          $enumDecodeNullable(
            _$SubscriptionTypeEnumMap,
            json['subscriptionType'],
          ) ??
          SubscriptionType.free,
      freeUsageCount: (json['freeUsageCount'] as num?)?.toInt() ?? 0,
      maxFreeUsage: (json['maxFreeUsage'] as num?)?.toInt() ?? 5,
      publicItems: (json['publicItems'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      historyItems: (json['historyItems'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      errorReports: (json['errorReports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'subscriptionType': _$SubscriptionTypeEnumMap[instance.subscriptionType]!,
      'freeUsageCount': instance.freeUsageCount,
      'maxFreeUsage': instance.maxFreeUsage,
      'publicItems': instance.publicItems,
      'historyItems': instance.historyItems,
      'errorReports': instance.errorReports,
    };

const _$SubscriptionTypeEnumMap = {
  SubscriptionType.free: 'free',
  SubscriptionType.premium: 'premium',
};
