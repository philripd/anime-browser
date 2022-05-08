import 'package:animebrowser/api/models/media_list_model.dart';
import 'package:animebrowser/blocs/status_enum.dart';
import 'package:equatable/equatable.dart';

class MediaState extends Equatable {
  final StatusEnum status;
  final List<SummaryModel> data;
  final String? errorMessage;

  const MediaState({
    required this.status,
    this.data = const <SummaryModel>[],
    this.errorMessage,
  });

  factory MediaState.loading() => const MediaState(
    status: StatusEnum.loading,
  );

  factory MediaState.successful(List<SummaryModel> summaries) => MediaState(
    status: StatusEnum.successful,
    data: summaries,
  );

  factory MediaState.failed(String errorMessage) => MediaState(
    status: StatusEnum.failed,
    errorMessage: errorMessage,
  );

  @override
  List<Object?> get props => [
    status,
    List<SummaryModel>.from(data),
    errorMessage,
  ];
}
