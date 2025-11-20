import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventures/common/utils/enum/env_type.dart';

extension EnvExtension on EnvType {
  String get key {
    switch (this) {
      case EnvType.webClientId:
        return 'WEB_CLIENT_ID';
      case EnvType.stabilityApiKey:
        return 'STABILITY_AI_API_KEY';
      case EnvType.eventlabApiKey:
        return 'EVENTLAB_AI_API_KEY';
    }
  }

  String? get value => dotenv.env[key];
}
