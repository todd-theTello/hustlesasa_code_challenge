import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main.dart';
import '../../../models/messages.dart';
import '../../../states/messages/messages_controller.dart';
import '../../../utils/extensions.dart';
import '../../../utils/platform/image.dart';
import '../../../utils/space.dart';
import '../theme/text_styles.dart';
import '../widgets/message_bubbles/message_bubble.dart';

/// Messages view
class MessageView extends StatefulWidget {
  /// constructor
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final MessagesController messagesController;
  final messageController = TextEditingController();
  final ValueNotifier<XFile?> image = ValueNotifier(null);
  @override
  void didChangeDependencies() {
    messagesController = MessagesController();
    super.didChangeDependencies();
  }

  Future<void> sendMessage(String newMessage, {required List<Message> oldMessages, File? image}) async {
    final message = Message(
      id: generateRandomString(13),
      senderId: generateRandomString(4),
      senderName: 'Todd Nelson',
      senderImage:
          'https://imgs.search.brave.com/_2Si-fik-7zpDi1G_iBHPqbToNO2nLrmt0KN1P-WpWo/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9sYXN0/Zm0uZnJlZXRscy5m/YXN0bHkubmV0L2kv/dS9hdmF0YXIxNzBz/L2JjOWFjYjMwNGZk/MGMyOTQyMDczZTAz/ODNkYWVhNTk1',
      sentTime: DateTime.now(),
      isMe: true,
      content: newMessage,
      image: image,
    );
    await messagesController.newMessage(oldMessages: oldMessages, newMessage: message);
    Future.delayed(const Duration(seconds: 1), () {
      messagesController.newMessage(
        oldMessages: [...oldMessages, message],
        newMessage: Message(
          id: generateRandomString(13),
          senderId: generateRandomString(4),
          senderName: 'Todd Nelson',
          senderImage:
              'https://imgs.search.brave.com/-CYhRuvR9NL4O3AnAjbiFyL53_tZ2cR8geBEgcY5xd0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5waXRjaGZvcmsu/Y29tL3Bob3Rvcy81/Yjk5MTVkMDkyMWQx/YzQwYjI2NGJiNmYv/MjoxL3dfMzIwLzZM/QUNLLmpwZw',
          sentTime: DateTime.now(),
          isMe: false,
          content: 'This is a random generated message as a reply for text $newMessage  ${generateRandomString(9)}',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62,
        backgroundColor: const Color(0xFFF7F7F7),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Pedro Pascal'),
      ),
      body: ValueListenableBuilder(
          valueListenable: messagesController,
          builder: (context, messages, _) {
            return Column(
              children: [
                if (messages is MessagesLoading) ...[
                  const LinearProgressIndicator(),
                  Expanded(
                    child: ListView.separated(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Center(child: Text('Today', style: kCardTimeStamp));
                        }
                        final message = messages.messages[index - 1];
                        return MessageBubble(message: message);
                      },
                      separatorBuilder: (context, index) {
                        return kVerticalSpace12;
                      },
                      itemCount: messages.messages.length + 1,
                    ),
                  )
                ],
                if (messages is MessagesSuccess)
                  Expanded(
                    child: ListView.separated(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Center(child: Text('Today', style: kCardTimeStamp));
                        }
                        final message = messages.messages[index - 1];
                        return MessageBubble(message: message);
                      },
                      separatorBuilder: (context, index) {
                        return kVerticalSpace12;
                      },
                      itemCount: messages.messages.length + 1,
                    ),
                  )
                else if (messages is MessagesInitial)
                  const SizedBox().expanded,
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Color(0x19000000), blurRadius: 10, offset: Offset(0, 0), spreadRadius: 0),
                    ],
                  ),
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: image,
                          builder: (context, imageFile, _) {
                            if (imageFile == null) return const SizedBox.shrink();
                            return ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 200),
                                child: Image.file(File(imageFile.path)));
                          }),
                      Row(
                        children: [
                          TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: 'Write a reply...',
                              contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                              border: InputBorder.none,
                            ),
                          ).expanded,
                          IconButton(
                            onPressed: () async {
                              image.value = await ImagePickerUtil.openGallery();
                            },
                            icon: SvgPicture.asset('assets/images/attach.svg'),
                          ),
                          Container(
                            width: 1,
                            height: 24,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          IconButton(
                            onPressed: () {
                              if (messageController.text.trim().isNotEmpty) {
                                if (messages is MessagesSuccess) {
                                  sendMessage(
                                    messageController.text,
                                    oldMessages: messages.messages,
                                    image: image.value == null ? null : File(image.value!.path),
                                  );
                                } else {
                                  sendMessage(
                                    messageController.text,
                                    oldMessages: [],
                                    image: image.value == null ? null : File(image.value!.path),
                                  );
                                }
                                messageController.clear();
                                image.value = null;
                              }
                            },
                            icon: SvgPicture.asset('assets/images/send-filled.svg'),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
