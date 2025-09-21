class Message {
  final String sender;
  final String content;
  final String? receiver;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.content,
    this.receiver,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'content': content,
      'receiver': receiver,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'] ?? '',
      content: map['content'] ?? '',
      receiver: map['receiver'],
      timestamp: DateTime.parse(
        map['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  @override
  String toString() {
    return 'Message(sender: $sender, content: $content, receiver: $receiver, timestamp: $timestamp)';
  }
}
