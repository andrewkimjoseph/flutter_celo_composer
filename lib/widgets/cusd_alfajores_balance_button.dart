import 'package:flutter/material.dart';
import 'package:flutter_celo_composer/widgets/progress_indicator.dart';
import 'package:reown_appkit/appkit_modal.dart';

import '../services/celo_composer_services.dart';

class CUSDBalanceButton extends StatefulWidget {
  const CUSDBalanceButton({
    super.key,
    required this.appKit,
    this.forTestnet = true,
  });

  final ReownAppKitModal appKit;
  final bool forTestnet;

  @override
  State<CUSDBalanceButton> createState() => _CUSDBalanceButtonState();
}

class _CUSDBalanceButtonState extends State<CUSDBalanceButton> {
  bool isCheckingBalance = false;
  late CeloComposerServices _celoComposerServices;

  final String btnTextForAlfajores = "Check cUSD Balance on Alfajores";
  final String btnTextForMainnet = "Check cUSD Balance on Mainnet";

  @override
  void initState() {
    super.initState();
    _celoComposerServices = CeloComposerServices(widget.appKit);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ElevatedButton(
        onPressed: isCheckingBalance ? null : _checkcUSDBalance,
        child: isCheckingBalance
            ? const CustomProgressIndicator()
            : Text(widget.forTestnet ? btnTextForAlfajores : btnTextForMainnet),
      ),
    );
  }

  Future<void> _checkcUSDBalance() async {
    setState(() {
      isCheckingBalance = true;
    });

    try {
      double balance = widget.forTestnet
          ? await _celoComposerServices.checkcUSDBalanceOnAlfajores()
          : await _celoComposerServices.checkcUSDBalanceOnMainnet();

      debugPrint("cUSD Balance: $balance cUSD");
      _showBalanceSnackbar(balance);
    } catch (e) {
      _showErrorSnackbar(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isCheckingBalance = false;
        });
      }
    }
  }

  void _showBalanceSnackbar(double balance) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'cUSD Balance: $balance cUSD',
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $errorMessage',
          style: const TextStyle(color: Colors.yellow),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.black,
      ),
    );
  }
}
