import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({Key? key}) : super(key: key);

  @override
  _AnimatedHeartState createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _shakeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.05, 0), // Getaran horizontal
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateHeart() {
    _controller
        .forward()
        .then((value) => _controller.reverse()); // Gerakan maju mundur
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animateHeart,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SlideTransition(
          position: _shakeAnimation,
          child: const Center(
            child: Icon(
              Icons.favorite,
              color: Colors.black,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}
