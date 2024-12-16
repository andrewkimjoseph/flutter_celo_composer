import 'dart:convert';

import 'package:flutter_celo_composer/abis/erc20.dart';
import 'package:reown_appkit/reown_appkit.dart';

class StablecoinContracts {
  static final cUSDAlfajores = DeployedContract(
    ContractAbi.fromJson(
      jsonEncode(erc20ABI),
      'Celo Dollar',
    ),
    EthereumAddress.fromHex('0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1'),
  );

  static final cUSDMainnet = DeployedContract(
    ContractAbi.fromJson(
      jsonEncode(erc20ABI),
      'Celo Dollar',
    ),
    EthereumAddress.fromHex('0x765DE816845861e75A25fCA122bb6898B8B1282a'),
  );
}
