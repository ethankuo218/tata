import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:tata/src/core/providers/user_provider.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final TextEditingController nameEditingController = TextEditingController();
  late bool enableEdit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final UserProvider provider =
        userProvider(FirebaseAuth.instance.currentUser!.uid);

    return ref.watch(provider).when(
          data: (userInfo) => Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset(
                          Avatar.getAvatarImage(userInfo!.avatar),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 5),
                  enableEdit
                      ? Center(
                          child: Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                            TextEditingValue(
                                                text: userInfo.name);
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
                    child: Column(
                      children: [
                        const SizedBox(
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 40,
                                    child: FaIcon(FontAwesomeIcons.globe,
                                        color: Colors.white)),
                                Text(
                                  'Language',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  'English',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.white),
                                ))
                              ],
                            )),
                        GestureDetector(
                            onTap: () =>
                                launchUrlString('mailto:support@tatarot.app'),
                            child: const SizedBox(
                                height: 60,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: FaIcon(
                                          FontAwesomeIcons.circleQuestion,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Help Center',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
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
                                'Hi! Join TATA to enjoy the most incredible anonymous chat activity: MIDNIGHT TAROT !'),
                            child: const SizedBox(
                                height: 60,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: FaIcon(FontAwesomeIcons.userGroup,
                                          color: Colors.white),
                                    ),
                                    Text('Invite Friends',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        )),
                                    Expanded(
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
                          onTap: () => launchUrlString('Terms & Conditions'),
                          child: const SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: FaIcon(FontAwesomeIcons.listCheck,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
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
                          onTap: () => launchUrlString('Privacy Policy'),
                          child: const SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      child: FaIcon(FontAwesomeIcons.lock,
                                          color: Colors.white)),
                                  Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
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
                          onTap: () =>
                              ref.read(authProvider.notifier).signOut(),
                          child: const SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: FaIcon(
                                        FontAwesomeIcons.arrowRightFromBracket,
                                        color:
                                            Color.fromARGB(255, 220, 78, 68)),
                                  ),
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 220, 78, 68),
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: screenHeight * 0.2),
                        SizedBox(
                            height: 60,
                            child: GestureDetector(
                                onTap: () {
                                  launchUrlString('mailto:support@tatarot.app');
                                },
                                child: Center(
                                    child: Text('Delete Account',
                                        style: TextStyle(
                                          color: Colors.red.withOpacity(0.7),
                                          fontSize: 16,
                                        ))))),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
        );
  }
}
