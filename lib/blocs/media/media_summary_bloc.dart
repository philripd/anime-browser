import 'package:animebrowser/api/repositories/media_summary_repository.dart';
import 'package:animebrowser/blocs/media/media_event.dart';
import 'package:animebrowser/blocs/media/media_state.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/exceptions/api_exception.dart';
import 'package:animebrowser/utils/helpers/loggers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaSummaryBloc extends Bloc<MediaEvent, MediaState> with BlocLoggy {
  final IMediaSummaryRepository _repository;

  MediaSummaryBloc():
    _repository = getIt.get<IMediaSummaryRepository>(),
    super(MediaState.loading()) {
      on<RetrieveMediaEvent>(_onRetrieveSummaryEvent);
  }

  Future<void> _onRetrieveSummaryEvent(
    RetrieveMediaEvent event,
    Emitter<MediaState> emit,
  ) async {
    loggy.info('Retrieve summary');

    emit(MediaState.loading());
    try {
      final summaries = await _repository.fetchSummary(
        event.pageNumber,
        event.perPage,
      );
      emit(MediaState.successful(summaries));
    } on ApiException catch (e) {
      loggy.error(e.toString(), e);
      emit(MediaState.failed(e.toString()));
    } catch (e) {
      loggy.error(e.toString(), e);
      emit(MediaState.failed('Unknown application error'));
    }
  }
}
