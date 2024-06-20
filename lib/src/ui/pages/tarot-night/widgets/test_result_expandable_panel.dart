import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TarotNightTestResultExpandablePanel extends StatefulWidget {
  const TarotNightTestResultExpandablePanel(
      {super.key,
      required this.isFirstElement,
      required this.isLastElement,
      required this.header,
      required this.body});

  final bool isFirstElement;
  final bool isLastElement;
  final String header;
  final String body;

  @override
  State<TarotNightTestResultExpandablePanel> createState() =>
      _TarotNightTestResultExpandablePanelState();
}

class _TarotNightTestResultExpandablePanelState
    extends State<TarotNightTestResultExpandablePanel>
    with TickerProviderStateMixin {
  // control the state of the animation
  late final AnimationController _controller;

  // animation that generates value depending on tween applied
  late final Animation<double> _animation;

  // define the begin and the end value of an animation
  late final Tween<double> _sizeTween;

  late final Animation<Color?> _colorTween;

  // expansion state
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);
    _colorTween = ColorTween(
            begin: const Color.fromARGB(255, 102, 75, 125),
            end: const Color.fromARGB(255, 241, 198, 255))
        .animate(_controller);

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
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => Column(
              children: [
                GestureDetector(
                    onTap: _expandOnChanged,
                    child: Stack(
                      children: [
                        if (!widget.isLastElement)
                          Container(
                            height: 65,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: widget.isFirstElement
                                      ? BorderSide(
                                          color: _colorTween.value!, width: 2)
                                      : BorderSide.none,
                                  left: BorderSide(
                                      color: _colorTween.value!, width: 2),
                                  right: BorderSide(
                                      color: _colorTween.value!, width: 2),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        widget.isFirstElement ? 16 : 0),
                                    topRight: Radius.circular(
                                        widget.isFirstElement ? 16 : 0))),
                          ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border(
                                top: widget.isFirstElement
                                    ? BorderSide(
                                        color: _colorTween.value!, width: 2)
                                    : BorderSide.none,
                                bottom: _isExpanded
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: _colorTween.value!, width: 2),
                                left: BorderSide(
                                    color: _colorTween.value!, width: 2),
                                right: BorderSide(
                                    color: _colorTween.value!, width: 2),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      widget.isFirstElement ? 16 : 0),
                                  topRight: Radius.circular(
                                      widget.isFirstElement ? 16 : 0),
                                  bottomLeft:
                                      Radius.circular(_isExpanded ? 0 : 16),
                                  bottomRight:
                                      Radius.circular(_isExpanded ? 0 : 16))),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                        opacity: _isExpanded ? 0.6 : 0.4,
                                        child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          width: 20,
                                          height: 20,
                                        )),
                                    const SizedBox(width: 8),
                                    Text(widget.header,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(width: 8),
                                    Opacity(
                                        opacity: _isExpanded ? 0.6 : 0.4,
                                        child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          width: 20,
                                          height: 20,
                                        ))
                                  ])
                            ],
                          ),
                        )
                      ],
                    )),
                SizeTransition(
                    axisAlignment: 0,
                    sizeFactor: _sizeTween.animate(_animation),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (!widget.isLastElement)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                  color: Color.fromARGB(255, 102, 75, 125),
                                  width: 2),
                              right: BorderSide(
                                  color: Color.fromARGB(255, 102, 75, 125),
                                  width: 2),
                            )),
                          ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 241, 198, 255),
                                    width: 2),
                                left: BorderSide(
                                    color: Color.fromARGB(255, 241, 198, 255),
                                    width: 2),
                                right: BorderSide(
                                    color: Color.fromARGB(255, 241, 198, 255),
                                    width: 2),
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16))),
                          child: Text(widget.body,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        )
                      ],
                    )),
              ],
            ));
  }
}
