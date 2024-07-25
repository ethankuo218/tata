import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<Object?> showStartTarotTestBottomSheet(BuildContext context,
    {required ValueChanged onClosed}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) => const StartTarotTestBottomSheet()).then(onClosed);
}

class StartTarotTestBottomSheet extends StatefulWidget {
  const StartTarotTestBottomSheet({super.key});

  @override
  State<StartTarotTestBottomSheet> createState() =>
      _StartTarotTestBottomSheetState();
}

class _StartTarotTestBottomSheetState extends State<StartTarotTestBottomSheet> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.77,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 13, 32),
          border: GradientBoxBorder(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(255, 223, 130, 255).withOpacity(0.8),
                  const Color.fromARGB(255, 223, 130, 255).withOpacity(0.6),
                  const Color.fromARGB(255, 241, 198, 255).withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
              width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            '- ${AppLocalizations.of(context)!.activity_chat_room_tarot_test_question_title} -',
                            style: const TextStyle(
                                height: 1.0,
                                color: Color.fromARGB(255, 223, 130, 255),
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!
                                .activity_chat_room_tarot_test_question_slogan,
                            style: TextStyle(
                                height: 1.0,
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )),
                  const CustomSeparator(
                      height: 2, color: Color.fromARGB(255, 241, 198, 255)),
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .activity_chat_room_tarot_test_question_enter,
                          style: const TextStyle(
                              height: 1.0,
                              color: Color.fromARGB(255, 241, 198, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .activity_chat_room_tarot_test_question_enter_description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 4 / 3,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 198, 255)
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                height: 1.71,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            minLines: 10,
                            maxLines: 10,
                            controller: textEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(16),
                                hintText: AppLocalizations.of(context)!
                                    .activity_chat_room_tarot_test_question_enter_description_placeholder,
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    height: 1.71,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              child: ElevatedButton(
                            style: ButtonStyle(
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 223, 130, 255),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromARGB(255, 12, 13, 32))),
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                                AppLocalizations.of(context)!
                                    .activity_chat_room_tarot_test_cancel,
                                style: const TextStyle(
                                    height: 1.2,
                                    color: Color.fromARGB(255, 223, 130, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          )),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12)),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 223, 130, 255),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(
                                          255, 223, 130, 255))),
                              onPressed: () {
                                context.pop(textEditingController.text);
                              },
                              child:  Text(AppLocalizations.of(context)!.activity_chat_room_tarot_test_start,
                                  style:const TextStyle(
                                      height: 1.2,
                                      color: Color.fromARGB(255, 12, 13, 32),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }
}

class CustomSeparator extends StatelessWidget {
  const CustomSeparator(
      {super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
