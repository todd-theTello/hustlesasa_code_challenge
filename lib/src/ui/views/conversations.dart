import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../utils/color.dart';
import '../../../utils/extensions.dart';
import '../../../utils/extensions/date_time.dart';
import '../../../utils/space.dart';
import '../../core/models/conversation.dart';
import '../../core/models/messages.dart';
import '../../core/states/customers/customer_controller.dart';
import '../theme/text_styles.dart';
import '../widgets/animated_scale.dart';
import '../widgets/circle_container.dart';
import 'customers.dart';
import 'messages.dart';

/// Conversation view
class ConversationsView extends StatelessWidget {
  /// Constructor
  const ConversationsView({required this.controller, super.key});

  /// constructor
  final CustomerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, _) {
          if (value is CustomerLoading) {
            return const SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Center(child: SizedBox(height: 24, width: 24, child: CircularProgressIndicator.adaptive())),
            );
          }

          if (value is CustomerSuccess) {
            final conversations = List.generate(
              value.customers.length,
              (index) => Conversation(
                name: '${value.customers[index].firstName} ${value.customers[index].lastName}',
                lastMessage: DateTime.now().subtract(Duration(days: index)),
                lastConversation: generateRandomString(40),
                image: value.customers[index].avatar,
                uid: generateRandomString(40),
                isRead: !(index % 3 == 0),
                messages: const <Message>[],
              ),
            );
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemBuilder: (context, index) {
                final data = value.customers[index];
                final conversation = conversations[index];
                return CustomAnimatedScale(
                  onPressed: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute(builder: (_) => const MessageView()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Color(0x14212026), blurRadius: 12, offset: Offset(0, 4)),
                        BoxShadow(color: Color(0x14212026), blurRadius: 2)
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageWidget(data: data),
                        kHorizontalSpace12,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    conversation.name,
                                    style: conversation.isRead
                                        ? kCardHeader
                                        : kCardHeader.copyWith(fontWeight: FontWeight.w700),
                                  ).expanded,
                                  Text(
                                    conversation.lastMessage.isToday
                                        ? 'Today'
                                        : conversation.lastMessage.isYesterday
                                            ? 'Yesterday'
                                            : conversation.lastMessage.yMMMEd,
                                    style: conversation.isRead
                                        ? kCardTimeStamp
                                        : kCardTimeStamp.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                              kVerticalSpace12,
                              Text(
                                'Hi, I would like to know how long it takes to get products delivered to Nairobi, I just ordered the Love Fest & Harmony hood?',
                                style: conversation.isRead
                                    ? kCardContent
                                    : kCardContent.copyWith(fontWeight: FontWeight.w700),
                              ),
                              if (!conversation.isRead)
                                Row(
                                  children: [
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleContainer(color: kPrimaryColor, padding: const EdgeInsets.all(4)),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => kVerticalSpace16,
              itemCount: value.customers.length,
            );
          }
          if (value is CustomerFailure) {
            return Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                child: Text(value.error),
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        });
  }
}
