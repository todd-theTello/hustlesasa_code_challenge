part of 'message_bubble.dart';

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
