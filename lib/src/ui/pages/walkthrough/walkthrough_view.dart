import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:tata/src/ui/pages/home/home_view.dart';
import 'package:tata/src/ui/pages/walkthrough/widgets/choose_avatar_view.dart';
import 'package:tata/src/ui/pages/walkthrough/widgets/fill_birthday_view.dart';
import 'package:tata/src/ui/pages/walkthrough/widgets/fill_name_view.dart';
import 'package:tata/src/utils/avatar.dart';

class WalkthroughView extends ConsumerStatefulWidget {
  const WalkthroughView({super.key});

  static const String routeName = '/walkthrough';

  @override
  ConsumerState<WalkthroughView> createState() => _WalkthroughViewState();
}

class _WalkthroughViewState extends ConsumerState<WalkthroughView> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  int _avatarIndex = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> walkthroughs = [
      ChooseAvatarView(onSelected: (int value) {
        _avatarIndex = value;
      }),
      FillNameView(controller: _nameController),
      FillBirthdayView(controller: _birthdayController),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StepProgressIndicator(
            totalSteps: walkthroughs.length,
            currentStep: _currentPage + 1,
            selectedColor: const Color.fromARGB(255, 255, 228, 85),
          ),
          const SizedBox(height: 100),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: walkthroughs,
            ),
          ),

          // Added a button to navigate to the next page
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_currentPage < walkthroughs.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else if (_nameController.text.isEmpty) {
                              _pageController.jumpToPage(1);
                            } else if (_birthdayController.text.isEmpty) {
                              _pageController.jumpToPage(2);
                            } else {
                              await ref
                                  .read(authProvider.notifier)
                                  .updateUserProfile(
                                      name: _nameController.text,
                                      birthday: _birthdayController.text,
                                      avatar: AvatarKey.values[_avatarIndex])
                                  .then((value) {
                                context.pushReplacement(HomeView.routeName);
                              });
                            }
                          },
                          child: Text(
                              _currentPage < walkthroughs.length - 1
                                  ? '下一步'
                                  : '完成',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 9, 47),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400))))
                ]),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
