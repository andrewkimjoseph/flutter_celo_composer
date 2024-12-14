import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_celo_composer/widgets/connect_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_appkit/appkit_modal.dart';
import '../providers/web3_provider.dart';
import '../widgets/cusd_alfajores_balance_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/progress_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initKit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appKitModalState = ref.watch(appKitModalProvider(context));

    return Scaffold(
      appBar: CustomAppBar(appKit: appKitModalState.modal),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!appKitModalState.isInitialized)
              const CustomProgressIndicator(),
            ConnectText(
              kitIsInitialized: appKitModalState.isInitialized,
              walletIsConnected: appKitModalState.isConnected,
            ),
            Visibility(
                visible: appKitModalState.isConnected,
                child: Column(
                  children: [
                    AppKitModalNetworkSelectButton(
                      appKit: appKitModalState.modal,
                    ),
                    AppKitModalAccountButton(
                      appKitModal: appKitModalState.modal,
                    ),
                    CUSDBalanceButton(
                      appKit: appKitModalState.modal,
                    ),
                    CUSDBalanceButton(
                      appKit: appKitModalState.modal,
                      forTestnet: false,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _initKit() {
    final appKitModalNotifier = ref.read(appKitModalProvider(context).notifier);

    if (!ref.read(appKitModalProvider(context)).isInitialized) {
      if (!ref.read(appKitModalProvider(context)).isConnected) {
        ref.read(appKitModalProvider(context)).modal.closeModal();
      }
      if (kDebugMode) {
        debugPrint("ℹ️ Kit was not already initialized.");
      }
      appKitModalNotifier.init();
    } else {
      if (kDebugMode) {
        debugPrint("ℹ️ Kit was already initialized.");
      }
    }
  }
}
