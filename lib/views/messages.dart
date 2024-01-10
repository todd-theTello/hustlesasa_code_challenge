import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hustlesasa_code_challenge/utils/color.dart';
import 'package:hustlesasa_code_challenge/utils/space.dart';
import 'package:hustlesasa_code_challenge/widgets/circle_container.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
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
        title: const Text(
          'Pedro Pascal',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'GT Walsheim Pro',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Center(
                      child: Text(
                    'Today',
                    style: TextStyle(
                      color: Color(0xFF626266),
                      fontSize: 10,
                      fontFamily: 'GT Walsheim Pro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ));
                }
                return (index % 2 == 0)
                    // Todo: optimize this code
                    ? Align(
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
                                    child: const Text(
                                      "Hi, I would like to know how long it dhdjhdhdjdj djdjdjjdjd",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'GT Walsheim Pro',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                kHorizontalSpace14,
                                const CircleContainer(
                                  color: Color(0xFFFFE0D3),
                                  padding: EdgeInsets.all(8),
                                  child: Text('PP'),
                                ),
                              ],
                            ),
                            kVerticalSpace6,
                            Text(
                              '11:55 PM',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6000000238418579),
                                fontSize: 10,
                                fontFamily: 'GT Walsheim Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircleContainer(
                                  color: Color(0xFFFFE0D3),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'PP',
                                    style: TextStyle(
                                      color: Color(0xFFC57754),
                                      fontSize: 14,
                                      fontFamily: 'GT Walsheim Pro',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
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
                                          someString,
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.800000011920929),
                                            fontSize: 14,
                                            fontFamily: 'GT Walsheim Pro',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            kVerticalSpace6,
                            Text(
                              '11:55 PM',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6000000238418579),
                                fontSize: 10,
                                fontFamily: 'GT Walsheim Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      );
              },
              separatorBuilder: (context, index) {
                return kVerticalSpace12;
              },
              itemCount: 5,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a reply...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/attach.svg'),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.black.withOpacity(0.1),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/send-filled.svg'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OtherChatBubble extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    double width = size.width;
    double height = size.height;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(16, 8)
      ..lineTo(width - 20, 8)
      ..quadraticBezierTo(width, 8, width, 28)
      ..lineTo(width, height - 20)
      ..quadraticBezierTo(width, height, width - 20, height)
      ..lineTo(20, height)
      ..quadraticBezierTo(0, height, 0, height - 20)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyChatBubble extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill;

    double width = size.width;
    double height = size.height;

    Path path = Path()
      ..moveTo(width, height)
      ..lineTo(width - 16, height - 8)
      ..lineTo(20, height - 8)
      ..quadraticBezierTo(0, height - 8, 0, height - 28)
      ..lineTo(0, 20)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..lineTo(width - 20, 0)
      ..quadraticBezierTo(width, 0, width, 20)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

const String someString =
    "Hi, I would like to know how long it takes to get products delivered to Nairobi, I just ordered the Love Fest & Harmony hood?";
