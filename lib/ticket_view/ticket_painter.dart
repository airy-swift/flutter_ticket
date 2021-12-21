part of 'ticket_view.dart';

class TicketPainter extends CustomPainter {
  final bool isTopPunch;
  final Color color;

  TicketPainter({
    required this.isTopPunch,
    required this.color,
  });

  const TicketPainter.topPunch({
    required this.color,
  }) : isTopPunch = true;

  const TicketPainter.bottomPunch({
    required this.color,
  }) : isTopPunch = false;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _drawPath(size);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    final shadow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
      ..color = const Color.fromRGBO(0, 0, 0, 0.4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    // 影
    canvas.drawPath(path.shift(const Offset(1, 1)), shadow);
    // body
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Path _drawPath(Size size) {
    // 端の切り取り部分の幅
    final bigRadius = size.width * 0.045;
    // 穴が取りうる範囲幅
    final dotsField = size.width - bigRadius * 2;
    // 穴の個数
    const count = 17;
    // 穴の半径: dotの数 * (dot間のスペース(半径) + dot直径) + dotのxが左端ではなく中心なので半径分+1する
    final dotsRadius = dotsField / (count * 3 + 1);
    // 穴のx軸リスト
    final dotsXList = List.generate(count, (index) => (bigRadius + dotsRadius * 2) + index * dotsRadius * 3);
    // 穴のy軸の値
    final double dotY = isTopPunch ? 0 : size.height;

    final path = Path();

    final triangleRad = bigRadius * 2 / 3;
    // 左端描画
    path.moveTo(0, dotY);
    path.lineTo(0, dotY + (isTopPunch ? triangleRad : -triangleRad));
    path.lineTo(bigRadius * 2 / 3, dotY);
    path.close();

    // 右端描画
    path.moveTo(size.width, dotY);
    path.lineTo(size.width, dotY + (isTopPunch ? triangleRad : -triangleRad));
    path.lineTo(size.width - bigRadius, dotY);
    path.close();

    // 穴の半円描画
    for (final x in dotsXList) {
      path.addArc(
        Rect.fromCircle(center: Offset(x, dotY), radius: dotsRadius),
        isTopPunch ? 0 : math.pi,
        math.pi,
      );
    }

    // 全体反転描画
    final topCornerRadius = isTopPunch ? const Radius.circular(0) : const Radius.circular(8);
    final bottomCornerRadius = isTopPunch ? const Radius.circular(8) : const Radius.circular(0);

    return path
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
        topLeft: topCornerRadius,
        topRight: topCornerRadius,
        bottomLeft: bottomCornerRadius,
        bottomRight: bottomCornerRadius,
      ))
      ..fillType = PathFillType.evenOdd;
  }
}

class TicketHorizontalPainter extends CustomPainter {
  final bool isRightPunch;
  final Color color;

  TicketHorizontalPainter({
    required this.isRightPunch,
    required this.color,
  });

  const TicketHorizontalPainter.rightPunch({
    required this.color,
  }) : isRightPunch = false;

  const TicketHorizontalPainter.leftPunch({
    required this.color,
  }) : isRightPunch = true;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _drawPath(size);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    final shadow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
      ..color = const Color.fromRGBO(0, 0, 0, 0.4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    // 影
    canvas.drawPath(path.shift(const Offset(1, 1)), shadow);
    // body
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Path _drawPath(Size size) {
    // 端の切り取り部分の幅
    final bigRadius = size.height * 0.045;
    // 穴が取りうる範囲幅
    final dotsField = size.height - bigRadius * 2;
    // 穴の個数
    const count = 17;
    // 穴の半径: dotの数 * (dot間のスペース(半径) + dot直径) + dotのxが左端ではなく中心なので半径分+1する
    final dotsRadius = dotsField / (count * 3 + 1);
    // 穴のx軸リスト
    final double dotX = isRightPunch ? 0 : size.width;
    // 穴のy軸の値
    final dotsYList = List.generate(count, (index) => (bigRadius + dotsRadius * 2) + index * dotsRadius * 3);

    final path = Path();

    final triangleRad = bigRadius * 2 / 3;
    // 上端描画
    path.moveTo(dotX, 0);
    path.lineTo(dotX + (isRightPunch ? triangleRad : -triangleRad), 0);
    path.lineTo(dotX, bigRadius * 2 / 3);
    path.close();

    // 下端描画
    path.moveTo(dotX, size.height);
    path.lineTo(dotX + (isRightPunch ? triangleRad : -triangleRad), size.height);
    path.lineTo(dotX, size.height - bigRadius);
    path.close();

    // 穴の半円描画
    for (final y in dotsYList) {
      path.addArc(
        Rect.fromCircle(center: Offset(dotX, y), radius: dotsRadius),
        isRightPunch ? -(0.5 * math.pi) : 0.5 * math.pi,
        1.0 * math.pi,
      );
    }

    // 全体反転描画
    final topCornerRadius = isRightPunch ? const Radius.circular(0) : const Radius.circular(8);
    final bottomCornerRadius = isRightPunch ? const Radius.circular(8) : const Radius.circular(0);

    return path
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
        topLeft: topCornerRadius,
        topRight: bottomCornerRadius,
        bottomLeft: topCornerRadius,
        bottomRight: bottomCornerRadius,
      ))
      ..fillType = PathFillType.evenOdd;
  }
}
