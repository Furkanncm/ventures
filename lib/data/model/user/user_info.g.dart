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
      imageGenUsage: (json['imageGenUsage'] as num?)?.toInt() ?? 0,
      ttsUsage: (json['ttsUsage'] as num?)?.toInt() ?? 0,
      docAnalysisUsage: (json['docAnalysisUsage'] as num?)?.toInt() ?? 0,
      maxFreeLimitPerFeature:
          (json['maxFreeLimitPerFeature'] as num?)?.toInt() ?? 3,
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
      'imageGenUsage': instance.imageGenUsage,
      'ttsUsage': instance.ttsUsage,
      'docAnalysisUsage': instance.docAnalysisUsage,
      'maxFreeLimitPerFeature': instance.maxFreeLimitPerFeature,
      'errorReports': instance.errorReports,
    };

const _$SubscriptionTypeEnumMap = {
  SubscriptionType.free: 'free',
  SubscriptionType.premium: 'premium',
};
