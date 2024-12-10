import 'dart:convert';

import 'package:flutter_celo_composer/abis/cusd_contract_abi.dart';
import 'package:reown_appkit/reown_appkit.dart';

final cUSDContract = DeployedContract(
  ContractAbi.fromJson(
    jsonEncode(cUSDContractABI), // ABI object
    'Celo Dollar',
  ),
  EthereumAddress.fromHex('0x765DE816845861e75A25fCA122bb6898B8B1282a'),
);
