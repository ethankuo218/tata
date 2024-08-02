import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tata/src/core/providers/pages/my_chat_room_view_provider.dart';
import 'package:tata/src/ui/pages/chat-room/chat_room_view.dart';
import 'package:tata/src/ui/pages/my-chat-room/widgets/my_chat_room_tile.dart';

class MyChatRoomView extends ConsumerStatefulWidget {
  const MyChatRoomView({super.key});

  static const routeName = '/my-chat-room';

  @override
  ConsumerState<MyChatRoomView> createState() {
    return _MyChatRoomViewState();
  }
}

class _MyChatRoomViewState extends ConsumerState<MyChatRoomView> {
  late User user;
  late bool isLoading = false;

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  final adUnitId = Platform.isIOS
      // ? 'ca-app-pub-4687997855228972/2128309893'
      // : 'ca-app-pub-4687997855228972/8148423763';
      ? 'ca-app-pub-3940256099942544/2934735716'
      : 'ca-app-pub-3940256099942544/6300978111';

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded == false) {
      loadAd();
    }

    return ref.watch(myChatRoomViewProvider).when(
          data: (list) {
            return Scaffold(
                body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 12, 13, 32),
                    Color.fromARGB(255, 26, 0, 58),
                  ],
                ),
              ),
              child: Column(
                children: [
                  if (_bannerAd != null)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: SizedBox(
                          width: _bannerAd!.size.width.toDouble(),
                          height: _bannerAd!.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd!),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Expanded(
                      child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      var chatRoomInfo = list[index];

                      return MyChatRoomTile(
                          userUid: user.uid,
                          roomInfo: chatRoomInfo,
                          onTap: () => context.push(ChatRoomView.routeName,
                              extra:
                                  chatRoomInfo.fold((l) => l.id, (r) => r.id)));
                    },
                    itemCount: list.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 16),
                  ))
                ],
              ),
            ));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        );
  }

  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
}
