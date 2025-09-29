import 'dart:typed_data';

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

// This class acts as the intermediary, telling web3dart to use 
// the WalletConnect provider for signing instead of a local private key.
class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    // This is not used when sending transactions through the provider
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) {
    // This is the key part: it calls the specific WalletConnect method
    // to prompt the user's wallet for transaction signing.
    return provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    // This is not used for eth_sendTransaction
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> sign(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    // This is not used for eth_sendTransaction
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement address
  EthereumAddress get address => throw UnimplementedError();
  
  @override
  MsgSignature signToEcSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }
}