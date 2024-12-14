import 'package:flutter/material.dart';
import 'package:flutter_celo_composer/widgets/progress_indicator.dart';
import 'package:reown_appkit/appkit_modal.dart';

import '../services/celo_composer_services.dart';
import 'custom_alert.dart';

class CUSDAlfajoresBalanceButton extends StatefulWidget {
  const CUSDAlfajoresBalanceButton({super.key, required this.appKit});

  final ReownAppKitModal appKit;

  @override
  State<CUSDAlfajoresBalanceButton> createState() =>
      _CUSDAlfajoresBalanceButtonState();
}

class _CUSDAlfajoresBalanceButtonState
    extends State<CUSDAlfajoresBalanceButton> {
  bool isCheckingBalance = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ElevatedButton(
          onPressed: _checkcUSDBalanceOnAlfajores,
          child: isCheckingBalance
              ? const CustomProgressIndicator()
              : const Text("Check cUSD balance on Alfajores")),
    );
  }

  void _checkcUSDBalanceOnAlfajores() async {
    setState(() {
      isCheckingBalance = true;
    });
    double balance =
        await CeloComposerServices.checkcUSDBalanceAlfajores(widget.appKit);

    debugPrint("cUSD Balance on Alfajores: $balance cUSD");

    if (mounted) {
      setState(() {
        isCheckingBalance = false;
      });

      showDialog(
          context: context,
          builder: (context) {
            return CustomPopUpWidget(
              popUpTitle: 'cUSD Balance on Alfajores',
              popUpText: '$balance cUSD',
            );
          });
    }
  }
}
