part of 'ticket_view.dart';

class TicketTop extends StatelessWidget {
  const TicketTop(this.child, this.color);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TicketPainter.bottomPunch(color: color),
      child: child,
    );
  }
}

class TicketBottom extends StatelessWidget {
  const TicketBottom(this.child, this.color);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TicketPainter.topPunch(color: color),
      child: child,
    );
  }
}


class TicketRight extends StatelessWidget {
  const TicketRight(this.child, this.color);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TicketHorizontalPainter.leftPunch(color: color),
      child: child,
    );
  }
}

class TicketLeft extends StatelessWidget {
  const TicketLeft(this.child, this.color);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TicketHorizontalPainter.rightPunch(color: color),
      child: child,
    );
  }
}
