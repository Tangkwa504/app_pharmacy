import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:flutter/material.dart';

Future<T?> showBaseDialog<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool barrierDismissible = true,
}) {
  return showDialog(
    context: context,
    builder: builder,
    barrierColor: AppColor.themeGrayLight,
    barrierDismissible: barrierDismissible,
  );
}

class BaseDialog extends StatelessWidget {
  final String? message;
  final VoidCallback? onClick;
  final bool willPopScope;
  final Widget? dialogLogo;

  BaseDialog({
    Key? key,
    this.message,
    this.onClick,
    this.willPopScope = false,
    this.dialogLogo,
  }) : super(key: key);

  final ShapeBorder shapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => willPopScope,
      child: Dialog(
        elevation: 0,
        shape: shapeBorder,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColor.themeWhiteColor,
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: width - 16 * 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 16),
            child: SizedBox(
              width: width - 16 * 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  if (message != null) ...[
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      '$message',
                      textAlign: TextAlign.center,
                      style: AppStyle.txtBody2,
                    ),
                  ],
                  const SizedBox(
                    height: 70,
                  ),
                  BaseButton(
                    onTap: onClick ??
                        () {
                          final navigator =
                              Navigator.of(context, rootNavigator: true);
                          if (navigator.canPop()) {
                            navigator.pop();
                          }
                        },
                    label: 'ยืนยัน',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
