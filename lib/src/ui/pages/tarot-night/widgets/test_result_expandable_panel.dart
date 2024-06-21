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
  // Work
  late final AnimationController _workController;
  late final Animation<double> _workAnimation;
  late final Tween<double> _workSizeTween;
  late final Animation<Color?> _workColorTween;

  // Romance
  late final AnimationController _romanceController;
  late final Animation<double> _romanceAnimation;
  late final Tween<double> _romanceSizeTween;
  late final Animation<Color?> _romanceColorTween;

  // Friend
  late final AnimationController _friendController;
  late final Animation<double> _friendAnimation;
  late final Tween<double> _friendSizeTween;
  late final Animation<Color?> _friendColorTween;

  // Family
  late final AnimationController _familyController;
  late final Animation<double> _familyAnimation;
  late final Tween<double> _familySizeTween;
  late final Animation<Color?> _familyColorTween;

  // expansion state
  bool _isWorkExpanded = false;
  bool _isRomanceExpanded = false;
  bool _isFriendExpanded = false;
  bool _isFamilyExpanded = false;

  @override
  void initState() {
    _workController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _workAnimation = CurvedAnimation(
      parent: _workController,
      curve: Curves.fastOutSlowIn,
    );
    _workSizeTween = Tween(begin: 0, end: 1);
    _workColorTween = ColorTween(
            begin: const Color.fromARGB(255, 102, 75, 125),
            end: const Color.fromARGB(255, 241, 198, 255))
        .animate(_workController);

    _workController.addListener(() {
      setState(() {});
    });

    _romanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _romanceAnimation = CurvedAnimation(
      parent: _romanceController,
      curve: Curves.fastOutSlowIn,
    );
    _romanceSizeTween = Tween(begin: 0, end: 1);
    _romanceColorTween = ColorTween(
            begin: const Color.fromARGB(255, 102, 75, 125),
            end: const Color.fromARGB(255, 241, 198, 255))
        .animate(_romanceController);

    _romanceController.addListener(() {
      setState(() {});
    });

    _friendController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _friendAnimation = CurvedAnimation(
      parent: _friendController,
      curve: Curves.fastOutSlowIn,
    );
    _friendSizeTween = Tween(begin: 0, end: 1);
    _friendColorTween = ColorTween(
            begin: const Color.fromARGB(255, 102, 75, 125),
            end: const Color.fromARGB(255, 241, 198, 255))
        .animate(_friendController);

    _friendController.addListener(() {
      setState(() {});
    });

    _familyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _familyAnimation = CurvedAnimation(
      parent: _familyController,
      curve: Curves.fastOutSlowIn,
    );
    _familySizeTween = Tween(begin: 0, end: 1);
    _familyColorTween = ColorTween(
            begin: const Color.fromARGB(255, 102, 75, 125),
            end: const Color.fromARGB(255, 241, 198, 255))
        .animate(_familyController);

    _familyController.addListener(() {
      setState(() {});
    });

    _expandWorkOnChanged();

    super.initState();
  }

  // toggle expandable without setState,
  // so that the widget does not rebuild itself.
  void _expandWorkOnChanged() {
    if (_isWorkExpanded) return;

    _isWorkExpanded = true;
    _workController.forward();

    _isRomanceExpanded = false;
    _isFriendExpanded = false;
    _isFamilyExpanded = false;
    _romanceController.reverse();
    _friendController.reverse();
    _familyController.reverse();
  }

  void _expandRomanceOnChanged() {
    if (_isRomanceExpanded) return;

    _isRomanceExpanded = true;
    _romanceController.forward();

    _isWorkExpanded = false;
    _isFriendExpanded = false;
    _isFamilyExpanded = false;
    _workController.reverse();
    _friendController.reverse();
    _familyController.reverse();
  }

  void _expandFriendOnChanged() {
    if (_isFriendExpanded) return;

    _isFriendExpanded = true;
    _friendController.forward();

    _isWorkExpanded = false;
    _isRomanceExpanded = false;
    _isFamilyExpanded = false;
    _workController.reverse();
    _romanceController.reverse();
    _familyController.reverse();
  }

  void _expandFamilyOnChanged() {
    if (_isFamilyExpanded) return;

    _isFamilyExpanded = true;
    _familyController.forward();

    _isWorkExpanded = false;
    _isRomanceExpanded = false;
    _isFriendExpanded = false;
    _workController.reverse();
    _romanceController.reverse();
    _friendController.reverse();
  }

  // dispose the controller to release it from the memory
  @override
  void dispose() {
    _workController.dispose();
    _romanceController.dispose();
    _friendController.dispose();
    _familyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Work
      AnimatedBuilder(
          animation: _workColorTween,
          builder: (context, child) => Column(
                children: [
                  GestureDetector(
                      onTap: _expandWorkOnChanged,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 8, left: 16, right: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: _romanceColorTween.value!, width: 2),
                                right: BorderSide(
                                    color: _romanceColorTween.value!, width: 2),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 16,
                                bottom: _isWorkExpanded ? 8 : 16,
                                left: 16,
                                right: 16),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: _workColorTween.value!, width: 2),
                                  bottom: _isWorkExpanded || _isRomanceExpanded
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: _workColorTween.value!,
                                          width: 2),
                                  left: BorderSide(
                                      color: _workColorTween.value!, width: 2),
                                  right: BorderSide(
                                      color: _workColorTween.value!, width: 2),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(16),
                                    topRight: const Radius.circular(16),
                                    bottomLeft: Radius.circular(
                                        _isWorkExpanded || _isRomanceExpanded
                                            ? 0
                                            : 16),
                                    bottomRight: Radius.circular(
                                        _isWorkExpanded || _isRomanceExpanded
                                            ? 0
                                            : 16))),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Opacity(
                                          opacity: _isWorkExpanded ? 0.6 : 0.4,
                                          child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            width: 20,
                                            height: 20,
                                          )),
                                      const SizedBox(width: 8),
                                      Text(widget.data[0].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(width: 8),
                                      Opacity(
                                          opacity: _isWorkExpanded ? 0.6 : 0.4,
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
                      sizeFactor: _workSizeTween.animate(_workAnimation),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
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
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 16, left: 16, right: 16),
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
                            child: Text(widget.data[0].description,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          )
                        ],
                      )),
                ],
              )),
      // Romance
      AnimatedBuilder(
          animation: _romanceColorTween,
          builder: (context, child) => Column(children: [
                GestureDetector(
                    onTap: _expandRomanceOnChanged,
                    child: Stack(
                      alignment: _isRomanceExpanded
                          ? Alignment.topCenter
                          : Alignment.bottomCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 8, left: 16, right: 16),
                          decoration: BoxDecoration(
                              border: Border(
                            left: BorderSide(
                                color: _friendColorTween.value!, width: 2),
                            right: BorderSide(
                                color: _friendColorTween.value!, width: 2),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 16,
                              bottom: _isRomanceExpanded ? 8 : 16,
                              left: 16,
                              right: 16),
                          decoration: BoxDecoration(
                              border: Border(
                                top: _isRomanceExpanded
                                    ? BorderSide(
                                        color: _romanceColorTween.value!,
                                        width: 2)
                                    : BorderSide.none,
                                bottom: _isRomanceExpanded || _isFriendExpanded
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: _romanceColorTween.value!,
                                        width: 2),
                                left: BorderSide(
                                    color: _romanceColorTween.value!, width: 2),
                                right: BorderSide(
                                    color: _romanceColorTween.value!, width: 2),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      _isRomanceExpanded ? 16 : 0),
                                  topRight: Radius.circular(
                                      _isRomanceExpanded ? 16 : 0),
                                  bottomLeft: Radius.circular(
                                      _isRomanceExpanded || _isFriendExpanded
                                          ? 0
                                          : 16),
                                  bottomRight: Radius.circular(
                                      _isRomanceExpanded || _isFriendExpanded
                                          ? 0
                                          : 16))),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                        opacity: _isRomanceExpanded ? 0.6 : 0.4,
                                        child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          width: 20,
                                          height: 20,
                                        )),
                                    const SizedBox(width: 8),
                                    Text(widget.data[1].title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(width: 8),
                                    Opacity(
                                        opacity: _isRomanceExpanded ? 0.6 : 0.4,
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
                    sizeFactor: _romanceSizeTween.animate(_romanceAnimation),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
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
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 16, right: 16),
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
                          child: Text(widget.data[1].description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        )
                      ],
                    )),
              ])),
      // Friend
      AnimatedBuilder(
          animation: _friendColorTween,
          builder: (context, child) => Column(
                children: [
                  GestureDetector(
                      onTap: _expandFriendOnChanged,
                      child: Stack(
                        alignment: _isFriendExpanded
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 16,
                                bottom: _isFriendExpanded ? 8 : 16,
                                left: 16,
                                right: 16),
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                  color: _familyColorTween.value!, width: 2),
                              right: BorderSide(
                                  color: _familyColorTween.value!, width: 2),
                            )),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 16,
                                bottom: _isFriendExpanded ? 8 : 16,
                                left: 16,
                                right: 16),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: _isFriendExpanded
                                      ? BorderSide(
                                          color: _friendColorTween.value!,
                                          width: 2)
                                      : BorderSide.none,
                                  bottom: _isFriendExpanded || _isFamilyExpanded
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: _friendColorTween.value!,
                                          width: 2),
                                  left: BorderSide(
                                      color: _friendColorTween.value!,
                                      width: 2),
                                  right: BorderSide(
                                      color: _friendColorTween.value!,
                                      width: 2),
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        _isFriendExpanded ? 16 : 0),
                                    topRight: Radius.circular(
                                        _isFriendExpanded ? 16 : 0),
                                    bottomLeft: Radius.circular(
                                        _isFriendExpanded || _isFamilyExpanded
                                            ? 0
                                            : 16),
                                    bottomRight: Radius.circular(
                                        _isFriendExpanded || _isFamilyExpanded
                                            ? 0
                                            : 16))),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Opacity(
                                          opacity:
                                              _isFriendExpanded ? 0.6 : 0.4,
                                          child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            width: 20,
                                            height: 20,
                                          )),
                                      const SizedBox(width: 8),
                                      Text(widget.data[2].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(width: 8),
                                      Opacity(
                                          opacity:
                                              _isFriendExpanded ? 0.6 : 0.4,
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
                      sizeFactor: _friendSizeTween.animate(_friendAnimation),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
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
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 16, left: 16, right: 16),
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
                            child: Text(widget.data[2].description,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          )
                        ],
                      )),
                ],
              )),
      // Family
      AnimatedBuilder(
          animation: _familyColorTween,
          builder: (context, child) => Column(
                children: [
                  GestureDetector(
                      onTap: _expandFamilyOnChanged,
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 16,
                              bottom: _isFamilyExpanded ? 8 : 16,
                              left: 16,
                              right: 16),
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
                          padding: EdgeInsets.only(
                              top: 16,
                              bottom: _isFamilyExpanded ? 8 : 16,
                              left: 16,
                              right: 16),
                          decoration: BoxDecoration(
                              border: Border(
                                top: _isFamilyExpanded
                                    ? BorderSide(
                                        color: _familyColorTween.value!,
                                        width: 2)
                                    : BorderSide.none,
                                bottom: _isFamilyExpanded
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: _familyColorTween.value!,
                                        width: 2),
                                left: BorderSide(
                                    color: _familyColorTween.value!, width: 2),
                                right: BorderSide(
                                    color: _familyColorTween.value!, width: 2),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      _isFamilyExpanded ? 16 : 0),
                                  topRight: Radius.circular(
                                      _isFamilyExpanded ? 16 : 0),
                                  bottomLeft: Radius.circular(
                                      _isFamilyExpanded ? 0 : 16),
                                  bottomRight: Radius.circular(
                                      _isFamilyExpanded ? 0 : 16))),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                        opacity: _isFamilyExpanded ? 0.6 : 0.4,
                                        child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          width: 20,
                                          height: 20,
                                        )),
                                    const SizedBox(width: 8),
                                    Text(widget.data[3].title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(width: 8),
                                    Opacity(
                                        opacity: _isFamilyExpanded ? 0.6 : 0.4,
                                        child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          width: 20,
                                          height: 20,
                                        ))
                                  ])
                            ],
                          ),
                        )
                      ])),
                  SizeTransition(
                      axisAlignment: 0,
                      sizeFactor: _familySizeTween.animate(_familyAnimation),
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
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
                        child: Text(widget.data[3].description,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      )),
                ],
              ))
    ]);
  }
}
