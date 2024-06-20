import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';

Future<void> showCreateTarotNightRoomBottomSheet(BuildContext context,
    {required ValueChanged onClosed}) async {
  await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          builder: (context) => const CreateTarotNightRoomBottomSheet())
      .then(onClosed);
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
      height: screenHeight * 0.77,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 13, 32),
          border: Border.all(
              color: const Color.fromARGB(255, 241, 198, 255), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Opacity(
                              opacity: 0.4,
                              child: SvgPicture.asset(
                                'assets/images/star_2.svg',
                                width: 20,
                                height: 20,
                              )),
                          const SizedBox(width: 4),
                          const Text(
                            '用一句話描繪你此刻的心境',
                            style: TextStyle(
                                height: 1.0,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 198, 255)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          minLines: 1,
                          maxLines: 1,
                          controller: titleController,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter the title'
                              : null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                              hintText: "此心情會變為你的房間名稱",
                              hintStyle: TextStyle(
                                  height: 1.71,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.5))),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Opacity(
                              opacity: 0.4,
                              child: SvgPicture.asset(
                                'assets/images/star_2.svg',
                                width: 20,
                                height: 20,
                              )),
                          const SizedBox(width: 4),
                          const Text(
                            '主題',
                            style: TextStyle(
                                height: 1.0,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        children: List<Widget>.generate(
                          themeList.length,
                          (int index) {
                            return ChoiceChip(
                              showCheckmark: false,
                              backgroundColor:
                                  const Color.fromARGB(255, 12, 13, 32),
                              selectedColor:
                                  const Color.fromARGB(255, 12, 13, 32),
                              avatarBorder: const CircleBorder(
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 241, 198, 255),
                                      width: 2)),
                              padding: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: const Color.fromARGB(
                                              255, 241, 198, 255)
                                          .withOpacity(0.2),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              label: Text(
                                  TarotNightRoomTheme.toText(themeList[index]),
                                  style: const TextStyle(
                                    height: 1.0,
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                              selected: _selectedTheme == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedTheme = selected ? index : null;
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
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Opacity(
                              opacity: 0.4,
                              child: SvgPicture.asset(
                                'assets/images/star_2.svg',
                                width: 20,
                                height: 20,
                              )),
                          const SizedBox(width: 4),
                          const Text(
                            '什麼事情讓您感到不安或迷惘呢？',
                            style: TextStyle(
                                height: 1.0,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
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
                          minLines: 9,
                          maxLines: 9,
                          controller: descriptionController,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter the description'
                              : null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                              hintText:
                                  "在這個安全的空間，您的心事將被傾聽與尊重，詳細描述每一個感受，更能探討藏在內心的秘密。",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 1.71,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 223, 130, 255)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {
                            setState(() {
                              _showNotSelectThemeError = _selectedTheme == null;
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
                            "開啟心事之門，創建你的夜話空間",
                            style: TextStyle(
                                color: Color.fromARGB(255, 12, 13, 32),
                                height: 1.0,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
