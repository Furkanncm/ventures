import 'dart:async';

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';

extension FutureLoadingExtension<T> on Future<T> {
  Future<T> withLoading(BuildContext context) async {
  final _ = showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: kElevationToShadow[4],
          color: ColorName.backgroundLight,
        ),
        width: 75,
        height: 75,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    ),
  );

  try {
    final result = await this;
    return result;
  } finally {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop(); 
    }
  }
}


  Future<T> withSnackbar(
    BuildContext context, {
    required String successMessage,
    String? errorMessage,
  }) async {
    try {
      final result = await this;
      if (!context.mounted) return Future.value();
      VSnackBar.show(
        context: context,
        text: successMessage,
        type: SnackBarType.success,
      );
      return result;
    } catch (e) {
      VSnackBar.show(
        context: context,
        text: errorMessage ?? e.toString(),
        type: SnackBarType.error,
      );
      rethrow;
    }
  }
}
