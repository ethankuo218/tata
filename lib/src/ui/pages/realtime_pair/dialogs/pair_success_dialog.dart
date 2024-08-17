import 'package:flutter/material.dart';

Future<Object?> showPairSuccessDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Pair Success",
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
      pageBuilder: (context, _, __) => Scaffold(
              body: Center(
            child: Container(
              height: screenHeight * 0.6,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.2),
                  const Text('Paired !',
                      style: TextStyle(color: Colors.white, fontSize: 50)),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Start Chat')),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.1)
                ],
              ),
            ),
          ))).then(onClosed);
}
