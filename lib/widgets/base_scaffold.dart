import 'package:app_pharmacy/widgets/base_loading_dialog.dart';
import 'package:app_pharmacy/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints) bodyBuilder;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Color? bgColor;
  final bool isSafeBottom;
  final bool isSafeTop;
  final bool hasAppBar;
  final bool isAppearBottomBarWhenKeyboardShowing;
  final bool isWillPop;
  final bool isLoading;

  const BaseScaffold({
    Key? key,
    required this.bodyBuilder,
    this.bgColor,
    this.appBar,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.isSafeBottom = true,
    this.isSafeTop = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.hasAppBar = false,
    this.isAppearBottomBarWhenKeyboardShowing = false,
    this.isWillPop = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async => isWillPop,
          child: Scaffold(
            bottomNavigationBar: Padding(
              padding: isAppearBottomBarWhenKeyboardShowing
                  ? MediaQuery.of(context).viewInsets
                  : EdgeInsets.zero,
              child: bottomNavigationBar,
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // for remove primary focus and trigger the keyboard to dismiss.
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SafeArea(
                bottom: isSafeBottom,
                top: isSafeTop,
                child: LayoutBuilder(
                  builder: bodyBuilder,
                ),
              ),
            ),
            appBar: appBar,
            backgroundColor: bgColor ?? Colors.white,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            bottomSheet: bottomSheet,
          ),
        ),
        if (isLoading)
          LoadingDialogModal.asyncLoading(
            isLoading: isLoading,
          ),
      ],
    );
  }
}
