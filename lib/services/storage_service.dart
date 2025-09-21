// services/storage_service.dart

import 'package:hive_flutter/hive_flutter.dart';
import '../models/message.dart';

class StorageService {
  static const String _messagesBoxName = 'messages';
  static Box? _messagesBox;

  static Future<void> init() async {
    _messagesBox = await Hive.openBox(_messagesBoxName);
  }

  static List<Message> getMessages() {
    if (_messagesBox == null) return [];

    final List<Message> messages = [];
    for (int i = 0; i < _messagesBox!.length; i++) {
      final messageData = _messagesBox!.getAt(i);
      if (messageData != null && messageData is Map) {
        // Convert dynamic Map to Map<String, dynamic>
        final Map<String, dynamic> typedMap = Map<String, dynamic>.from(
          messageData,
        );
        messages.add(Message.fromMap(typedMap));
      }
    }
    return messages;
  }

  static Future<void> addMessage(Message message) async {
    if (_messagesBox != null) {
      await _messagesBox!.add(message.toMap());
    }
  }

  static Future<void> clearAll() async {
    if (_messagesBox != null) {
      await _messagesBox!.clear();
    }
  }

  static Future<void> close() async {
    if (_messagesBox != null) {
      await _messagesBox!.close();
    }
  }
}
