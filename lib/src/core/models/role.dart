import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Role {
  final String id;
  final String name;
  final List<String> tags;
  final String description;
  final String image;
  final String intro;
  final List<String> quest;

  Role({
    required this.id,
    required this.name,
    required this.tags,
    required this.description,
    required this.image,
    required this.intro,
    required this.quest,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      tags: json['tags'] == null ? [] : List<String>.from(json['tags']),
      description: json['description'],
      image: json['image'],
      intro: json['intro'],
      quest: json['quest'] == null ? [] : List<String>.from(json['quest']),
    );
  }

  static String getRoleTag(BuildContext context, String key) {
    switch (key) {
      case 'fool_tag_1':
        return AppLocalizations.of(context)!.fool_tag_1;
      case 'fool_tag_2':
        return AppLocalizations.of(context)!.fool_tag_2;
      case 'death_tag_1':
        return AppLocalizations.of(context)!.death_tag_1;
      case 'death_tag_2':
        return AppLocalizations.of(context)!.death_tag_2;
      case 'hanged_man_tag_1':
        return AppLocalizations.of(context)!.hanged_man_tag_1;
      case 'hanged_man_tag_2':
        return AppLocalizations.of(context)!.hanged_man_tag_2;
      case 'empress_tag_1':
        return AppLocalizations.of(context)!.empress_tag_1;
      case 'empress_tag_2':
        return AppLocalizations.of(context)!.empress_tag_2;
      default:
        throw Exception('Role tag not found');
    }
  }

  static String getRoleName(BuildContext context, String key) {
    switch (key) {
      case 'fool_name':
        return AppLocalizations.of(context)!.fool_name;
      case 'death_name':
        return AppLocalizations.of(context)!.death_name;
      case 'hanged_man_name':
        return AppLocalizations.of(context)!.hanged_man_name;
      case 'empress_name':
        return AppLocalizations.of(context)!.empress_name;
      default:
        throw Exception('Role name not found');
    }
  }

  static String getRoleDescription(BuildContext context, String key) {
    switch (key) {
      case 'fool_description':
        return AppLocalizations.of(context)!.fool_description_content;
      case 'death_description':
        return AppLocalizations.of(context)!.death_description_content;
      case 'hanged_man_description':
        return AppLocalizations.of(context)!.hanged_man_description_content;
      case 'empress_description':
        return AppLocalizations.of(context)!.empress_description_content;
      default:
        throw Exception('Role description not found');
    }
  }

  static getRoleIntro(BuildContext context, String key) {
    switch (key) {
      case 'fool_intro':
      case 'fool_name':
        return AppLocalizations.of(context)!.fool_intro;
      case 'death_intro':
      case 'death_name':
        return AppLocalizations.of(context)!.death_intro;
      case 'hanged_man_intro':
      case 'hanged_man_name':
        return AppLocalizations.of(context)!.hanged_man_intro;
      case 'empress_intro':
      case 'empress_name':
        return AppLocalizations.of(context)!.empress_intro;
      default:
        throw Exception('Role intro not found');
    }
  }

  static getRoleQuest(BuildContext context, String key) {
    switch (key) {
      case 'fool_quest_1':
        return AppLocalizations.of(context)!.fool_quest_1;
      case 'fool_quest_2':
        return AppLocalizations.of(context)!.fool_quest_2;
      case 'fool_quest_3':
        return AppLocalizations.of(context)!.fool_quest_3;
      case 'death_quest_1':
        return AppLocalizations.of(context)!.death_quest_1;
      case 'death_quest_2':
        return AppLocalizations.of(context)!.death_quest_2;
      case 'death_quest_3':
        return AppLocalizations.of(context)!.death_quest_3;
      case 'hanged_man_quest_1':
        return AppLocalizations.of(context)!.hanged_man_quest_1;
      case 'hanged_man_quest_2':
        return AppLocalizations.of(context)!.hanged_man_quest_2;
      case 'hanged_man_quest_3':
        return AppLocalizations.of(context)!.hanged_man_quest_3;
      case 'empress_quest_1':
        return AppLocalizations.of(context)!.empress_quest_1;
      case 'empress_quest_2':
        return AppLocalizations.of(context)!.empress_quest_2;
      case 'empress_quest_3':
        return AppLocalizations.of(context)!.empress_quest_3;
      default:
        throw Exception('Role quest not found');
    }
  }
}
