import 'package:flutter_celo_composer/constants/contracts/cusd_contract_alfajores.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:flutter_celo_composer/constants/contracts/cusd_contract_mainnet.dart';

class CeloComposerServices {
  static BigInt cUSDDecimalPlaces = BigInt.from(1000000000000000000);

  static Future<double> checkcUSDBalanceMainnet(
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

    if (balanceOf.isEmpty) return double.parse('0');

    final cUSDBalanceBigInt =
        BigInt.from(int.parse(balanceOf.first.toString()));

    final cUSDBalance =
        BigInt.from(cUSDBalanceBigInt / cUSDDecimalPlaces).toDouble();

    return cUSDBalance;
  }

  static Future<double> checkcUSDBalanceAlfajores(
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

    if (balanceOf.isEmpty) return double.parse('0');

    final cUSDBalanceBigInt =
        BigInt.from(int.parse(balanceOf.first.toString()));

    final cUSDBalance =
        BigInt.from(cUSDBalanceBigInt / cUSDDecimalPlaces).toDouble();

    return cUSDBalance;
  }
}
