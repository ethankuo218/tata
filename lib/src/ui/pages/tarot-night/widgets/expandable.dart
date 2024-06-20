import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  const Expandable({
    super.key,
    this.index = 0,
    required this.header,
    required this.body,
  });

  final int index;
  final Widget header;
  final Widget body;

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  // control the state of the animation
  late final AnimationController _controller;

  // animation that generates value depending on tween applied
  late final Animation<double> _animation;

  // define the begin and the end value of an animation
  late final Tween<double> _sizeTween;

  // expansion state
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);
    super.initState();
  }

  // toggle expandable without setState,
  // so that the widget does not rebuild itself.
  void _expandOnChanged() {
    _isExpanded = !_isExpanded;
    _isExpanded ? _controller.forward() : _controller.reverse();
  }

  // dispose the controller to release it from the memory
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _expandOnChanged,
          child: widget.header,
        ),
        SizeTransition(
          sizeFactor: _sizeTween.animate(_animation),
          child: widget.body,
        ),
      ],
    );
  }
}
