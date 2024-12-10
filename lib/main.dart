import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'providers/modal_provider.dart';
import 'services/check_cusd_balance.dart';
import 'widgets/custom_alert.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appKitModalAsync = ref.watch(appKitModalProvider(context));
    final connectionStatusAsync = ref.watch(appKitConnectionProvider(context));

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/celo-long-form-logo.svg",
          semanticsLabel: 'Celo Logo',
          width: 100,
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        actions: [
          appKitModalAsync.when(
            data: (appKitModal) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: AppKitModalConnectButton(appKit: appKitModal),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: appKitModalAsync.when(
        data: (appKitModal) {
          return connectionStatusAsync.when(
            data: (isConnected) => Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      isConnected ? 'Connected to Wallet' : 'Not Connected',
                      style: TextStyle(
                        color: isConnected ? Colors.green : Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isConnected) ...[
                    AppKitModalNetworkSelectButton(appKit: appKitModal),
                    const SizedBox(height: 10),
                    AppKitModalAccountButton(
                      appKitModal: appKitModal,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final balance = await checkcUSDBalance(appKitModal);

                          if (context.mounted) {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return CustomPopUpWidget(
                                  popUpText: "Your cUSD Balance is $balance",
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Check cUSD Balance'))
                  ],
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error initializing: $error')),
      ),
    );
  }
}
