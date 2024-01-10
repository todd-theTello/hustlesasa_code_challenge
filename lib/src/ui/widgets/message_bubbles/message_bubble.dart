import 'package:flutter/material.dart';

import '../../../../models/messages.dart';
import '../../../../utils/color.dart';
import '../../../../utils/space.dart';
import '../../theme/text_styles.dart';
import '../circle_container.dart';

part 'my_chat_bubble_paint.dart';
part 'other_chat_bubble_paint.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.message, super.key});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return switch (message.isMe) {
      true => Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    painter: MyChatBubble(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                      constraints: BoxConstraints(
                        minWidth: 64,
                        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (message.image != null) ...[
                            ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(message.image!)),
                            kVerticalSpace8
                          ],
                          Text(
                            message.content,
                            style: kLabelStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  kHorizontalSpace14,
                  CircleContainer(
                    color: const Color(0xFFFFE0D3),
                    padding: const EdgeInsets.all(8),
                    child: Text(message.senderName.substring(0, 2)),
                  ),
                ],
              ),
              kVerticalSpace6,
              Text(
                TimeOfDay.fromDateTime(message.sentTime).format(context),
                style: kCardTimeStamp.copyWith(color: Colors.black.withOpacity(0.6)),
              )
            ],
          ),
        ),
      false => Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleContainer(
                    color: const Color(0xFFFFE0D3),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'PP',
                      style: kLabelStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFC57754),
                      ),
                    ),
                  ),
                  kHorizontalSpace14,
                  Column(
                    children: [
                      CustomPaint(
                        painter: OtherChatBubble(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                          constraints: BoxConstraints(
                            minWidth: 64,
                            maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                          ),
                          child: Text(
                            message.content,
                            style: kLabelStyle.copyWith(color: Colors.black.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kVerticalSpace6,
              Text(
                TimeOfDay.fromDateTime(message.sentTime).format(context),
                textAlign: TextAlign.right,
                style: kCardTimeStamp.copyWith(color: Colors.black.withOpacity(0.6)),
              )
            ],
          ),
        ),
    };
  }
}
