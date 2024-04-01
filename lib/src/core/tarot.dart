class Tarot {
  static const Map<TarotCard, String> _tarotCardImages = {
    TarotCard.fool: 'assets/images/tarot/fool.png',
    TarotCard.magician: 'assets/images/tarot/magician.png',
    TarotCard.highPriestess: 'assets/images/tarot/high_priestess.png',
    TarotCard.empress: 'assets/images/tarot/empress.png',
    TarotCard.emperor: 'assets/images/tarot/emperor.png',
    TarotCard.hierophant: 'assets/images/tarot/hierophant.png',
    TarotCard.lovers: 'assets/images/tarot/lovers.png',
    TarotCard.chariot: 'assets/images/tarot/chariot.png',
    TarotCard.strength: 'assets/images/tarot/strength.png',
    TarotCard.hermit: 'assets/images/tarot/hermit.png',
    TarotCard.wheelOfFortune: 'assets/images/tarot/wheel_of_fortune.png',
    TarotCard.justice: 'assets/images/tarot/justice.png',
    TarotCard.hangedMan: 'assets/images/tarot/hanged_man.png',
    TarotCard.death: 'assets/images/tarot/death.png',
    TarotCard.temperance: 'assets/images/tarot/temperance.png',
    TarotCard.devil: 'assets/images/tarot/devil.png',
    TarotCard.tower: 'assets/images/tarot/tower.png',
    TarotCard.star: 'assets/images/tarot/star.png',
    TarotCard.moon: 'assets/images/tarot/moon.png',
    TarotCard.sun: 'assets/images/tarot/sun.png',
    TarotCard.judgement: 'assets/images/tarot/judgement.png',
    TarotCard.world: 'assets/images/tarot/world.png',
  };

  static String getTarotCardImage(TarotCard card) {
    return _tarotCardImages[card]!;
  }
}

enum TarotCard {
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

  factory TarotCard.toEnum(String card) {
    var filter = values.where((element) => TarotCard.toValue(element) == card);

    if (filter.isEmpty) {
      throw Exception('Invalid card name');
    }

    return filter.first;
  }

  static String toValue(TarotCard card) {
    switch (card) {
      case TarotCard.fool:
        return 'fool';
      case TarotCard.magician:
        return 'magician';
      case TarotCard.highPriestess:
        return 'high_priestess';
      case TarotCard.empress:
        return 'empress';
      case TarotCard.emperor:
        return 'emperor';
      case TarotCard.hierophant:
        return 'hierophant';
      case TarotCard.lovers:
        return 'lovers';
      case TarotCard.chariot:
        return 'chariot';
      case TarotCard.strength:
        return 'strength';
      case TarotCard.hermit:
        return 'hermit';
      case TarotCard.wheelOfFortune:
        return 'wheel_of_fortune';
      case TarotCard.justice:
        return 'justice';
      case TarotCard.hangedMan:
        return 'hanged_man';
      case TarotCard.death:
        return 'death';
      case TarotCard.temperance:
        return 'temperance';
      case TarotCard.devil:
        return 'devil';
      case TarotCard.tower:
        return 'tower';
      case TarotCard.star:
        return 'star';
      case TarotCard.moon:
        return 'moon';
      case TarotCard.sun:
        return 'sun';
      case TarotCard.judgement:
        return 'judgement';
      case TarotCard.world:
        return 'world';
      default:
        throw Exception('Invalid card name');
    }
  }
}
