import 'package:flutter/cupertino.dart';

import '../../models/messages.dart';

part 'messages_state.dart';

/// Messages controller
class MessagesController extends ValueNotifier<MessagesState> {
  /// constructor
  MessagesController() : super(MessagesInitial());

  /// sends a new message
  Future<void> newMessage({required List<Message> oldMessages, required Message newMessage}) async {
    value = MessagesLoading(messages: oldMessages);

    Future.delayed(const Duration(seconds: 2), () {
      value = MessagesSuccess(messages: [...oldMessages, newMessage]);
    });
  }
}
