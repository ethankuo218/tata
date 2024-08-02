import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/providers/pages/tarot-night/test_result_view_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarotNightQuestView extends ConsumerWidget {
  const TarotNightQuestView(
      {super.key,
      required this.roomId,
      required this.role,
      required this.quest});
  final String roomId;
  final String role;
  final String quest;

  static const routeName = '/tarot-night/quest-view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 12, 13, 32),
            title: Text(AppLocalizations.of(context)!.tarot_quest_title)),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromARGB(255, 12, 13, 32),
                      Color.fromARGB(255, 26, 0, 58),
                    ])),
                child: Column(children: [
                  SvgPicture.asset('assets/images/star_5.svg',
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 223, 130, 255), BlendMode.srcIn)),
                  const SizedBox(height: 24),
                  Text(Role.getRoleIntro(context, role),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1.4,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 20),
                  Text(Role.getRoleQuest(context, quest),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 12 / 7,
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 198, 255)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      minLines: 15,
                      maxLines: 15,
                      controller: answerController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          hintText:
                              AppLocalizations.of(context)!.tarot_quest_error,
                          hintStyle: TextStyle(
                            height: 12 / 7,
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.5),
                            fontSize: 14,
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor:
                              const Color.fromARGB(255, 223, 130, 255),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12)),
                      onPressed: () {
                        if (answerController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .tarot_quest_error)));
                        } else {
                          ref
                              .read(tarotNightTestResultViewProvider(
                                      roomId: roomId)
                                  .notifier)
                              .submitTaskAnswer(answerController.value.text)
                              .then((value) {
                            context.pop();
                            context.pop();
                          });
                        }
                      },
                      child: Text(
                          AppLocalizations.of(context)!.tarot_quest_submit,
                          style: const TextStyle(
                              height: 1.2,
                              color: Color.fromARGB(255, 12, 13, 32),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)))
                ]))));
  }
}
