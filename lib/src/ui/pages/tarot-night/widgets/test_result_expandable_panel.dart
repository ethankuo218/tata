import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/test_result_view.dart';

class TarotNightTestResultExpandablePanel extends StatefulWidget {
  const TarotNightTestResultExpandablePanel({super.key, required this.data});

  final List<DescriptionItem> data;

  @override
  State<TarotNightTestResultExpandablePanel> createState() =>
      _TarotNightTestResultExpandablePanelState();
}

class _TarotNightTestResultExpandablePanelState
    extends State<TarotNightTestResultExpandablePanel>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.data.length; i++) {
      _controllers.add(AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ));
      _animations.add(CurvedAnimation(
          parent: _controllers[i], curve: Curves.fastOutSlowIn));

      _controllers[i].addListener(() {
        setState(() {});
      });
    }

    _toggleSection(0);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(() {
        setState(() {});
      });
      controller.dispose();
    }

    super.dispose();
  }

  void _toggleSection(int index) {
    if (_controllers[index].isCompleted) {
      return;
    }

    for (var i = 0; i < widget.data.length; i++) {
      if (i != index && _controllers[i].isCompleted) {
        _controllers[i].reverse();
      }
    }

    _controllers[index].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.data.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              final isExpanded = _controllers[index].isCompleted;
              final isLastPanel = index == widget.data.length - 1;
              final isNextPanelExpanded =
                  index + 1 > 3 ? false : _controllers[index + 1].isCompleted;
              final t = _controllers[index].value;

              // Calculate colors based on animation progress
              final headerColor = isExpanded
                  ? Color.lerp(
                      const Color.fromARGB(255, 102, 75, 125),
                      const Color.fromARGB(255, 241, 198, 255),
                      isExpanded ? t : 1 - t, // Reverse for closing
                    )!
                  : Color.lerp(
                      const Color.fromARGB(255, 241, 198, 255),
                      const Color.fromARGB(255, 102, 75, 125),
                      isExpanded ? t : 1 - t, // Reverse for closing
                    )!;

              const borderColor = Color.fromARGB(255, 241, 198, 255);

              return Column(
                children: [
                  // Your existing GestureDetector code here, but replace onTap with:
                  GestureDetector(
                      onTap: () => _toggleSection(index),
                      child: Stack(
                        alignment: (isExpanded && index != 0) || isLastPanel
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 8, left: 16, right: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: isNextPanelExpanded &&
                                            !_controllers[index].isAnimating
                                        ? const Color.fromARGB(
                                            255, 241, 198, 255)
                                        : const Color.fromARGB(
                                            255, 102, 75, 125),
                                    width: 2),
                                right: BorderSide(
                                    color: isNextPanelExpanded &&
                                            !_controllers[index].isAnimating
                                        ? const Color.fromARGB(
                                            255, 241, 198, 255)
                                        : const Color.fromARGB(
                                            255, 102, 75, 125),
                                    width: 2),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 16,
                                bottom: isExpanded ? 8 : 16,
                                left: 16,
                                right: 16),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: index == 0 || isExpanded
                                      ? BorderSide(color: headerColor, width: 2)
                                      : BorderSide.none,
                                  bottom: isExpanded ||
                                          isNextPanelExpanded ||
                                          _controllers[index].isAnimating
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: headerColor, width: 2),
                                  left:
                                      BorderSide(color: headerColor, width: 2),
                                  right:
                                      BorderSide(color: headerColor, width: 2),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        index == 0 || isExpanded ? 16 : 0),
                                    topRight: Radius.circular(
                                        index == 0 || isExpanded ? 16 : 0),
                                    bottomLeft: Radius.circular(isExpanded ||
                                            isNextPanelExpanded ||
                                            _controllers[index].isAnimating
                                        ? 0
                                        : 16),
                                    bottomRight: Radius.circular(isExpanded ||
                                            isNextPanelExpanded ||
                                            _controllers[index].isAnimating
                                        ? 0
                                        : 16))),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Opacity(
                                          opacity: isExpanded ? 0.6 : 0.4,
                                          child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            width: 20,
                                            height: 20,
                                          )),
                                      const SizedBox(width: 8),
                                      Text(item.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(width: 8),
                                      Opacity(
                                          opacity: isExpanded ? 0.6 : 0.4,
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
                      sizeFactor: _animations[index],
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          if (!isLastPanel)
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 16, left: 16, right: 16),
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
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                            padding: const EdgeInsets.only(
                                bottom: 16, left: 16, right: 16),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: borderColor, width: 2),
                                  left:
                                      BorderSide(color: borderColor, width: 2),
                                  right:
                                      BorderSide(color: borderColor, width: 2),
                                ),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            child: Text(item.description,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          )
                        ],
                      )),
                ],
              );
            });
      }).toList(),
    );
  }
}
