import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Tarot {
  static const Map<TarotCardKey, String> _tarotCardImages = {
    TarotCardKey.fool: 'assets/images/tarot/fool.png',
    TarotCardKey.magician: 'assets/images/tarot/magician.png',
    TarotCardKey.highPriestess: 'assets/images/tarot/high_priestess.png',
    TarotCardKey.empress: 'assets/images/tarot/empress.png',
    TarotCardKey.emperor: 'assets/images/tarot/emperor.png',
    TarotCardKey.hierophant: 'assets/images/tarot/hierophant.png',
    TarotCardKey.lovers: 'assets/images/tarot/lovers.png',
    TarotCardKey.chariot: 'assets/images/tarot/chariot.png',
    TarotCardKey.strength: 'assets/images/tarot/strength.png',
    TarotCardKey.hermit: 'assets/images/tarot/hermit.png',
    TarotCardKey.wheelOfFortune: 'assets/images/tarot/wheel_of_fortune.png',
    TarotCardKey.justice: 'assets/images/tarot/justice.png',
    TarotCardKey.hangedMan: 'assets/images/tarot/hanged_man.png',
    TarotCardKey.death: 'assets/images/tarot/death.png',
    TarotCardKey.temperance: 'assets/images/tarot/temperance.png',
    TarotCardKey.devil: 'assets/images/tarot/devil.png',
    TarotCardKey.tower: 'assets/images/tarot/tower.png',
    TarotCardKey.star: 'assets/images/tarot/star.png',
    TarotCardKey.moon: 'assets/images/tarot/moon.png',
    TarotCardKey.sun: 'assets/images/tarot/sun.png',
    TarotCardKey.judgement: 'assets/images/tarot/judgement.png',
    TarotCardKey.world: 'assets/images/tarot/world.png',
  };

  static String getTarotCardImage(TarotCardKey card) {
    return _tarotCardImages[card]!;
  }

  static TarotCardKey getRandomCard() {
    return _tarotCardImages.keys
        .elementAt(Random().nextInt(_tarotCardImages.keys.length));
  }

  static String getTarotCardTitle(BuildContext context, String key) {
    switch (key) {
      case 'the_fool_title':
        return AppLocalizations.of(context)!.the_fool_title;
      case 'the_magician_title':
        return AppLocalizations.of(context)!.the_magician_title;
      case 'the_high_priestess_title':
        return AppLocalizations.of(context)!.the_high_priestess_title;
      case 'the_empress_title':
        return AppLocalizations.of(context)!.the_empress_title;
      case 'the_emperor_title':
        return AppLocalizations.of(context)!.the_emperor_title;
      case 'the_hierophant_title':
        return AppLocalizations.of(context)!.the_hierophant_title;
      case 'the_lovers_title':
        return AppLocalizations.of(context)!.the_lover_title;
      case 'the_chariot_title':
        return AppLocalizations.of(context)!.the_chariot_title;
      case 'strength_title':
        return AppLocalizations.of(context)!.strength_title;
      case 'the_hermit_title':
        return AppLocalizations.of(context)!.the_hermit_title;
      case 'the_wheel_of_fortune_title':
        return AppLocalizations.of(context)!.the_wheel_of_fortune_title;
      case 'justice_title':
        return AppLocalizations.of(context)!.the_justice_title;
      case 'the_hanged_man_title':
        return AppLocalizations.of(context)!.the_hanged_man_title;
      case 'death_title':
        return AppLocalizations.of(context)!.death_title;
      case 'temperance_title':
        return AppLocalizations.of(context)!.temperance_title;
      case 'the_devil_title':
        return AppLocalizations.of(context)!.the_devil_title;
      case 'the_tower_title':
        return AppLocalizations.of(context)!.the_tower_title;
      case 'the_star_title':
        return AppLocalizations.of(context)!.the_star_title;
      case 'the_moon_title':
        return AppLocalizations.of(context)!.the_moon_title;
      case 'the_sun_title':
        return AppLocalizations.of(context)!.the_sun_title;
      case 'judgement_title':
        return AppLocalizations.of(context)!.judgement_title;
      case 'the_world_title':
        return AppLocalizations.of(context)!.the_world_title;
      default:
        throw Exception('Invalid card key');
    }
  }

  static String getTarotCardDescription(BuildContext context, String key) {
    switch (key) {
      case 'the_fool_description':
        return AppLocalizations.of(context)!.the_fool_description;
      case 'the_magician_description':
        return AppLocalizations.of(context)!.the_magician_description;
      case 'the_high_priestess_description':
        return AppLocalizations.of(context)!.the_high_priestess_description;
      case 'the_empress_description':
        return AppLocalizations.of(context)!.the_empress_description;
      case 'the_emperor_description':
        return AppLocalizations.of(context)!.the_emperor_description;
      case 'the_hierophant_description':
        return AppLocalizations.of(context)!.the_hierophant_description;
      case 'the_lovers_description':
        return AppLocalizations.of(context)!.the_lover_description;
      case 'the_chariot_description':
        return AppLocalizations.of(context)!.the_chariot_description;
      case 'strength_description':
        return AppLocalizations.of(context)!.strength_description;
      case 'the_hermit_description':
        return AppLocalizations.of(context)!.the_hermit_description;
      case 'the_wheel_of_fortune_description':
        return AppLocalizations.of(context)!.the_wheel_of_fortune_description;
      case 'justice_description':
        return AppLocalizations.of(context)!.the_justice_description;
      case 'the_hanged_man_description':
        return AppLocalizations.of(context)!.the_hanged_man_description;
      case 'death_description':
        return AppLocalizations.of(context)!.death_description;
      case 'temperance_description':
        return AppLocalizations.of(context)!.temperance_description;
      case 'the_devil_description':
        return AppLocalizations.of(context)!.the_devil_description;
      case 'the_tower_description':
        return AppLocalizations.of(context)!.the_tower_description;
      case 'the_star_description':
        return AppLocalizations.of(context)!.the_star_description;
      case 'the_moon_description':
        return AppLocalizations.of(context)!.the_moon_description;
      case 'the_sun_description':
        return AppLocalizations.of(context)!.the_sun_description;
      case 'judgement_description':
        return AppLocalizations.of(context)!.judgement_description;
      case 'the_world_description':
        return AppLocalizations.of(context)!.the_world_description;
      default:
        throw Exception('Invalid card key');
    }
  }

  static String getTarotCardWorkDescription(BuildContext context, String key) {
    switch (key) {
      case 'the_fool_work':
        return AppLocalizations.of(context)!.the_fool_work;
      case 'the_magician_work':
        return AppLocalizations.of(context)!.the_magician_work;
      case 'the_high_priestess_work':
        return AppLocalizations.of(context)!.the_high_priestess_work;
      case 'the_empress_work':
        return AppLocalizations.of(context)!.the_empress_work;
      case 'the_emperor_work':
        return AppLocalizations.of(context)!.the_emperor_work;
      case 'the_hierophant_work':
        return AppLocalizations.of(context)!.the_hierophant_work;
      case 'the_lovers_work':
        return AppLocalizations.of(context)!.the_lover_work;
      case 'the_chariot_work':
        return AppLocalizations.of(context)!.the_chariot_work;
      case 'strength_work':
        return AppLocalizations.of(context)!.strength_work;
      case 'the_hermit_work':
        return AppLocalizations.of(context)!.the_hermit_work;
      case 'wheel_of_fortune_work':
        return AppLocalizations.of(context)!.the_wheel_of_fortune_work;
      case 'justice_work':
        return AppLocalizations.of(context)!.the_justice_work;
      case 'the_hanged_man_work':
        return AppLocalizations.of(context)!.the_hanged_man_work;
      case 'death_work':
        return AppLocalizations.of(context)!.death_work;
      case 'temperance_work':
        return AppLocalizations.of(context)!.temperance_work;
      case 'the_devil_work':
        return AppLocalizations.of(context)!.the_devil_work;
      case 'the_tower_work':
        return AppLocalizations.of(context)!.the_tower_work;
      case 'the_star_work':
        return AppLocalizations.of(context)!.the_star_work;
      case 'the_moon_work':
        return AppLocalizations.of(context)!.the_moon_work;
      case 'the_sun_work':
        return AppLocalizations.of(context)!.the_sun_work;
      case 'judgement_work':
        return AppLocalizations.of(context)!.judgement_work;
      case 'the_world_work':
        return AppLocalizations.of(context)!.the_world_work;
      default:
        throw Exception('Invalid card key');
    }
  }

  static String getTarotCardRomanceDescription(
      BuildContext context, String key) {
    switch (key) {
      case 'the_fool_romance':
        return AppLocalizations.of(context)!.the_fool_romance;
      case 'the_magician_romance':
        return AppLocalizations.of(context)!.the_magician_romance;
      case 'the_high_priestess_romance':
        return AppLocalizations.of(context)!.the_high_priestess_romance;
      case 'the_empress_romance':
        return AppLocalizations.of(context)!.the_empress_romance;
      case 'the_emperor_romance':
        return AppLocalizations.of(context)!.the_emperor_romance;
      case 'the_hierophant_romance':
        return AppLocalizations.of(context)!.the_hierophant_romance;
      case 'the_lovers_romance':
        return AppLocalizations.of(context)!.the_lover_romance;
      case 'the_chariot_romance':
        return AppLocalizations.of(context)!.the_chariot_romance;
      case 'strength_romance':
        return AppLocalizations.of(context)!.strength_romance;
      case 'the_hermit_romance':
        return AppLocalizations.of(context)!.the_hermit_romance;
      case 'wheel_of_fortune_romance':
        return AppLocalizations.of(context)!.the_wheel_of_fortune_romance;
      case 'justice_romance':
        return AppLocalizations.of(context)!.the_justice_romance;
      case 'the_hanged_man_romance':
        return AppLocalizations.of(context)!.the_hanged_man_romance;
      case 'death_romance':
        return AppLocalizations.of(context)!.death_romance;
      case 'temperance_romance':
        return AppLocalizations.of(context)!.temperance_romance;
      case 'the_devil_romance':
        return AppLocalizations.of(context)!.the_devil_romance;
      case 'the_tower_romance':
        return AppLocalizations.of(context)!.the_tower_romance;
      case 'the_star_romance':
        return AppLocalizations.of(context)!.the_star_romance;
      case 'the_moon_romance':
        return AppLocalizations.of(context)!.the_moon_romance;
      case 'the_sun_romance':
        return AppLocalizations.of(context)!.the_sun_romance;
      case 'judgement_romance':
        return AppLocalizations.of(context)!.judgement_romance;
      case 'the_world_romance':
        return AppLocalizations.of(context)!.the_world_romance;
      default:
        throw Exception('Invalid card key');
    }
  }

  static String getTarotCardFriendDescription(
      BuildContext context, String key) {
    switch (key) {
      case 'the_fool_friend':
        return AppLocalizations.of(context)!.the_fool_friendship;
      case 'the_magician_friend':
        return AppLocalizations.of(context)!.the_magician_friendship;
      case 'the_high_priestess_friend':
        return AppLocalizations.of(context)!.the_high_priestess_friendship;
      case 'the_empress_friend':
        return AppLocalizations.of(context)!.the_empress_friendship;
      case 'the_emperor_friend':
        return AppLocalizations.of(context)!.the_emperor_friendship;
      case 'the_hierophant_friend':
        return AppLocalizations.of(context)!.the_hierophant_friendship;
      case 'the_lovers_friend':
        return AppLocalizations.of(context)!.the_lover_friendship;
      case 'the_chariot_friend':
        return AppLocalizations.of(context)!.the_chariot_friendship;
      case 'strength_friend':
        return AppLocalizations.of(context)!.strength_friendship;
      case 'the_hermit_friend':
        return AppLocalizations.of(context)!.the_hermit_friendship;
      case 'wheel_of_fortune_friend':
        return AppLocalizations.of(context)!.the_wheel_of_fortune_friendship;
      case 'justice_friend':
        return AppLocalizations.of(context)!.the_justice_friendship;
      case 'the_hanged_man_friend':
        return AppLocalizations.of(context)!.the_hanged_man_friendship;
      case 'death_friend':
        return AppLocalizations.of(context)!.death_friendship;
      case 'temperance_friend':
        return AppLocalizations.of(context)!.temperance_friendship;
      case 'the_devil_friend':
        return AppLocalizations.of(context)!.the_devil_friendship;
      case 'the_tower_friend':
        return AppLocalizations.of(context)!.the_tower_friendship;
      case 'the_star_friend':
        return AppLocalizations.of(context)!.the_star_friendship;
      case 'the_moon_friend':
        return AppLocalizations.of(context)!.the_moon_friendship;
      case 'the_sun_friend':
        return AppLocalizations.of(context)!.the_sun_friendship;
      case 'judgement_friend':
        return AppLocalizations.of(context)!.judgement_friendship;
      case 'the_world_friend':
        return AppLocalizations.of(context)!.the_world_friendship;
      default:
        throw Exception('Invalid card key');
    }
  }

  static String getTarotCardFamilyDescription(
      BuildContext context, String key) {
    switch (key) {
      case 'the_fool_family':
        return AppLocalizations.of(context)!.the_fool_family;
      case 'the_magician_family':
        return AppLocalizations.of(context)!.the_magician_family;
      case 'the_high_priestess_family':
        return AppLocalizations.of(context)!.the_high_priestess_family;
      case 'the_empress_family':
        return AppLocalizations.of(context)!.the_empress_family;
      case 'the_emperor_family':
        return AppLocalizations.of(context)!.the_emperor_family;
      case 'the_hierophant_family':
        return AppLocalizations.of(context)!.the_hierophant_family;
      case 'the_lovers_family':
        return AppLocalizations.of(context)!.the_lover_family;
      case 'the_chariot_family':
        return AppLocalizations.of(context)!.the_chariot_family;
      case 'strength_family':
        return AppLocalizations.of(context)!.strength_family;
      case 'the_hermit_family':
        return AppLocalizations.of(context)!.the_hermit_family;
      case 'wheel_of_fortune_family':
        return AppLocalizations.of(context)!.the_wheel_of_fortune_family;
      case 'justice_family':
        return AppLocalizations.of(context)!.the_justice_family;
      case 'the_hanged_man_family':
        return AppLocalizations.of(context)!.the_hanged_man_family;
      case 'death_family':
        return AppLocalizations.of(context)!.death_family;
      case 'temperance_family':
        return AppLocalizations.of(context)!.temperance_family;
      case 'the_devil_family':
        return AppLocalizations.of(context)!.the_devil_family;
      case 'the_tower_family':
        return AppLocalizations.of(context)!.the_tower_family;
      case 'the_star_family':
        return AppLocalizations.of(context)!.the_star_family;
      case 'the_moon_family':
        return AppLocalizations.of(context)!.the_moon_family;
      case 'the_sun_family':
        return AppLocalizations.of(context)!.the_sun_family;
      case 'judgement_family':
        return AppLocalizations.of(context)!.judgement_family;
      case 'the_world_family':
        return AppLocalizations.of(context)!.the_world_family;
      default:
        throw Exception('Invalid card key');
    }
  }
}

