import 'package:flutter/material.dart';
import 'package:flutter_celo_composer/chains/chains.dart';
import 'package:flutter_celo_composer/widgets/progress_indicator.dart';
import 'package:reown_appkit/appkit_modal.dart';

import '../services/web3_services.dart';

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
  late Web3Services _celoComposerServices;

  final String btnTextForAlfajores = "Check cUSD Balance on Alfajores";
  final String btnTextForMainnet = "Check cUSD Balance on Mainnet";

  @override
  void initState() {
    super.initState();
    _celoComposerServices = Web3Services(widget.appKit);
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
      final selectedChainId = widget.appKit.selectedChain?.chainId;
      final isNetworkMismatched = widget.forTestnet
          ? selectedChainId != Chains.celoAlfajores.chainId
          : selectedChainId != Chains.celoMainnet.chainId;

      if (isNetworkMismatched) {
        _showErrorSnackbar(widget.forTestnet
            ? 'Please switch to Celo Alfajores first.'
            : 'Please switch to Celo Mainnet first.');
        return;
      }

      double balance = widget.forTestnet
          ? await _celoComposerServices.checkcUSDBalanceOnAlfajores()
          : await _celoComposerServices.checkcUSDBalanceOnMainnet();

      debugPrint('cUSD Balance: $balance cUSD.');
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
          'cUSD Balance: $balance cUSD.',
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
