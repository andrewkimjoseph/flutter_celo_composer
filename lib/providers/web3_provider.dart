import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AppKitModalState {
  final ReownAppKitModal modal;
  final bool isConnected;
  final bool isInitialized;

  AppKitModalState({
    required this.modal,
    this.isConnected = false,
    this.isInitialized = false,
  });

  AppKitModalState copyWith({
    ReownAppKitModal? modal,
    bool? isConnected,
    bool? isInitialized,
  }) {
    return AppKitModalState(
      modal: modal ?? this.modal,
      isConnected: isConnected ?? this.isConnected,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class AppKitModalNotifier extends StateNotifier<AppKitModalState> {
  final BuildContext context;

  AppKitModalNotifier(this.context)
      : super(AppKitModalState(modal: _create(context))) {
    _addSupportedNetworks();
    _subscribeToEvents();
  }

  static ReownAppKitModal _create(BuildContext context) {
    return ReownAppKitModal(
      context: context,
      projectId: 'b7fc418c37aea6c627ea82b4f2c8f1e3',
      metadata: const PairingMetadata(
        name: 'Flutter Celo Composer',
        description: 'A Composer for Flutter Web3 dApps',
        url: 'https://andrewkimjoseph.xyz/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'flutter-celo-composer://',
          linkMode: true,
        ),
      ),
      featuredWalletIds: {
        'ef333840daf915aafdc4a004525502d6d49d77bd9c65e0642dbaefb3c2893bef'
      },
    );
  }

  Future<void> init() async {
    try {
      if (!state.modal.status.isInitialized) {
        if (kDebugMode) {
          debugPrint("🟠 Initializing kit ...");
        }

        await state.modal.init();

        state = state.copyWith(isInitialized: true);

        if (kDebugMode) {
          debugPrint("🟢 Kit initialized successfully.");
        }
      } else {
        if (kDebugMode) {
          debugPrint("🟢 Kit already initialized.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
            "⛔ Initialization error: ${(e as ReownAppKitModalException).message}");
      }
    }
  }

  void _subscribeToEvents() {
    // Also subscribe to specific events if needed
    state.modal.onModalConnect.subscribe(_onModalConnect);
    state.modal.onModalDisconnect.subscribe(_onModalDisconnect);
  }

  void _onModalConnect(ModalConnect? event) {
    if (kDebugMode) {
      debugPrint("🟢 Modal connected");
    }

    // Close the modal after connection
    state.modal.closeModal();

    state = state.copyWith(
        isConnected: true,
        // Optionally reset initialization if needed
        isInitialized: true);
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    if (kDebugMode) {
      debugPrint("🔴 Modal disconnected");
    }

    state = state.copyWith(isConnected: false);
  }

  @override
  void dispose() {
    state.modal.onModalConnect.unsubscribe(_onModalConnect);
    state.modal.onModalDisconnect.unsubscribe(_onModalDisconnect);

    super.dispose();
  }

  void _addSupportedNetworks() {
    ReownAppKitModalNetworks.addSupportedNetworks('eip155', [
      ReownAppKitModalNetworkInfo(
        name: 'Celo Alfajores Testnet',
        chainId: '44787',
        currency: 'CELO',
        rpcUrl: 'https://alfajores-forno.celo-testnet.org',
        explorerUrl: 'https://celo-alfajores.blockscout.com/',
      ),
    ]);
  }
}

final appKitModalProvider = StateNotifierProvider.family<AppKitModalNotifier,
    AppKitModalState, BuildContext>(
  (ref, context) => AppKitModalNotifier(context),
);