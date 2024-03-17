import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrandButton extends StatelessWidget {
  final Brand brand;
  final Function()? onPress;

  const BrandButton({super.key, required this.brand, required this.onPress});

  @override
  Widget build(BuildContext context) {
    late dynamic brandIcon;

    switch (brand) {
      case Brand.apple:
        brandIcon = SvgPicture.asset('assets/icons/apple-icon.svg');
        break;
      case Brand.google:
        brandIcon = SvgPicture.asset('assets/icons/google-icon.svg');
        break;
      case Brand.facebook:
        brandIcon = SvgPicture.asset('assets/icons/facebook-icon.svg');
      case Brand.phone:
        brandIcon = const Icon(
          Icons.phone,
          size: 35,
        );
        break;
    }

    return Container(
        height: 60,
        width: 240,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 2)
            ]),
        child: IconButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: onPress,
          icon: brandIcon,
        ));
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
