import 'package:flutter/material.dart';

class SquirrelButton extends StatelessWidget {
  ///Text to display on the button
  ///-SquirrelUI
  final String buttonText;

  ///Size of the button text [double]
  final double buttonTextSize;
  final onTap;

  ///This is a custom squirrel button
  SquirrelButton(
      {@required this.buttonText, this.buttonTextSize = 16, this.onTap}) {
    assert(buttonText != null);
    assert(buttonTextSize != null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 74, right: 74, bottom: 8, top: 8),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.redAccent, //AppTheme.getTheme().primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
