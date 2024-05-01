import 'package:flutter/material.dart';
import 'package:tata/src/ui/tarot.dart';

Future<void> showCreateChatRoomBottomSheet(BuildContext context,
    {required ValueChanged onClosed}) async {
  await showModalBottomSheet(
      backgroundColor: Colors.purple,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) {
        return const CreateChatRoomBottomSheet();
      }).then(onClosed);
}

class CreateChatRoomBottomSheet extends StatefulWidget {
  const CreateChatRoomBottomSheet({super.key});

  @override
  State<CreateChatRoomBottomSheet> createState() =>
      _CreateChatRoomBottomSheetState();
}

class _CreateChatRoomBottomSheetState extends State<CreateChatRoomBottomSheet> {
  static const categoryList = [
    'All',
    'Relation',
    'Work',
    'Interest',
    'Sport',
    'Chat',
    'School'
  ];

  final _formKey = GlobalKey<FormState>();
  int? _selectedCategory;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int? maxParticipants;

  bool _showNotSelectCategoryError = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: screenHeight * 0.1,
          child: const Center(
              child: Text(
            'Create Chat Room',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
        ),
        Container(
          height: screenHeight * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 5.0,
                                  children: List<Widget>.generate(
                                    categoryList.length,
                                    (int index) {
                                      return ChoiceChip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        label: Text(categoryList[index]),
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
                                            color: Color.fromARGB(
                                                255, 179, 38, 30),
                                            fontSize: 12),
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 10),
                                const Text(
                                  'Title',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 238, 238, 238),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    onTapOutside: (event) => FocusManager
                                        .instance.primaryFocus
                                        ?.unfocus(),
                                    controller: titleController,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter the title'
                                            : null,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        hintText: "Enter the title",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 160))),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 238, 238, 238),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    onTapOutside: (event) => FocusManager
                                        .instance.primaryFocus
                                        ?.unfocus(),
                                    minLines: 5,
                                    maxLines: 5,
                                    controller: descriptionController,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter the description'
                                            : null,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        hintText: "Enter the description",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 160))),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                const Text(
                                  'Max Participants',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 238, 238, 238),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: DropdownButtonFormField(
                                      validator: (value) => value == null
                                          ? 'Please select the number of participants'
                                          : null,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 160)),
                                      ),
                                      value: 2,
                                      onChanged: (int? value) {
                                        setState(() {
                                          maxParticipants = value;
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text('2'),
                                        ),
                                        DropdownMenuItem(
                                          value: 3,
                                          child: Text('3'),
                                        ),
                                        DropdownMenuItem(
                                          value: 4,
                                          child: Text('4'),
                                        ),
                                        DropdownMenuItem(
                                          value: 5,
                                          child: Text('5'),
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
                                        "category":
                                            categoryList[_selectedCategory!],
                                        "title": titleController.text,
                                        "description":
                                            descriptionController.text,
                                        "limit": maxParticipants,
                                        "backgroundImage": Tarot.getRandomCard()
                                      });
                                    },
                                    child: const Text(
                                      "Create",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ]),
                        )),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
