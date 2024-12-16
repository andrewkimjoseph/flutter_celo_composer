class Chain {
  final String name;
  final String chainId;
  final String currencySymbol;
  final String rpcURL;
  final String explorerURL;

  const Chain(
      {required this.name,
      required this.chainId,
      required this.currencySymbol,
      required this.rpcURL,
      required this.explorerURL});
}

class Chains {
  static Chain celoMainnet = const Chain(
      name: 'Celo Mainnet',
      chainId: '42220',
      currencySymbol: 'CELO',
      rpcURL: "https://forno.celo.org",
      explorerURL: "https://celoscan.io/");

  static Chain celoAlfajores = const Chain(
      name: 'Celo Alfajores Testnet',
      chainId: '44787',
      currencySymbol: 'CELO',
      rpcURL: "https://celo-alfajores.blockscout.com/",
      explorerURL: "https://alfajores-forno.celo-testnet.org");

  // Add other chains here
}
