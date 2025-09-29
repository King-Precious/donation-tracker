import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';
// import 'package:convert/convert.dart'; // for hex.decode
import 'package:web3dart/web3dart.dart'; // for EtherAmount if needed


class WalletService {
  late WalletConnect connector;
  late String _uri;

  // Provider for sending transactions
  late EthereumWalletConnectProvider provider;

  WalletService() {
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'Donation Tracker App',
        description: 'A transparent donation platform.',
        url: 'https://donationtracker.com',
        icons: ['https://donationtracker.com/logo.png'],
      ),
    );

    provider = EthereumWalletConnectProvider(connector);
  }

  /// Connect wallet (MetaMask, Trust Wallet, etc.)
  Future<void> connectWallet(BuildContext context) async {
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 1, // Ethereum mainnet (change if you want testnet)
        onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(_uri, mode: LaunchMode.externalApplication);
        },
      );
      print('✅ Wallet connected: ${session.accounts.first}');
    }
  }

  /// Send USDT donation using ERC20 transfer
  Future<String> sendUSDTDonation({
  required String toAddress,   // the beneficiary (NGO) wallet
  required double amount,      // e.g. 10.5 (USDT)
}) async {
  if (!connector.connected || connector.session.accounts.isEmpty) {
    throw Exception('Wallet is not connected. Please connect your wallet first.');
  }

  final String from = connector.session.accounts.first;
  const String usdtContract = '0xdAC17F958D2ee523a2206206994597C13D831ec7'; // mainnet USDT

  // --- convert amount to smallest unit (USDT has 6 decimals) safely ---
  final int units = (amount * 1e6).round(); // use round() to avoid float truncation
  final BigInt usdtAmount = BigInt.from(units);

  // --- encode ERC20 transfer(to, uint256) ---
  final String toNoPrefix = toAddress.replaceFirst('0x', '');
  final String amountHex = usdtAmount.toRadixString(16).padLeft(64, '0');
  final String dataHex = 'a9059cbb${toNoPrefix.padLeft(64, '0')}$amountHex';
  // convert hex string -> bytes (Uint8List)
  final Uint8List dataBytes = Uint8List.fromList(hex.decode(dataHex));

  // Build tx with correct types: from (String), to (String), data (Uint8List), gas (int), value (BigInt)
  final txToSend = {
    // note: you pass fields separately to provider.sendTransaction (named params)
    // but we keep this map for debugging
    'from': from,
    'to': usdtContract,
    'data': dataHex, // for logging only
    'value': '0x0',
    'gas': 200000,
  };

  try {
    // debug prints — helpful for checking what's being sent
    print('--- USDT TX ---');
    print('from: $from');
    print('contract(to): $usdtContract');
    print('recipient (encoded in data): $toAddress');
    print('amount units: $usdtAmount');
    print('dataHex: 0x$dataHex');

    // IMPORTANT: provider.sendTransaction expects typed params on this version
    final String txHash = await provider.sendTransaction(
      from: from,
      to: usdtContract,
      data: dataBytes,      // Uint8List
      gas: 200000,          // int
      value: BigInt.zero,   // BigInt (no ETH sent)
    );

    print('txHash: $txHash');
    return txHash;
  } catch (e) {
    // include the prepared tx in the error log to help debugging
    throw Exception('USDT Transaction error: $e\nPrepared tx: $txToSend');
  }
}


  /// Disconnect wallet
  Future<void> dispose() async {
    if (connector.connected) {
      await connector.killSession();
    }
  }

  /// Get current connected address
  String? getConnectedAddress() {
    if (connector.connected) {
      return connector.session.accounts.first;
    }
    return null;
  }
}
