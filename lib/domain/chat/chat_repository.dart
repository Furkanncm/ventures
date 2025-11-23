import 'package:ventures/data/data_source/remote/chat_remote_ds.dart';

abstract class IChatRepository {
  Future<String> sendMessage(String message);
}

class ChatRepository implements IChatRepository {
  ChatRepository(this._remoteDS);

  final ChatRemoteDS _remoteDS;

  @override
  Future<String> sendMessage(String message) async {
    return _remoteDS.sendMessage(message);
  }
}
