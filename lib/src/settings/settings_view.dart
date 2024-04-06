import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/core/avatar.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  AppUserInfo? userInfo;
  late bool enableEdit = false;
  final TextEditingController nameEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.controller
        .loadUserInfo(FirebaseAuth.instance.currentUser!.uid)
        .then((_) {
      setState(() {
        userInfo = widget.controller.userInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 18),
      ),
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
                    Avatar.getAvatarImage(Avatar.getRandomAvatar()),
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
                              onPressed: () {
                                widget.controller
                                    .editName(userInfo!.uid,
                                        nameEditingController.text)
                                    .then((_) {
                                  setState(() {
                                    enableEdit = false;
                                    userInfo = widget.controller.userInfo;
                                  });
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
                          userInfo?.name ?? '',
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
                                      TextEditingValue(text: userInfo!.name);
                                });
                              },
                              icon: const FaIcon(FontAwesomeIcons.penToSquare,
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
                      onTap: () => widget.controller.openHelpCenter(),
                      child: const SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: FaIcon(FontAwesomeIcons.circleQuestion,
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
                      onTap: () => widget.controller.openInviteFriends(),
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
                    onTap: () => widget.controller.openTermsAndConditions(),
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
                    onTap: () => widget.controller.openTermsAndConditions(),
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
                    onTap: () => widget.controller.signOut(context),
                    child: const SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: FaIcon(
                                  FontAwesomeIcons.arrowRightFromBracket,
                                  color: Color.fromARGB(255, 220, 78, 68)),
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
                          onTap: () {},
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
    );
  }
}
