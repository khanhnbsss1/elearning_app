import 'package:flutter/material.dart';

class Sound extends StatefulWidget {
  const Sound({super.key, required this.size, required this.color});

  final double size;
  final Color color;
  @override
  State<Sound> createState() => _SoundState();
}

class _SoundState extends State<Sound> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Icon _icon = const Icon(Icons.volume_down, size: 24);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation.addListener(() {
      if (_animation.value < 0.5) {
        setState(() {
          _icon = Icon(Icons.volume_down, size: widget.size, color: widget.color);
        });
      } else {
        setState(() {
          _icon = Icon(Icons.volume_up, size: widget.size, color: widget.color);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: _icon,
    );
  }
}