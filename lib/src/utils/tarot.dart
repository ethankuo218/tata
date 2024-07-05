import 'dart:math';

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
