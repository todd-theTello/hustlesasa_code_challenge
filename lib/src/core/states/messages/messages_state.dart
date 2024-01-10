part of 'messages_controller.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {
  MessagesLoading({required this.messages});
  final List<Message> messages;
}

class MessagesSuccess extends MessagesState {
  MessagesSuccess({required this.messages});
  final List<Message> messages;
}

class MessagesFailure extends MessagesState {
  MessagesFailure({required this.error});
  final String error;
}
