import 'dart:convert';

import 'package:flutter_celo_composer/abis/cusd_contract_abi.dart';
import 'package:reown_appkit/reown_appkit.dart';

final cUSDContractAlfajores = DeployedContract(
  ContractAbi.fromJson(
    jsonEncode(cUSDContractABI), // ABI object
    'Celo Dollar',
  ),
  EthereumAddress.fromHex('0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1'),
);
