import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tata/src/core/models/activity_info.dart';

class ActivityListTile extends StatelessWidget {
  final ActivityInfo activityInfo;

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
            padding: const EdgeInsets.all(20),
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
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activityInfo.name.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              // color: Color.fromARGB(255, 133, 114, 82),
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'MedievalSharp',
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(activityInfo.description,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontFamily: 'MedievalSharp',
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          activityInfo.timeDescription,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13,
                              fontFamily: 'MedievalSharp'),
                        ),
                        const Spacer(),
                        Text(
                          '>>> View Details >>>',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontFamily: 'MedievalSharp',
                          ),
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
                    // image: DecorationImage(
                    //     opacity: 0.85,
                    //     image: ExactAssetImage('assets/images/star.png')
                    //     )
                    ),
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
