import 'package:animebrowser/api/repositories/seasonal_anime_repository.dart';
import 'package:animebrowser/blocs/media/media_event.dart';
import 'package:animebrowser/blocs/media/media_state.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/exceptions/api_exception.dart';
import 'package:animebrowser/utils/helpers/loggers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeasonalAnimeBloc extends Bloc<MediaEvent, MediaState> with BlocLoggy {
  final ISeasonalAnimeRepository _repository;

  SeasonalAnimeBloc():
    _repository = getIt.get<ISeasonalAnimeRepository>(),
    super(MediaState.loading()) {
      on<RetrieveMediaEvent>(_onRetrieveSeasonalAnimeEvent);
  }

  Future<void> _onRetrieveSeasonalAnimeEvent(
    RetrieveMediaEvent event,
    Emitter<MediaState> emit,
  ) async {
    loggy.info('Retrieve seasonal anime');

    emit(MediaState.loading());
    try {
      final summaries = await _repository.fetchSeasonalAnime(
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
