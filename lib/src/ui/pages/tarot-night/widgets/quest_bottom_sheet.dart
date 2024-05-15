import 'package:flutter/material.dart';

Future<void> showQuestBottomSheet(BuildContext context,
    {required String quest, required ValueChanged onClosed}) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) {
        return QuestBottomSheet(quest: quest);
      }).then(onClosed);
}

class QuestBottomSheet extends StatefulWidget {
  const QuestBottomSheet({super.key, required this.quest});

  final String quest;

  @override
  State<QuestBottomSheet> createState() => _QuestBottomSheetState();
}

class _QuestBottomSheetState extends State<QuestBottomSheet> {
  static final _formKey = GlobalKey<FormState>();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String question = widget.quest;

    return Container(
      height: 600,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 40, 40),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 137, 118, 82)
                                      .withOpacity(0.3),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                              255, 137, 118, 82)
                                          .withOpacity(0.6),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                minLines: 10,
                                maxLines: 10,
                                controller: answerController,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter the answer'
                                        : null,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    hintText: "輸入文字來完成任務",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(
                                            255, 160, 160, 160))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 137, 118, 82)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  Navigator.pop(context, answerController.text);
                                },
                                child: const Text(
                                  "送出回答",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ]),
                    )),
              ],
            ),
          )),
    );
  }
}
