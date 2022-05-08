import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@sealed
abstract class MediaEvent extends Equatable {
  const MediaEvent._();

  @protected
  const factory MediaEvent.retrieve(
    int page,
    int perPage,
  ) = RetrieveMediaEvent;
}

class RetrieveMediaEvent extends MediaEvent {
  final int pageNumber;
  final int perPage;

  const RetrieveMediaEvent(
    this.pageNumber,
    this.perPage,
  ) : super._();

  @override
  List<Object?> get props => [pageNumber, perPage];
}
