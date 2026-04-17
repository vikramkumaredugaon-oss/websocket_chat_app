import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;
  final bool showMessage;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 32,
    this.showMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor:
              AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          if (showMessage && message != null) ...[
            const SizedBox(height: 12),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}