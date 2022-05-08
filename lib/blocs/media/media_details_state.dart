import 'package:animebrowser/api/models/media_details_model.dart';
import 'package:animebrowser/blocs/status_enum.dart';
import 'package:equatable/equatable.dart';

class MediaDetailsState extends Equatable {
  final StatusEnum status;
  final MediaDetailsModel? data;
  final String? errorMessage;

  const MediaDetailsState({
    required this.status,
    this.data,
    this.errorMessage,
  });

  factory MediaDetailsState.loading() => const MediaDetailsState(
        status: StatusEnum.loading,
      );

  factory MediaDetailsState.successful(MediaDetailsModel details) => MediaDetailsState(
        status: StatusEnum.successful,
        data: details,
      );

  factory MediaDetailsState.failed(String errorMessage) => MediaDetailsState(
        status: StatusEnum.failed,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, data, errorMessage];
}
