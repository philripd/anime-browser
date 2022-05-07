import 'package:animebrowser/api/repositories/details_repository.dart';
import 'package:animebrowser/blocs/details/details_state.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/exceptions/api_exception.dart';
import 'package:animebrowser/utils/helpers/loggers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState> with BlocLoggy {
  final IDetailsRepository _repository;

  DetailsCubit()
      : _repository = getIt.get<IDetailsRepository>(),
        super(DetailsState.loading());

  Future<void> retrieveDetails(int mediaID) async {
    loggy.info('Retrieve details for $mediaID');

    emit(DetailsState.loading());
    try {
      final details = await _repository.fetchMedia(mediaID);
      emit(DetailsState.successful(details));
    } on ApiException catch (e) {
      loggy.error(e.toString(), e);
      emit(DetailsState.failed(e.toString()));
    } catch (e) {
      loggy.error(e.toString(), e);
      emit(DetailsState.failed('Unknown application error'));
    }
  }
}
