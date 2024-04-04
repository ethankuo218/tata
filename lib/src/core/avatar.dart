import 'dart:math';

class Avatar {
  static const Map<AvatarKey, String> _avatarImages = {
    AvatarKey.theMagician: 'assets/avatars/the_magician.png',
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
  theMagician('the_magician');

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
