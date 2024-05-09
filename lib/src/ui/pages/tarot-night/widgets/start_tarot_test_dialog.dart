import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<Object?> showStartTarotTestDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) {
      final TextEditingController textEditingController =
          TextEditingController();

      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 10))
                ]),
            height: 450,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Material(
                    child: Text(
                  '占星塔羅夜',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 10),
                const Material(
                    child: Text(
                  '輸入您想詢問的問題',
                  style: TextStyle(
                      color: Color.fromARGB(116, 126, 92, 43),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 250,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.only(top: 20),
                  child: Material(
                      child: TextFormField(
                    controller: textEditingController,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    minLines: 8,
                    maxLines: 8,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            '請靜下心來，細心感受困惑您的問題。輸入時要清晰明確，一旦提交，便無法更改。因此，在按下確認之前，請深思熟慮。'),
                  )),
                ),
                const Spacer(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('我再想想'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.pop(textEditingController.text);
                        },
                        child: const Text('開始測驗'),
                      ),
                    ])
              ],
            ),
          ),
        );
      });
    },
    barrierDismissible: false,
    barrierLabel: "Start Tarot Test",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
          position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child);
    },
  ).then(onClosed);
}
