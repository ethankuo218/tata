import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showCreateTarotNightRoomBottomSheet(BuildContext context,
    {required CreateTarotNightRoomBottomSheetMode mode,
    TarotNightRoom? roomInfo,
    required ValueChanged onClosed}) async {
  await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          builder: (context) =>
              CreateTarotNightRoomBottomSheet(mode: mode, roomInfo: roomInfo))
      .then(onClosed);
}

class CreateTarotNightRoomBottomSheet extends StatefulWidget {
  const CreateTarotNightRoomBottomSheet(
      {super.key, required this.mode, required this.roomInfo});

  final CreateTarotNightRoomBottomSheetMode mode;
  final TarotNightRoom? roomInfo;

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
  void initState() {
    super.initState();

    if (widget.mode == CreateTarotNightRoomBottomSheetMode.edit) {
      _selectedTheme = themeList.indexOf(widget.roomInfo!.theme);
      titleController.text = widget.roomInfo!.title;
      descriptionController.text = widget.roomInfo!.description;
    }
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                            opacity: 0.4,
                            child: SvgPicture.asset(
                              'assets/images/star_2.svg',
                              width: 20,
                              height: 20,
                            )),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .activity_lobby_activity_room_title,
                              maxLines: 2,
                              style: const TextStyle(
                                  height: 1.2,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ))
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
                            ? AppLocalizations.of(context)!
                                .activity_lobby_activity_room_tile_no_enter
                            : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                            hintText: AppLocalizations.of(context)!
                                .activity_lobby_activity_room_title_placeholder,
                            hintStyle: TextStyle(
                                height: 1.71,
                                fontSize: 16,
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
                        Text(
                          AppLocalizations.of(context)!
                              .activity_room_toast_activity_toast_category,
                          style: const TextStyle(
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
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: const Color.fromARGB(
                                            255, 241, 198, 255)
                                        .withOpacity(
                                            _selectedTheme == index ? 1 : 0.2),
                                    width: 2),
                                borderRadius: BorderRadius.circular(8)),
                            label: Text(TarotNightRoomTheme.toText(
                                context, themeList[index])),
                            labelStyle: const TextStyle(
                              height: 1.0,
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                            opacity: 0.4,
                            child: SvgPicture.asset(
                              'assets/images/star_2.svg',
                              width: 20,
                              height: 20,
                            )),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .activity_lobby_activity_room_description,
                              style: const TextStyle(
                                  height: 1.2,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ))
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
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        minLines: 9,
                        maxLines: 9,
                        controller: descriptionController,
                        validator: (value) => value == null || value.isEmpty
                            ? AppLocalizations.of(context)!
                                .activity_lobby_activity_room_description_no_enter
                            : null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                            hintText: AppLocalizations.of(context)!
                                .activity_lobby_activity_room_description_placeholder,
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                height: 1.71,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 223, 130, 255)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
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
                        child: Text(
                          AppLocalizations.of(context)!
                              .activity_lobby_activity_create,
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
          )),
    );
  }
}

enum CreateTarotNightRoomBottomSheetMode { create, edit }
