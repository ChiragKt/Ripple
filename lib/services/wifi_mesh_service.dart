import 'dart:async';
import 'dart:convert';
import 'dart:io';

class WifiMeshService {
  final int port;
  RawDatagramSocket? _socket;
  final StreamController<String> _incomingMessagesController =
      StreamController.broadcast();

  Stream<String> get incomingMessages => _incomingMessagesController.stream;

  WifiMeshService({this.port = 4567});

  Future<void> start() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    _socket!.broadcastEnabled = true;

    _socket!.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = _socket!.receive();
        if (datagram != null) {
          final message = utf8.decode(datagram.data);
          print("Received message: $message from ${datagram.address.address}");
          _incomingMessagesController.add(message);
        }
      }
    });

    print("WiFi Mesh listening on port $port");
  }

  void sendMessage(String message) {
    if (_socket == null) return;

    final data = utf8.encode(message);
    final broadcastAddress = InternetAddress("255.255.255.255");
    _socket!.send(data, broadcastAddress, port);
    print("Sent message over WiFi: $message");
  }

  void dispose() {
    _incomingMessagesController.close();
    _socket?.close();
  }
}
