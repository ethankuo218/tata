import 'package:flutter/material.dart';

import '../models/chat_room.dart';

Future<Object?> createChatRoomDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late ChatRoomType selectedType = ChatRoomType.normal;

  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Create chat room",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Center(
            child: Container(
              height: screenHeight * 0.6,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(children: [
                      const Text(
                        "Create Chat Room",
                        style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Customize your space, and within moments, engage in meaningful dialogues in your very own tailored chat room.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                              labelText: "Title",
                              hintText: "Enter the title of the chat room"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                              labelText: "Description",
                              hintText:
                                  "Enter the description of the chat room"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonFormField<ChatRoomType>(
                          decoration: const InputDecoration(
                              labelText: "Type",
                              hintText: "Select the type of the chat room"),
                          value: selectedType,
                          onChanged: (ChatRoomType? newValue) {
                            selectedType = newValue!;
                          },
                          items: <ChatRoomType>[ChatRoomType.normal]
                              .map<DropdownMenuItem<ChatRoomType>>(
                                  (ChatRoomType value) {
                            return DropdownMenuItem<ChatRoomType>(
                              value: value,
                              child: Text(ChatRoomType.toText(value.enumValue)),
                            );
                          }).toList(),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30)),
                      // create button
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop({
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "type": selectedType,
                              "limit": 2
                            });
                          },
                          child: const Text("Create")),
                    ])
                  ],
                ),
              ),
            ),
          )).then(onClosed);
}
