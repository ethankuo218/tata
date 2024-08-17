import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatelessWidget {
  final Brand brand;

  const AnimatedButton({
    super.key,
    required this.brand,
    required RiveAnimationController btnAnimationController,
    required this.onPress,
  }) : _btnAnimationController = btnAnimationController;

  final RiveAnimationController _btnAnimationController;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    late dynamic brandIcon;
    late String buttonText;

    switch (brand) {
      case Brand.apple:
        brandIcon = SvgPicture.asset(
          'assets/icons/apple-icon.svg',
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
        );
        buttonText = 'Sign in with Apple';
        break;
      case Brand.google:
        brandIcon = SvgPicture.asset(
          'assets/icons/google-icon.svg',
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
        );
        buttonText = 'Sign in with Google';
        break;
      case Brand.facebook:
        brandIcon = SvgPicture.asset(
          'assets/icons/facebook-icon.svg',
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
        );
        buttonText = 'Sign in with Facebook';
      case Brand.phone:
        brandIcon = const Icon(
          Icons.phone,
          size: 28,
        );
        buttonText = 'Sign in with Phone';
        break;
    }

    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        height: 80,
        width: 240,
        child: Stack(children: [
          RiveAnimation.asset(
            "assets/rive-assets/login_button.riv",
            controllers: [_btnAnimationController],
            fit: BoxFit.cover,
          ),
          Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  brandIcon,
                  const SizedBox(width: 10),
                  Text(buttonText,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600))
                ],
              )),
        ]),
      ),
    );
  }
}

enum Brand {
  apple(1),
  google(2),
  facebook(3),
  phone(4);

  const Brand(this.enumValue);

  /// Convert value to enum type
  ///
  /// When value not found, and [defaultValue] is null will Return first enum value.
  factory Brand.toEnum(int x, {dynamic defaultValue}) {
    var filter = values.where((element) => element.enumValue == x);
    return filter.isNotEmpty ? filter.first : defaultValue ?? values.first;
  }

  final int enumValue;
}
