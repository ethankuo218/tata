import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tata/flavors.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:tata/src/core/providers/user_provider.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final TextEditingController nameEditingController = TextEditingController();
  late bool enableEdit = false;

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  final adUnitId = Platform.isIOS
      ? F.appFlavor == Flavor.dev
          ? 'ca-app-pub-3940256099942544/2934735716'
          : 'ca-app-pub-4687997855228972/2128309893'
      : F.appFlavor == Flavor.dev
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-4687997855228972/8148423763';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final UserProvider provider =
        userProvider(FirebaseAuth.instance.currentUser!.uid);

    if (_isLoaded == false) {
      loadAd();
    }

    return ref.watch(provider).when(
          data: (userInfo) => Scaffold(
            appBar: AppBar(
                title: Text(
              AppLocalizations.of(context)!.setting_title,
            )),
            body: Column(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(Avatar.getAvatarImage(userInfo!.avatar),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 5),
                enableEdit
                    ? Center(
                        child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              controller: nameEditingController,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Positioned(
                              right: 2,
                              bottom: 3,
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: IconButton(
                                  color: Colors.white.withOpacity(0.7),
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    await ref
                                        .read(provider.notifier)
                                        .editUserName(
                                            nameEditingController.text);

                                    setState(() {
                                      enableEdit = false;
                                    });
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 15,
                                    color: Colors.green,
                                  ),
                                ),
                              ))
                        ],
                      ))
                    : Center(
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              userInfo.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 3,
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: IconButton(
                                  color: Colors.white.withOpacity(0.7),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      enableEdit = true;
                                      nameEditingController.value =
                                          TextEditingValue(text: userInfo.name);
                                    });
                                  },
                                  icon: const FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 15),
                                ),
                              ))
                        ]),
                      ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                    child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Column(
                    children: [
                      // SizedBox(
                      //     height: 60,
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         const SizedBox(
                      //             width: 40,
                      //             child: FaIcon(FontAwesomeIcons.globe,
                      //                 color: Colors.white)),
                      //         Text(
                      //           AppLocalizations.of(context)!
                      //               .setting_language,
                      //           style: const TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //         const Expanded(
                      //             child: Text(
                      //           'English',
                      //           textAlign: TextAlign.end,
                      //           style: TextStyle(color: Colors.white),
                      //         ))
                      //       ],
                      //     )),
                      GestureDetector(
                          onTap: () =>
                              launchUrlString('mailto:support@tatarot.app'),
                          child: SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 40,
                                    child: FaIcon(
                                        FontAwesomeIcons.circleQuestion,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .setting_help_center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.chevron_right_sharp,
                                      color: Colors.white,
                                    ),
                                  ))
                                ],
                              ))),
                      GestureDetector(
                          onTap: () => Share.share(
                              '${AppLocalizations.of(context)!.setting_share_content} \n https://www.tatarot.app'),
                          child: SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 40,
                                    child: FaIcon(FontAwesomeIcons.userGroup,
                                        color: Colors.white),
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .setting_invite_friends,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      )),
                                  const Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.chevron_right_sharp,
                                      color: Colors.white,
                                    ),
                                  ))
                                ],
                              ))),
                      GestureDetector(
                        onTap: () => launchUrlString(
                            'https://www.tatarot.app/docs/terms-policy.html'),
                        child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 40,
                                  child: FaIcon(FontAwesomeIcons.listCheck,
                                      color: Colors.white),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .setting_terms_and_conditions,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.chevron_right_sharp,
                                    color: Colors.white,
                                  ),
                                ))
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () => launchUrlString(
                            'https://www.tatarot.app/docs/tata-privacy-policy.html'),
                        child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                const SizedBox(
                                    width: 40,
                                    child: FaIcon(FontAwesomeIcons.lock,
                                        color: Colors.white)),
                                Text(
                                  AppLocalizations.of(context)!
                                      .setting_privacy_policy,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.chevron_right_sharp,
                                    color: Colors.white,
                                  ),
                                ))
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () => ref.read(authProvider.notifier).signOut(),
                        child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 40,
                                  child: FaIcon(
                                      FontAwesomeIcons.arrowRightFromBracket,
                                      color: Color.fromARGB(255, 220, 78, 68)),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.setting_logout,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 220, 78, 68),
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: screenHeight * 0.3),
                      SizedBox(
                          height: 40,
                          child: GestureDetector(
                              onTap: () {
                                launchUrlString('mailto:support@tatarot.app');
                              },
                              child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .setting_delete_account,
                                      style: TextStyle(
                                        color: Colors.red.withOpacity(0.7),
                                        fontSize: 16,
                                      ))))),
                    ],
                  ),
                )),
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
                  )
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
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
