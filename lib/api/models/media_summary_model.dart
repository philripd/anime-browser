import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:flutter/material.dart';

@immutable
class MediaSummaryModel {
  final int id;
  final Pair<String, String?> title;
  final String description;
  final String coverImage;

  const MediaSummaryModel._({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
  });

  factory MediaSummaryModel.fromJson(Map<String, dynamic> json) => MediaSummaryModel._(
    id: json['id'] as int,
    title: Pair(
      json['title']['romaji'] as String,
      json['title']['english'] as String?,
    ),
    description: ((json['description'] as String)
      // Cut description if word count exceeds this value
      .split(' ')).length < 20
      ? (json['description'] as String)
        .replaceAll(RegExp(r'<[^>]*>'), '')
      : (json['description'] as String)
        .split(' ')
        .sublist(0, 20)
        .join(' ')
        .replaceAll(RegExp(r'<[^>]*>'), '')
      + ' ...',
    coverImage: json['coverImage']['extraLarge'] as String,
  );
}
