import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/chat/chat_message.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  factory ChatState.initial() {
    return const ChatState();
  }

  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error];
}
