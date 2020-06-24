import 'dart:async';
import 'package:flutter/material.dart';

class CustomDelayedFadeIn extends StatefulWidget {

  final Duration delay;
  final Widget child;

  CustomDelayedFadeIn({
    @required this.delay,
    @required this.child,
  }): assert(delay != null),
      assert(child != null);

  @override
  _CustomDelayedFadeInState createState() => _CustomDelayedFadeInState();
}

class _CustomDelayedFadeInState extends State<CustomDelayedFadeIn> with TickerProviderStateMixin {

  Animation<Offset> _animOffset;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );

    final CurvedAnimation curve = CurvedAnimation(
      curve: Curves.decelerate, parent: _controller
    );

    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.35),
      end: Offset.zero
    ).animate(curve);

    Timer(widget.delay, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}