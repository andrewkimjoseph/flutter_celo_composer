import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_appkit/reown_appkit.dart';

final appKitModalProvider =
    FutureProvider.family<ReownAppKitModal, BuildContext>((ref, context) async {
  final appKitModal = ReownAppKitModal(
    context: context,
    projectId: 'b7fc418c37aea6c627ea82b4f2c8f1e3',
    metadata: const PairingMetadata(
      name: 'Flutter Celo Composer',
      description: 'A Composer for Flutter Web3 dApps',
      url: 'https://andrewkimjoseph.xyz/',
      icons: ['https://example.com/logo.png'],
      redirect: Redirect(
        native: 'flutter-celo-composer://',
        universal: 'https://andrewkimjoseph.xyz/flutter-celo-composer',
        linkMode: true, // or false as needed
      ),
    ),
  );

  await appKitModal.init();
  return appKitModal;
});

final appKitConnectionProvider =
    StreamProvider.family<bool, BuildContext>((ref, context) {
  final streamController =
      StreamController<bool>.broadcast(onListen: () {}, onCancel: () {});

  try {
    ref.watch(appKitModalProvider(context).future).then((appKitModal) {
      streamController.add(appKitModal.isConnected);

      appKitModal.onModalConnect.subscribe((_) {
        streamController.add(true);
      });

      appKitModal.onModalDisconnect.subscribe((_) {
        streamController.add(false);
      });
    }).catchError((error) {
      streamController.addError(error);
    });
  } catch (e) {
    streamController.addError(e);
  }

  ref.onDispose(() {
    streamController.close();
  });

  // Return the stream immediately
  return streamController.stream;
});
