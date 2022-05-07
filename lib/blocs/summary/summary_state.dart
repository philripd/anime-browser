import 'package:animebrowser/api/models/summary_model.dart';
import 'package:animebrowser/blocs/status_enum.dart';
import 'package:equatable/equatable.dart';

class SummaryState extends Equatable {
  final StatusEnum status;
  final List<SummaryModel> data;
  final String? errorMessage;

  const SummaryState({
    required this.status,
    this.data = const <SummaryModel>[],
    this.errorMessage,
  });

  factory SummaryState.loading() => const SummaryState(
        status: StatusEnum.loading,
      );

  factory SummaryState.successful(List<SummaryModel> summaries) => SummaryState(
        status: StatusEnum.successful,
        data: summaries,
      );

  factory SummaryState.failed(String errorMessage) => SummaryState(
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
