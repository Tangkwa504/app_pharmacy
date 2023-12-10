import 'package:app_pharmacy/widgets/will_not_pop_scope.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final Color backdropColor;

  const LoadingDialog({Key? key, this.backdropColor = Colors.black54})
      : super(key: key);

  static Widget stream(
    Stream<bool> stream, {
    Function(bool)? onChanged,
    Color? backdropColor,
  }) {
    return StreamBuilder<bool>(
      stream: stream,
      initialData: false,
      builder: (ctx, snapshot) {
        if (onChanged != null) {
          onChanged(snapshot.data!);
        }
        return snapshot.data == false
            ? const SizedBox.shrink()
            : LoadingDialog(
                backdropColor: backdropColor ?? Colors.black54,
              );
      },
    );
  }

  static Widget loadingWidget() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black.withAlpha(0xBF),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 42,
              height: 42,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: WillNotPopScope(
        child: AbsorbPointer(
          child: OverflowBox(
            alignment: Alignment.center,
            minWidth: screenSize.width + 150.0,
            minHeight: screenSize.height + 150.0,
            maxWidth: screenSize.width + 150.0,
            maxHeight: screenSize.height + 150.0,
            child: Container(
              color: backdropColor,
              child: Center(child: loadingWidget()),
            ),
          ),
        ),
      ),
    );
  }
}
