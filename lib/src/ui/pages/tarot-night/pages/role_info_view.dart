import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tata/src/core/providers/pages/tarot-night/role_info_view_provider.dart';

class TarotNightRoleInfoView extends ConsumerWidget {
  const TarotNightRoleInfoView({super.key, required this.roomId});

  final String roomId;
  static const routeName = 'role-info';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tarotNightRoleInfoViewProvider(roomId)).when(
        data: (role) => Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 12, 13, 32),
              title: Text(AppLocalizations.of(context)!.activity_role_info,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600)),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 36),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 12, 13, 32),
                              Color.fromARGB(255, 26, 0, 58),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/star_2.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              AppLocalizations.of(context)!
                                  .activity_draw_your_role,
                              style: const TextStyle(
                                height: 1.0,
                                color: Color.fromARGB(255, 223, 130, 255),
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 16),
                            SvgPicture.asset(
                              'assets/images/star_2.svg',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 320,
                                    width: 320,
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 241, 198, 255),
                                        width: 3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(13),
                                        child: Image.asset(role!.image,
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    height: 320,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Opacity(
                                                  opacity: 0.6,
                                                  child: SvgPicture.asset(
                                                      'assets/images/star_4.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  198,
                                                                  255),
                                                              BlendMode.srcIn),
                                                      width: 20,
                                                      height: 24)),
                                              const Spacer(),
                                              Opacity(
                                                  opacity: 0.6,
                                                  child: SvgPicture.asset(
                                                      'assets/images/star_4.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  198,
                                                                  255),
                                                              BlendMode.srcIn),
                                                      width: 20,
                                                      height: 24))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Row(
                                            children: [
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: SvgPicture.asset(
                                                      'assets/images/star_4.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  198,
                                                                  255),
                                                              BlendMode.srcIn),
                                                      width: 16,
                                                      height: 16)),
                                              const Spacer(),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: SvgPicture.asset(
                                                      'assets/images/star_4.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  198,
                                                                  255),
                                                              BlendMode.srcIn),
                                                      width: 16,
                                                      height: 16)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 68),
                                          child: Row(
                                            children: [
                                              Opacity(
                                                  opacity: 0.2,
                                                  child: SvgPicture.asset(
                                                      'assets/images/star_4.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  198,
                                                                  255),
                                                              BlendMode.srcIn),
                                                      width: 12,
                                                      height: 12)),
                                              const Spacer(),
                                              Opacity(
                                                  opacity: 0.2,
                                                  child: SvgPicture.asset(
                                                      'assets/images/star_4.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color.fromARGB(
                                                                  255,
                                                                  241,
                                                                  198,
                                                                  255),
                                                              BlendMode.srcIn),
                                                      width: 12,
                                                      height: 12))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    role.tags.length,
                                    (index) => Container(
                                          margin: EdgeInsets.only(
                                              right:
                                                  index == role.tags.length - 1
                                                      ? 0
                                                      : 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    255, 241, 198, 255)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                              Role.getRoleTag(
                                                  context, role.tags[index]),
                                              style: const TextStyle(
                                                height: 12 / 7,
                                                color: Color.fromARGB(
                                                    255, 241, 198, 255),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        )),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  '- ${Role.getRoleName(context, role.name)} -',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    height: 1.0,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(height: 16),
                              Text(
                                  Role.getRoleDescription(
                                      context, role.description),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    height: 12 / 7,
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(height: 20),
                              Text(Role.getRoleIntro(context, role.intro),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 12 / 7,
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ))
                            ],
                          ),
                        )
                      ]))),
                )
              ],
            )),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Error: $error'));
  }
}
