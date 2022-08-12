import 'package:flutter/material.dart';
import 'package:ogas_full_app/Widget/colors.dart';

void showLoadingDialog({
  @required BuildContext? context,
  Color? barrierColor,
}) {
  Future.delayed(const Duration(seconds: 0), () {
    showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants.lightOrange),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  });
}

void hideLoadingDialog({@required BuildContext? context}) {
  Navigator.pop(context!, false);
}
