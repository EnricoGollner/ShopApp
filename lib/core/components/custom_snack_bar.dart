import 'package:flutter/material.dart';
import 'package:shop/core/theme/colors.dart';
import 'package:shop/core/enums/snackbar_type.dart';
import 'package:shop/main.dart';

class BoxSnackBar extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final void Function()? action;

  final SnackBarType type;

  const BoxSnackBar.success({
    super.key,
    required this.message,
    this.type = SnackBarType.success,
    this.actionLabel,
    this.action,
  });

  const BoxSnackBar.info({
    super.key,
    required this.message,
    this.type = SnackBarType.info,
    this.actionLabel,
    this.action,
  });

  const BoxSnackBar.error({
    super.key,
    required this.message,
    this.type = SnackBarType.error,
    this.actionLabel,
    this.action,
  });

  const BoxSnackBar.conexaoError({
    super.key,
    this.message = "Verifique a conexão com a rede",
    this.type = SnackBarType.error,
    this.actionLabel,
    this.action,
  });

  const BoxSnackBar.warning({
    super.key,
    required this.message,
    this.type = SnackBarType.warning,
    this.actionLabel,
    this.action,
  });

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      duration: getDuration(),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: getBackgroundColor(),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel!,
              textColor: colorOnPrimary,
              onPressed: () {
                action!();
                scaffoldMessengerKey.currentState!.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
              },
            )
          : null,
      content: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10.0),
                  ),
                  color: getColor(),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: SizedBox(
                width: 15.0,
              ),
            ),
            Flexible(
              flex: 2,
              child: Icon(getIcon(), color: getColor()),
            ),
            const Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0,
                ),
            ),
            Flexible(
              flex: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  message,
                  maxLines: 5,
                  style: const TextStyle(color: colorOnPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar getSnackBar(BuildContext context) => build(context);

  Color getColor() {
    switch (type) {
      case SnackBarType.success:
        return colorSuccess;
      case SnackBarType.info:
        return colorSecondary;
      case SnackBarType.warning:
        return colorError;
      case SnackBarType.error:
        return colorError;
    }
  }

  Duration getDuration() {
    switch (type) {
      case SnackBarType.success:
        return const Duration(seconds: 2);
      case SnackBarType.info:
        return const Duration(seconds: 5);
      case SnackBarType.warning:
        return const Duration(seconds: 5);
      case SnackBarType.error:
        return const Duration(seconds: 10);
    }
  }

  Color getBackgroundColor() {
    switch (type) {
      case SnackBarType.success:
        return colorSuccessBackground;
      case SnackBarType.info:
        return colorWarningBackground;
      case SnackBarType.warning:
        return colorWarningBackground;
      case SnackBarType.error:
        return colorErrorBackground;
    }
  }

  IconData getIcon() {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.info:
        return Icons.info;
      case SnackBarType.warning:
        return Icons.error;
      case SnackBarType.error:
        return Icons.cancel;
    }
  }
}

void showSnackBar(BuildContext context, BoxSnackBar boxSnackBar) {
  scaffoldMessengerKey.currentState!.hideCurrentSnackBar();
  scaffoldMessengerKey.currentState!.showSnackBar(boxSnackBar.getSnackBar(context));
}
