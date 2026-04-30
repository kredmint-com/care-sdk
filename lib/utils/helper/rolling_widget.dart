import 'package:flutter/material.dart';

import '../../app/themes/styles.dart';

class RollingWidget extends StatefulWidget {
  const RollingWidget({
    super.key,
    required this.discountedPrice,
    required this.originalPrice,
  });

  final int discountedPrice;
  final int originalPrice;

  @override
  State<RollingWidget> createState() => _RollingWidgetState();
}

class _RollingWidgetState extends State<RollingWidget>
    with TickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 500);

  late final int _start;

  late AnimationController _controller;
  late Animation<double> _animation;

  // gap between current and next digit
  final double gap = 6.0;

  @override
  void initState() {
    super.initState();

    // Start = "123..." up to same length as end
    _start = widget.originalPrice;

    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startStr =
        _start.toString().padLeft(widget.discountedPrice.toString().length, '0');
    final endStr = widget.discountedPrice.toString();
    //
    // // measure digit height once (for clipping box)
    // final textPainter = TextPainter(
    //   text: TextSpan(
    //     text: "0",
    //     style: Styles.tsBlack3BSemiBold24(
    //       fontFeatures: [FontFeature.tabularFigures()],
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // )..layout();
    final digitHeight = 28.0;

    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(endStr.length, (i) {
              int startDigit = int.parse(startStr[i]);
              debugPrint("End string data :${startStr[i]} .... ${endStr[i]}");
              int endDigit = int.parse(endStr[i]);

              int distance = (endDigit - startDigit) % 10;

              double value = _animation.value * distance;
              int current = (startDigit + value.floor()) % 10;
              int next = (current + 1) % 10;
              double t = value - value.floor();

              if (_animation.isCompleted) {
                return _digitText(endDigit, digitHeight);
              }

              bool isFirstDigit = i == 0;

              return ClipRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isFirstDigit) ...[
                      // bottom → top
                      Transform.translate(
                        offset: Offset(0, -(digitHeight + gap) * t),
                        child: _digitText(current, digitHeight),
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, digitHeight + gap - (digitHeight + gap) * t),
                        child: _digitText(next, digitHeight),
                      ),
                    ] else ...[
                      // top → bottom
                      Transform.translate(
                        offset: Offset(0, (digitHeight + gap) * t),
                        child: _digitText(current, digitHeight),
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, -(digitHeight + gap) + (digitHeight + gap) * t),
                        child: _digitText(next, digitHeight),
                      ),
                    ],
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _digitText(int digit, double digitHeight) {
    return Text(
      "$digit",
      style: Styles.tsBlack3BSemiBold24(
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }
}
