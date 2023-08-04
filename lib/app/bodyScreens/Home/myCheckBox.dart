import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class MyCheckBox extends StatelessWidget {
  final bool value;
  const MyCheckBox({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: value ? primaryColor : Colors.white,
          border:
              !value ? Border.all(color: secodaryTextColor, width: 1) : null,
        ),
        child: value
            ? Icon(
                CupertinoIcons.check_mark,
                color: themeData.colorScheme.onPrimary,
                size: 9,
              )
            : null,
      ),
    );
  }
}
