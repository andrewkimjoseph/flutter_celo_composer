import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectText extends ConsumerStatefulWidget {
  const ConnectText(
      {super.key,
      required this.kitIsInitialized,
      required this.walletIsConnected});

  final bool kitIsInitialized;
  final bool walletIsConnected;

  @override
  ConsumerState<ConnectText> createState() => _ConnectTextState();
}

class _ConnectTextState extends ConsumerState<ConnectText> {
  @override
  Widget build(BuildContext context) {
    if (widget.kitIsInitialized) {
      return Text(
        widget.walletIsConnected ? "Connected" : "Connect your wallet",
        style: TextStyle(
          fontSize: 16,
          color: widget.walletIsConnected ? Colors.green : Colors.red,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
