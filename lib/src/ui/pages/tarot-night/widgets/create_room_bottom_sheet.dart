import 'package:flutter/material.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';

Future<void> showCreateTarotNightRoomBottomSheet(BuildContext context,
    {required ValueChanged onClosed}) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) {
        return const CreateTarotNightRoomBottomSheet();
      }).then(onClosed);
}

class CreateTarotNightRoomBottomSheet extends StatefulWidget {
  const CreateTarotNightRoomBottomSheet({super.key});

  @override
  State<CreateTarotNightRoomBottomSheet> createState() =>
      _CreateTarotNightRoomBottomSheetState();
}

class _CreateTarotNightRoomBottomSheetState
    extends State<CreateTarotNightRoomBottomSheet> {
  static const themeList = <TarotNightRoomTheme>[
    TarotNightRoomTheme.work,
    TarotNightRoomTheme.relation,
    TarotNightRoomTheme.family,
    TarotNightRoomTheme.friend,
  ];

  static final _formKey = GlobalKey<FormState>();
  int? _selectedTheme;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _showNotSelectThemeError = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '詳述困擾你的事，讓心事獲得共鳴',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
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
                                controller: descriptionController,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter the description'
                                        : null,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    hintText:
                                        "在這個安全的空間，可以放心訴說您的情緒。描述一下，最近有什麼事情讓你感到掛慮或困惑？請盡可能提供細節才能獲得解答",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(
                                            255, 160, 160, 160))),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            const Text(
                              '主題',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 5.0,
                              children: List<Widget>.generate(
                                themeList.length,
                                (int index) {
                                  return ChoiceChip(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    label: Text(TarotNightRoomTheme.toText(
                                        themeList[index])),
                                    selected: _selectedTheme == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedTheme =
                                            selected ? index : null;
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                            _showNotSelectThemeError
                                ? const Text(
                                    'Please select the category',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 179, 38, 30),
                                        fontSize: 12),
                                  )
                                : const SizedBox(),
                            SizedBox(height: screenHeight * 0.04),
                            const Text(
                              '用一句話描繪你此刻的心境',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
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
                                minLines: 3,
                                maxLines: 3,
                                controller: titleController,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter the title'
                                        : null,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    hintText: "Enter the title",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(
                                            255, 160, 160, 160))),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
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
                                  setState(() {
                                    _showNotSelectThemeError =
                                        _selectedTheme == null;
                                  });

                                  if (!_formKey.currentState!.validate() ||
                                      _selectedTheme == null) {
                                    return;
                                  }

                                  Navigator.pop(context, {
                                    "theme": themeList[_selectedTheme!],
                                    "title": titleController.text,
                                    "description": descriptionController.text
                                  });
                                },
                                child: const Text(
                                  "開啟新世之門，創建你的夜話空間",
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
