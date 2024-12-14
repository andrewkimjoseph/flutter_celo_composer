import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomPopUpWidget extends ConsumerWidget {
  const CustomPopUpWidget(
      {super.key, required this.popUpTitle, required this.popUpText});
  final String popUpTitle;
  final String popUpText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return AlertDialog(
        title: Text(popUpTitle),
        content: SingleChildScrollView(
          child: Text(popUpText),
        ),
        actions: <Widget>[
          Row(
            children: [
              OutlinedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
