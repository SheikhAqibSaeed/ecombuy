import 'package:ecom_buy/widgets/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EcoDialogue extends StatelessWidget {
  final String? title;
  const EcoDialogue({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        EcoButton(
          title: 'Close',
          onPress: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
