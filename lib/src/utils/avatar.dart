import 'dart:math';

class Avatar {
  static const Map<AvatarKey, String> _avatarImages = {
    AvatarKey.theFool: 'assets/avatars/the_fool.png',
    AvatarKey.theMagician: 'assets/avatars/the_magician.png',
    AvatarKey.theDeath: 'assets/avatars/the_death.png',
    AvatarKey.theEmpress: 'assets/avatars/the_empress.png',
  };

  static String getAvatarImage(AvatarKey key) {
    return _avatarImages[key]!;
  }

  static AvatarKey getRandomAvatar() {
    return _avatarImages.keys
        .elementAt(Random().nextInt(_avatarImages.keys.length));
  }
}

enum AvatarKey {
  theFool('the_fool'),
  theMagician('the_magician'),
  theDeath('the_death'),
  theEmpress('the_empress');

  const AvatarKey(this.value);

  factory AvatarKey.toEnum(String key) {
    var filter = values.where((element) => element.value == key);

    if (filter.isEmpty) {
      throw Exception('Invalid avatar key');
    }

    return filter.first;
  }

  final String value;
}
