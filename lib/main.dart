import 'package:flutter/material.dart';
import 'package:flutter_celo_composer/providers/modal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reown_appkit/reown_appkit.dart';

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
    // You can add any initialization logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    final appKitModalAsync = ref.watch(appKitModalProvider(context));

    return appKitModalAsync.when(
      data: (appKitModal) {
        final connectionStatusAsync =
            ref.watch(appKitConnectionProvider(context));

        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset(
              "assets/celo-long-form-logo.svg",
              semanticsLabel: 'Dart Logo',
              width: 100,
            ),
            backgroundColor: Colors.yellow,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: AppKitModalConnectButton(appKit: appKitModal),
              ),
            ],
          ),
          body: connectionStatusAsync.when(
            data: (isConnected) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isConnected ? 'Connected to Wallet' : 'Not Connected',
                    style: TextStyle(
                      color: isConnected ? Colors.green : Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isConnected) ...[
                    AppKitModalNetworkSelectButton(appKit: appKitModal),
                    const SizedBox(height: 10),
                    AppKitModalAccountButton(
                      appKitModal: appKitModal,
                    ),
                  ],
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error initializing: $error')),
      ),
    );
  }
}
