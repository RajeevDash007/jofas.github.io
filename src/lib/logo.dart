import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  late final Animation<double> controller;

  @override
  void initState() {
    final c = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(
        reverse: true,
      );

    controller = CurvedAnimation(
      parent: c,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LogoAnimation(controller: controller);
  }
}

class LogoAnimation extends AnimatedWidget {
  LogoAnimation({
    super.key,
    required Animation<double> controller,
  }) : super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LogoPainter(_progress.value),
      size: Size(300, 300),
      willChange: true,
    );
  }
}

class LogoPainter extends CustomPainter {
  final double state;

  LogoPainter(this.state);

  @override
  void paint(Canvas c, Size s) {
    final paint = Paint();
    paint.color = Colors.white;

    final pos = Offset(state * s.width, s.height / 2);

    c.drawCircle(pos, 20, paint);
  }

  @override
  bool shouldRepaint(LogoPainter old) => old.state != state;
}