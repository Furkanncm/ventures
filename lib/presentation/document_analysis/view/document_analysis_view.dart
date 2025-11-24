import 'dart:ui';

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/card/input_card.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/presentation/document_analysis/view/mixin/document_analysis_mixin.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_anaysis_state.dart'; // Mixin yolu

part 'widgets/analysis_result_card.dart';
part 'widgets/preview_content.dart';
part 'widgets/selection_container.dart';

@immutable
final class DocumentAnalysisView extends ConsumerStatefulWidget {
  const DocumentAnalysisView({super.key});

  @override
  ConsumerState<DocumentAnalysisView> createState() =>
      _DocumentAnalysisViewState();
}

class _DocumentAnalysisViewState extends ConsumerState<DocumentAnalysisView>
    with DocumentAnalysisMixin {
  @override
  Widget build(BuildContext context) {
    useDocumentListener();

    return Scaffold(
      appBar: VAppbar(
        title: StringConstants.docAnalysisTitle,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined),
            onPressed: routeHistory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: VPadding.pagePadding(),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SelectionContainer(
              state: state,
              onTap: onSourceTap,
            ),

            InputCard(controller: promptController),

            VElevatedButton.withIcon(
              onPressed: onAnalyzePressed,
              label: StringConstants.analyzeDocument,
              icon: const Icon(Icons.document_scanner),
            ),

            if (state.analysisResult != null)
              _AnalysisResultCard(
                result: state.analysisResult!,
                onShareTap: onShareResultTap,
              ),
          ],
        ),
      ),
    );
  }
}
