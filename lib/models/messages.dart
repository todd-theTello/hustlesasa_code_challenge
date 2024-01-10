import 'package:flutter/material.dart';

@immutable

/// Messages entity
class Message {
  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.sentTime,
    required this.content,
  });
  final String id;
  final String senderId;
  final String senderName;
  final String senderImage;
  final String content;
  final DateTime sentTime;

  @override
  bool operator ==(covariant Message other) => identical(this, other) || (id == other.id);

  @override
  int get hashCode => Object.hash(id, senderId);
}
