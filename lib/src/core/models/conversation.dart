import 'package:flutter/material.dart';

import 'messages.dart';

@immutable
class Conversation {
  const Conversation({
    required this.name,
    required this.lastMessage,
    required this.lastConversation,
    required this.image,
    required this.uid,
    required this.messages,
    required this.isRead,
  });
  final String name;
  final DateTime lastMessage;
  final String lastConversation;
  final String image;
  final String uid;
  final List<Message> messages;
  final bool isRead;
  Conversation copyWith({bool? isRead, DateTime? lastMessage, String? lastConversation, List<Message>? messages}) {
    return Conversation(
      name: name,
      lastMessage: lastMessage ?? this.lastMessage,
      lastConversation: lastConversation ?? this.lastConversation,
      image: image,
      uid: uid,
      messages: messages ?? this.messages,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  bool operator ==(covariant Conversation other) => identical(this, other) || (uid == other.uid);

  @override
  int get hashCode => Object.hash(uid, name);
}
