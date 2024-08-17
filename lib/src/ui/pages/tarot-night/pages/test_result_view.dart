import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/models/tarot_card.dart';
import 'package:tata/src/core/providers/pages/tarot-night/test_result_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/quest_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/test_result_expandable_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tata/src/utils/tarot.dart';

class TarotNightTestResultView extends ConsumerStatefulWidget {
  const TarotNightTestResultView({super.key, required this.roomId});

  final String roomId;

  static const routeName = '/tarot-night/test-result';

  @override
  ConsumerState<TarotNightTestResultView> createState() =>
      _TarotNightTestResultViewState();
}

class _TarotNightTestResultViewState
    extends ConsumerState<TarotNightTestResultView> {
  late List<DescriptionItem> _data;
  late Role role;

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(tarotNightTestResultViewProvider(roomId: widget.roomId))
        .when(
          data: (roomInfo) {
            if (roomInfo.hostId != FirebaseAuth.instance.currentUser!.uid) {
              ref
                  .read(tarotNightTestResultViewProvider(roomId: widget.roomId)
                      .notifier)
                  .getRole()
                  .then((result) => role = result);
            }

            final TarotCard card = ref
                .read(tarotNightTestResultViewProvider(roomId: widget.roomId)
                    .notifier)
                .getCard();

            _data = [
              DescriptionItem(
                title: AppLocalizations.of(context)!.category_work,
                description:
                    Tarot.getTarotCardWorkDescription(context, card.work),
              ),
              DescriptionItem(
                title: AppLocalizations.of(context)!.category_romance,
                description:
                    Tarot.getTarotCardRomanceDescription(context, card.romance),
              ),
              DescriptionItem(
                title: AppLocalizations.of(context)!.category_friendship,
                description:
                    Tarot.getTarotCardFriendDescription(context, card.friend),
              ),
              DescriptionItem(
                title: AppLocalizations.of(context)!.category_family,
                description:
                    Tarot.getTarotCardFamilyDescription(context, card.family),
              ),
            ];

            final bool isAnswered = roomInfo.answers == null
                ? false
                : roomInfo.answers!.any((element) =>
                        element.uid == FirebaseAuth.instance.currentUser!.uid)
                    ? true
                    : false;

            return Scaffold(
                appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                    automaticallyImplyLeading: false,
                    toolbarHeight: 0,
                    titleSpacing: 0,
                    centerTitle: false),
                body: BottomBar(
                    offset: 30,
                    barColor: Colors.transparent,
                    child: roomInfo.hostId !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? SizedBox(
                            height: 48,
                            width: 160.5,
                            child: FittedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: isAnswered
                                        ? const Color.fromARGB(
                                            255, 168, 168, 168)
                                        : const Color.fromARGB(
                                            255, 223, 130, 255),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12)),
                                onPressed: () {
                                  if (isAnswered) {
                                    return;
                                  }

                                  ref
                                      .read(tarotNightTestResultViewProvider(
                                              roomId: widget.roomId)
                                          .notifier)
                                      .getQuest()
                                      .then((quest) {
                                    context.push(TarotNightQuestView.routeName,
                                        extra: {
                                          'roomId': widget.roomId,
                                          'role': role.name,
                                          'quest': quest
                                        });
                                  });
                                },
                                child: Text(
                                    isAnswered
                                        ? AppLocalizations.of(context)!
                                            .tarot_result_task_completed
                                        : AppLocalizations.of(context)!
                                            .tarot_result_task_uncompleted,
                                    style: const TextStyle(
                                        height: 1.0,
                                        color: Color.fromARGB(255, 12, 13, 32),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ))
                        : const SizedBox.shrink(),
                    body: (context, controller) => SingleChildScrollView(
                            child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                Color.fromARGB(255, 12, 13, 32),
                                Color.fromARGB(255, 26, 0, 58),
                              ])),
                          child: Column(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 32, 20, 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/star_4.svg',
                                        width: 20, height: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .tarot_result_tarot_result_title,
                                        style: const TextStyle(
                                            height: 1.0,
                                            color: Color.fromARGB(
                                                255, 223, 130, 255),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(width: 10),
                                    SvgPicture.asset('assets/images/star_4.svg',
                                        width: 20, height: 20),
                                  ],
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                            height: 400,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 241, 198, 255),
                                                    width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: Image.asset(card.image,
                                                    fit: BoxFit.cover))),
                                        Container(
                                            height: 400,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 241, 198, 255),
                                                    width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Spacer(),
                                                  Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  stops: [
                                                                    0.1253,
                                                                    1.036
                                                                  ],
                                                                  colors: [
                                                                    Color
                                                                        .fromARGB(
                                                                            0,
                                                                            12,
                                                                            13,
                                                                            32),
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            12,
                                                                            13,
                                                                            32),
                                                                  ]),
                                                              borderRadius: BorderRadius.vertical(
                                                                  bottom: Radius
                                                                      .circular(
                                                                          7))),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12,
                                                          horizontal: 8),
                                                      child: Row(children: [
                                                        const Spacer(),
                                                        IconButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            color: Colors.white,
                                                            onPressed: () {
                                                              Share.share(
                                                                  '${AppLocalizations.of(context)!.tarot_result_share_content} \n https://www.tatarot.app');
                                                            },
                                                            icon: const Icon(
                                                                Icons.share)),
                                                        // IconButton(
                                                        //     padding:
                                                        //         const EdgeInsets
                                                        //             .all(0.0),
                                                        //     color: Colors.white,
                                                        //     onPressed: () {
                                                        //       print('Download');
                                                        //     },
                                                        //     icon: const Icon(
                                                        //         Icons
                                                        //             .download)),
                                                      ])),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Opacity(
                                            opacity: 0.6,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 20,
                                                height: 24)),
                                        Opacity(
                                            opacity: 0.4,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 16,
                                                height: 16)),
                                        Opacity(
                                            opacity: 0.2,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 12,
                                                height: 12)),
                                        Opacity(
                                            opacity: 0.2,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 12,
                                                height: 12)),
                                        Opacity(
                                            opacity: 0.4,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 16,
                                                height: 16)),
                                        Opacity(
                                            opacity: 0.6,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 20,
                                                height: 24))
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '- ${Tarot.getTarotCardTitle(context, card.title)} -',
                                      style: const TextStyle(
                                          height: 1.0,
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      Tarot.getTarotCardDescription(
                                          context, card.description),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          height: 12 / 7,
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 20),
                                    TarotNightTestResultExpandablePanel(
                                        data: _data)
                                  ],
                                )),
                          ]),
                        ))));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
  }
}

class DescriptionItem {
  final String title;
  final String description;
  bool isExpanded;

  DescriptionItem(
      {required this.title,
      required this.description,
      this.isExpanded = false});
}
