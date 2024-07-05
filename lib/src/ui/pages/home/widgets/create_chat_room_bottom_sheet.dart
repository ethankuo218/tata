import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/chat_room.dart';

Future<void> showCreateChatRoomBottomSheet(BuildContext context,
    {required CreateChatRoomBottomSheetMode mode,
    ChatRoom? roomInfo,
    required ValueChanged onClosed}) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) {
        return CreateChatRoomBottomSheet(mode: mode, roomInfo: roomInfo);
      }).then(onClosed);
}

class CreateChatRoomBottomSheet extends StatefulWidget {
  const CreateChatRoomBottomSheet(
      {super.key, required this.mode, this.roomInfo});

  final CreateChatRoomBottomSheetMode mode;
  final ChatRoom? roomInfo;

  @override
  State<CreateChatRoomBottomSheet> createState() =>
      _CreateChatRoomBottomSheetState();
}

class _CreateChatRoomBottomSheetState extends State<CreateChatRoomBottomSheet> {
  static const categoryList = [
    'All',
    'Romance',
    'Work',
    'Interest',
    'Sport',
    'ChitChat',
    'School'
  ];

  final _formKey = GlobalKey<FormState>();
  int? _selectedCategory;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int? maxParticipants;

  bool _showNotSelectCategoryError = false;

  @override
  void initState() {
    if (widget.mode == CreateChatRoomBottomSheetMode.edit) {
      _selectedCategory = categoryList.indexOf(widget.roomInfo!.category);
      titleController.text = widget.roomInfo!.title;
      descriptionController.text = widget.roomInfo!.description;
      maxParticipants = widget.roomInfo!.limit;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 672,
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
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                children: [
                  Form(
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
                                '聊天室名稱',
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
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? '請輸入聊天室名稱'
                                      : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: "輸入聊天室名稱",
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
                                '類別',
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
                            spacing: 8,
                            children: List<Widget>.generate(
                              categoryList.length,
                              (int index) {
                                return ChoiceChip(
                                  showCheckmark: false,
                                  backgroundColor:
                                      const Color.fromARGB(255, 12, 13, 32),
                                  selectedColor:
                                      const Color.fromARGB(255, 12, 13, 32),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: const Color.fromARGB(
                                                  255, 241, 198, 255)
                                              .withOpacity(
                                                  _selectedCategory == index
                                                      ? 1
                                                      : 0.2),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(8)),
                                  label: Text(categoryList[index]),
                                  labelStyle: const TextStyle(
                                    height: 1.0,
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  selected: _selectedCategory == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedCategory =
                                          selected ? index : null;
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                          _showNotSelectCategoryError
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
                                '心情描述',
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
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter the description'
                                      : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: "最近在想什麼呢？",
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      height: 1.71,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
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
                                '參與人數',
                                style: TextStyle(
                                    height: 1.0,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 198, 255)
                                          .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(25)),
                              child: DropdownButtonFormField(
                                alignment: Alignment.center,
                                validator: (value) =>
                                    value == null ? '請選擇參與人數' : null,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                value: 2,
                                dropdownColor:
                                    const Color.fromARGB(255, 43, 44, 48),
                                onChanged: (int? value) {
                                  setState(() {
                                    maxParticipants = value;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('2',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('3',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text('4',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text('5',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showNotSelectCategoryError =
                                      _selectedCategory == null;
                                });

                                if (!_formKey.currentState!.validate() ||
                                    _selectedCategory == null) {
                                  return;
                                }

                                Navigator.pop(context, {
                                  "category": categoryList[_selectedCategory!],
                                  "title": titleController.text,
                                  "description": descriptionController.text,
                                  "limit": maxParticipants
                                });
                              },
                              child: Text(
                                widget.mode ==
                                        CreateChatRoomBottomSheetMode.create
                                    ? "創建"
                                    : "確定",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 12, 13, 32),
                                    height: 1.2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            )));
  }
}

enum CreateChatRoomBottomSheetMode { create, edit }
