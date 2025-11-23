import 'dart:math' as math;

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/chat/chat_message.dart';
import 'package:ventures/presentation/chat/view/mixin/chat_view_mixin.dart';

part 'widgets/chat_app_bar.dart';
part 'widgets/chat_background.dart';
part 'widgets/empty_state.dart';
part 'widgets/input_area.dart';
part 'widgets/message_bubble.dart';
part 'widgets/message_list.dart';
part 'widgets/typing_indicator.dart';

@immutable
final class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> with ChatViewMixin {
  @override
  Widget build(BuildContext context) {
    useChatListener();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: _ChatAppBar(onClear: onClearPressed),
      body: _ChatBackground(
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: state.messages.isEmpty
                  ? _EmptyState(onSuggestionSelected: onSendPressed)
                  : _MessageList(
                      messages: state.messages,
                      controller: scrollController,
                    ),
            ),

            if (state.isLoading) const _TypingIndicator(),

            _InputArea(
              controller: controller,
              isLoading: state.isLoading,
              onSend: onSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}
