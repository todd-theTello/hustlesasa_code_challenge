part of 'message_bubble.dart';

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
