import 'package:flutter/material.dart';

class Circulo extends StatefulWidget {
  Function() onTap;
  bool animar;
  Circulo({super.key, required this.animar, required this.onTap});

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

    _sizeAnimation = Tween<double>(begin: 60.0, end: 100.0).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Cuando la animación crecimiento está completa, espera 1 segundo y realiza la animación de reducción.
        Future.delayed(Duration(microseconds: 500), () {
          if(widget.animar) _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // Cuando la animación de reducción está completa, espera 1 segundo y reinicia la animación de crecimiento.
        Future.delayed(Duration(microseconds: 500), () {
          if(widget.animar) _controller.forward();
        });
      }
    });
    if(widget.animar) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant Circulo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animar != widget.animar) {
      if (widget.animar) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return InkWell(
              onTap: widget.onTap,
              child: Container(
                height: _sizeAnimation.value,
                width: _sizeAnimation.value,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.animar ? Icons.settings_voice_rounded : Icons.keyboard_voice_sharp, size: 40,),
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
