import 'package:flutter_celo_composer/constants/contracts/cusd_contract_alfajores.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:flutter_celo_composer/constants/contracts/cusd_contract_mainnet.dart';

class CeloComposerServices {
  static Future<BigInt> checkcUSDBalanceMainnet(
      ReownAppKitModal appKitModal) async {
    final balanceOf = await appKitModal.requestReadContract(
      deployedContract: cUSDContractMainnet,
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      functionName: 'balanceOf',
      parameters: [
        EthereumAddress.fromHex(
            appKitModal.session!.getAddress(NetworkUtils.eip155)!),
      ],
    );

    if (balanceOf.isEmpty) return BigInt.from(0);

    final cUSDBalance = BigInt.from(balanceOf[0]);

    return cUSDBalance;
  }

  static Future<BigInt> checkcUSDBalanceAlfajores(
      ReownAppKitModal appKitModal) async {
    final balanceOf = await appKitModal.requestReadContract(
      deployedContract: cUSDContractAlfajores,
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      functionName: 'balanceOf',
      parameters: [
        EthereumAddress.fromHex(
            appKitModal.session!.getAddress(NetworkUtils.eip155)!),
      ],
    );

    if (balanceOf.isEmpty) return BigInt.from(0);

    final cUSDBalance = BigInt.from(balanceOf[0]);

    return cUSDBalance;
  }
}

final celoComposerServices = CeloComposerServices();
