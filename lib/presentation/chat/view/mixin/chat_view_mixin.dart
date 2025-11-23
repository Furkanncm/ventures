import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/presentation/chat/view/chat_view.dart';
import 'package:ventures/presentation/chat/viewmodel/chat_notifier.dart';
import 'package:ventures/presentation/chat/viewmodel/chat_state.dart';

mixin ChatViewMixin on ConsumerState<ChatView> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  ChatState get state => ref.watch(chatProvider);

  ChatNotifier get notifier => ref.read(chatProvider.notifier);

  void useChatListener() {
    ref.listen(chatProvider, (prev, next) {
      if (next.messages.length > (prev?.messages.length ?? 0)) {
        Future.delayed(const Duration(milliseconds: 150), _scrollToBottom);
      }
    });
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      unawaited(
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        ),
      );
    }
  }

  void onSendPressed(String text) {
    if (text.trim().isNotEmpty) {
      unawaited(notifier.sendMessage(text));
      controller.clear();
    }
  }

  void onClearPressed() {
    notifier.clearChat();
  }
}
