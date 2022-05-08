import 'package:animebrowser/api/repositories/media_details_repository.dart';
import 'package:animebrowser/blocs/media/media_details_state.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/exceptions/api_exception.dart';
import 'package:animebrowser/utils/helpers/loggers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDetailsCubit extends Cubit<MediaDetailsState> with BlocLoggy {
  final IDetailsRepository _repository;

  MediaDetailsCubit()
      : _repository = getIt.get<IDetailsRepository>(),
        super(MediaDetailsState.loading());

  Future<void> retrieveDetails(int mediaID) async {
    loggy.info('Retrieve details for $mediaID');

    emit(MediaDetailsState.loading());
    try {
      final details = await _repository.fetchMedia(mediaID);
      emit(MediaDetailsState.successful(details));
    } on ApiException catch (e) {
      loggy.error(e.toString(), e);
      emit(MediaDetailsState.failed(e.toString()));
    } catch (e) {
      loggy.error(e.toString(), e);
      emit(MediaDetailsState.failed('Unknown application error'));
    }
  }
}
