import 'package:flutter_celo_composer/constants/chain_ids.dart';
import 'package:flutter_celo_composer/constants/contracts/cusd_contract_alfajores.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:flutter_celo_composer/constants/contracts/cusd_contract_mainnet.dart';

class CeloComposerServices {
  final ReownAppKitModal appKit;
  final EthereumAddress senderWalletAddress;
  static final BigInt cUSDDecimalPlaces = BigInt.from(1000000000000000000);

  CeloComposerServices(this.appKit)
      : senderWalletAddress = EthereumAddress.fromHex(
            appKit.session?.getAddress(NetworkUtils.eip155) ?? '');

  Future<double> checkcUSDBalanceOnMainnet() async {
    final senderWalletAddress = EthereumAddress.fromHex(
        appKit.session!.getAddress(NetworkUtils.eip155)!);

    final balanceOf = await appKit.requestReadContract(
      deployedContract: cUSDContractMainnet,
      topic: appKit.session!.topic,
      chainId: ChainIds.celoMainnet,
      sender: senderWalletAddress,
      functionName: 'balanceOf',
      parameters: [senderWalletAddress],
    );

    if (balanceOf.isEmpty) return double.parse('0');

    final cUSDBalanceBigInt =
        BigInt.from(int.parse(balanceOf.first.toString()));

    final cUSDBalance =
        BigInt.from(cUSDBalanceBigInt / cUSDDecimalPlaces).toDouble();

    return cUSDBalance;
  }

  Future<double> checkcUSDBalanceOnAlfajores() async {
    final senderWalletAddress = EthereumAddress.fromHex(
        appKit.session!.getAddress(NetworkUtils.eip155)!);

    final balanceOf = await appKit.requestReadContract(
      deployedContract: cUSDContractAlfajores,
      topic: appKit.session!.topic,
      chainId: ChainIds.celoAlfajores,
      functionName: 'balanceOf',
      sender: senderWalletAddress,
      parameters: [senderWalletAddress],
    );

    if (balanceOf.isEmpty) return double.parse('0');

    final cUSDBalanceBigInt =
        BigInt.from(int.parse(balanceOf.first.toString()));

    final cUSDBalance =
        BigInt.from(cUSDBalanceBigInt / cUSDDecimalPlaces).toDouble();

    return cUSDBalance;
  }
}
