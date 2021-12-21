import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

part 'ticket_painter.dart';
part 'ticket_parts.dart';

typedef ConfirmCallBack = Future<bool> Function();

class TicketView extends StatefulWidget {
  const TicketView({
    required this.topChild,
    required this.bottomChild,
    this.widthFactor = 0.9,
    this.baseColor = Colors.white,
    this.isHorizontal = false,
  });

  // ticketの幅率
  final double widthFactor;
  // ticketの色
  final Color baseColor;
  // ticketの上部
  final Widget topChild;
  // ticketの下部
  final Widget bottomChild;
  // ticket縦バージョンか横バージョンか
  final bool isHorizontal;

  @override
  TicketViewState createState() => TicketViewState();
}

class TicketViewState extends State<TicketView> with TickerProviderStateMixin {
  TicketViewState();

  late bool isUsed;

  @override
  void initState() {
    super.initState();
    setState(() => isUsed = false);
  }

  @override
  Widget build(BuildContext context) {
    /// 雑すぎすみません
    if (widget.isHorizontal) {
      return FractionallySizedBox(
        widthFactor: widget.widthFactor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicketLeft(widget.topChild, widget.baseColor),
            Gap(isUsed ? 40 : 0),
            GestureDetector(
              onTap: () => setState(() => isUsed = !isUsed),
              child: Stack(
                children: [
                  TicketRight(
                    widget.bottomChild,
                    widget.baseColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return FractionallySizedBox(
      widthFactor: widget.widthFactor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TicketTop(widget.topChild, widget.baseColor),
          Gap(isUsed ? 40 : 0),
          GestureDetector(
            onTap: () => setState(() => isUsed = !isUsed),
            child: Stack(
              children: [
                TicketBottom(
                  widget.bottomChild,
                  widget.baseColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
