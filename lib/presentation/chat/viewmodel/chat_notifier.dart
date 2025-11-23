import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/data/model/chat/chat_message.dart';
import 'package:ventures/domain/chat/chat_repository.dart';
import 'package:ventures/presentation/chat/viewmodel/chat_state.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier(this._repo) : super(ChatState.initial());

  final IChatRepository _repo;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Kullanıcı mesajını ekle
    final userMsg = ChatMessage(text: text, isUser: true);

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isLoading: true,
    );

    try {
      // 2. AI'ya gönder ve cevabı bekle
      final response = await _repo.sendMessage(text);

      // 3. AI cevabını ekle
      final aiMsg = ChatMessage(text: response, isUser: false);

      state = state.copyWith(
        messages: [...state.messages, aiMsg],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearChat() {
    state = ChatState.initial();
  }
}
