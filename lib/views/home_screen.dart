import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_celo_composer/services/celo_composer_services.dart';
import 'package:flutter_celo_composer/widgets/custom_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/appkit_modal.dart';
import '../providers/web3_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isCheckingBalance = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appKitModalNotifier =
          ref.read(appKitModalProvider(context).notifier);

      if (!ref.read(appKitModalProvider(context)).isInitialized) {
        if (kDebugMode) {
          debugPrint("ℹ️ Kit was not already initialized.");
        }
        appKitModalNotifier.init();
      } else {
        if (kDebugMode) {
          debugPrint("ℹ️ Kit was already initialized.");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the appKitModalProvider to get the current state
    final appKitModalState = ref.watch(appKitModalProvider(context));

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: SvgPicture.asset(
            "assets/celo-long-form-logo.svg",
            semanticsLabel: 'Celo Logo',
            width: 100,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppKitModalConnectButton(
                size: BaseButtonSize.small,
                appKit: appKitModalState.modal,
                context: context, // Pass the modal from state
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Reactive visibility based on connection state
              if (!appKitModalState.isInitialized)
                const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    )),

              if (appKitModalState.isInitialized)
                Text(
                  appKitModalState.isConnected
                      ? "Connected"
                      : "Connect your wallet",
                  style: TextStyle(
                    fontSize: 16,
                    color: appKitModalState.isConnected
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

              Visibility(
                  visible: appKitModalState.isConnected,
                  child: Column(
                    children: [
                      AppKitModalNetworkSelectButton(
                        appKit:
                            appKitModalState.modal, // Pass the modal from state
                      ),
                      AppKitModalAccountButton(
                        appKitModal:
                            appKitModalState.modal, // Pass the modal from state
                      ),
                    ],
                  )),

              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isCheckingBalance = true;
                      });
                      double balance =
                          await CeloComposerServices.checkcUSDBalanceAlfajores(
                              appKitModalState.modal);

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
                    },
                    child: isCheckingBalance
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ))
                        : const Text("Check cUSD balance on Alfajores")),
              )
            ],
          ),
        ),
      );
    });
  }
}
