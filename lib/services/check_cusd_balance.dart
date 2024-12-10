import 'package:reown_appkit/reown_appkit.dart';
import 'package:flutter_celo_composer/services/cusd_contract.dart';

Future<List> checkcUSDBalance(ReownAppKitModal appKitModal) async {
  final balanceOf = await appKitModal.requestReadContract(
    deployedContract: cUSDContract,
    topic: appKitModal.session!.topic,
    chainId: appKitModal.selectedChain!.chainId,
    functionName: 'balanceOf',
    parameters: [
      EthereumAddress.fromHex(
          appKitModal.session!.getAddress(NetworkUtils.eip155)!),
    ],
  );

  return balanceOf;
}
