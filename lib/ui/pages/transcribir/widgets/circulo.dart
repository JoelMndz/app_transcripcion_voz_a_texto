import 'package:flutter/material.dart';

class Circulo extends StatefulWidget {
  const Circulo({Key? key}) : super(key: key);

  @override
  _CirculoState createState() => _CirculoState();
}

class _CirculoState extends State<Circulo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _sizeAnimation = Tween<double>(begin: 50.0, end: 100.0).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Cuando la animación crecimiento está completa, espera 1 segundo y realiza la animación de reducción.
        Future.delayed(Duration(microseconds: 500), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // Cuando la animación de reducción está completa, espera 1 segundo y reinicia la animación de crecimiento.
        Future.delayed(Duration(microseconds: 500), () {
          _controller.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return Container(
              height: _sizeAnimation.value,
              width: _sizeAnimation.value,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
