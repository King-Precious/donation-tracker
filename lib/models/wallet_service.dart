import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WalletService {
  late WalletConnect connector;
  late String _uri;

  WalletService() {
    // Initialize the connector with a bridge and a unique URI
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'Donation Tracker App',
        description: 'A transparent donation platform.',
        url: 'https://donationtracker.com',
        icons: ['https://donationtracker.com/logo.png'],
      ),
    );
  }

  Future<void> connectWallet(BuildContext context) async {
    // Check if the connector is already connected
    if (!connector.connected) {
      // Create a new session and get the URI
      final session = await connector.createSession(
        chainId: 4, // Example: Rinkeby Test Network
        onDisplayUri: (uri) async {
          uri = _uri;
          // You need to open this URI for the user to connect
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        },
      );
      print('Wallet connected: ${session.accounts.first}');
    }
  }

  Future<void> dispose() async {
    // Disconnect the session when no longer needed
    if (connector.connected) {
      await connector.killSession();
    }
  }

  // A method to get the connected address
  String? getConnectedAddress() {
    if (connector.connected) {
      return connector.session.accounts.first;
    }
    return null;
  }
}