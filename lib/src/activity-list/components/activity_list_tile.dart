import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tata/src/models/activity.dart';

class ActivityListTile extends StatelessWidget {
  final Activity activityInfo;

  const ActivityListTile({super.key, required this.activityInfo});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 175,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 137, 118, 82).withOpacity(0.2),
                border: Border.all(
                    color: const Color.fromARGB(255, 137, 118, 82)
                        .withOpacity(0.6),
                    width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: screenWidth * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Text(
                      activityInfo.name.toUpperCase(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 133, 114, 82),
                          fontFamily: 'MedievalSharp',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.5,
                          width: 20,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 137, 118, 82)
                                  .withOpacity(0.5)),
                        ),
                        TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 152, 129, 88)
                                          .withOpacity(0.8)),
                            ),
                            onPressed: () {},
                            child: Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: 'MedievalSharp',
                              ),
                            )),
                        Container(
                          width: screenWidth * 0.25,
                          height: 1.5,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 137, 118, 82)
                                  .withOpacity(0.5)),
                        )
                      ])
                ],
              ),
            ),
          ),
          Positioned(
              left: screenWidth * 0.45,
              top: 0,
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.85,
                        image: ExactAssetImage('assets/images/star.png'))),
                child: BackdropFilter(
                    blendMode: BlendMode.overlay,
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    )),
              )),
        ],
      ),
    );
  }
}
