class ChainInfo {
  final String name;
  final String chainId;
  final String currencySymbol;
  final String rpcURL;
  final String explorerURL;

  const ChainInfo(
      {required this.name,
      required this.chainId,
      required this.currencySymbol,
      required this.rpcURL,
      required this.explorerURL});
}

class Chains {
  static ChainInfo celoMainnet = const ChainInfo(
      name: 'Celo Mainnet',
      chainId: '42220',
      currencySymbol: 'CELO',
      rpcURL: "https://forno.celo.org",
      explorerURL: "https://celoscan.io/");

  static ChainInfo celoAlfajores = const ChainInfo(
      name: 'Celo Alfajores Testnet',
      chainId: '44787',
      currencySymbol: 'CELO',
      rpcURL: "https://celo-alfajores.blockscout.com/",
      explorerURL: "https://alfajores-forno.celo-testnet.org");
}
