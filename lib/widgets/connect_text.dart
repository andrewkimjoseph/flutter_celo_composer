import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectText extends ConsumerStatefulWidget {
  const ConnectText(
      {super.key, required this.isInitialized, required this.isConnected});

  final bool isInitialized;
  final bool isConnected;

  @override
  ConsumerState<ConnectText> createState() => _ConnectTextState();
}

class _ConnectTextState extends ConsumerState<ConnectText> {
  @override
  Widget build(BuildContext context) {
    if (widget.isInitialized) {
      return Text(
        widget.isConnected ? "Connected" : "Connect your wallet",
        style: TextStyle(
          fontSize: 16,
          color: widget.isConnected ? Colors.green : Colors.red,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