enum TarotCardKey {
  fool,
  magician,
  highPriestess,
  empress,
  emperor,
  hierophant,
  lovers,
  chariot,
  strength,
  hermit,
  wheelOfFortune,
  justice,
  hangedMan,
  death,
  temperance,
  devil,
  tower,
  star,
  moon,
  sun,
  judgement,
  world;

  factory TarotCardKey.toEnum(String card) {
    var filter =
        values.where((element) => TarotCardKey.toValue(element) == card);

    if (filter.isEmpty) {
      throw Exception('Invalid card name');
    }

    return filter.first;
  }

  static String toValue(TarotCardKey card) {
    switch (card) {
      case TarotCardKey.fool:
        return 'fool';
      case TarotCardKey.magician:
        return 'magician';
      case TarotCardKey.highPriestess:
        return 'high_priestess';
      case TarotCardKey.empress:
        return 'empress';
      case TarotCardKey.emperor:
        return 'emperor';
      case TarotCardKey.hierophant:
        return 'hierophant';
      case TarotCardKey.lovers:
        return 'lovers';
      case TarotCardKey.chariot:
        return 'chariot';
      case TarotCardKey.strength:
        return 'strength';
      case TarotCardKey.hermit:
        return 'hermit';
      case TarotCardKey.wheelOfFortune:
        return 'wheel_of_fortune';
      case TarotCardKey.justice:
        return 'justice';
      case TarotCardKey.hangedMan:
        return 'hanged_man';
      case TarotCardKey.death:
        return 'death';
      case TarotCardKey.temperance:
        return 'temperance';
      case TarotCardKey.devil:
        return 'devil';
      case TarotCardKey.tower:
        return 'tower';
      case TarotCardKey.star:
        return 'star';
      case TarotCardKey.moon:
        return 'moon';
      case TarotCardKey.sun:
        return 'sun';
      case TarotCardKey.judgement:
        return 'judgement';
      case TarotCardKey.world:
        return 'world';
      default:
        throw Exception('Invalid card name');
    }
  }
}
