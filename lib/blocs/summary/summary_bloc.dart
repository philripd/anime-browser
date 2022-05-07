import 'package:animebrowser/api/repositories/summary_repository.dart';
import 'package:animebrowser/blocs/summary/summary_event.dart';
import 'package:animebrowser/blocs/summary/summary_state.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/exceptions/api_exception.dart';
import 'package:animebrowser/utils/helpers/loggers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> with BlocLoggy {
  final ISummaryRepository _repository;

  SummaryBloc()
      : _repository = getIt.get<ISummaryRepository>(),
        super(SummaryState.loading()) {
    on<RetrieveSummaryEvent>(_onRetrieveSummaryEvent);
  }

  Future<void> _onRetrieveSummaryEvent(
    RetrieveSummaryEvent event,
    Emitter<SummaryState> emit,
  ) async {
    loggy.info('Retrieve summary');

    emit(SummaryState.loading());
    try {
      final summaries = await _repository.fetchSummary(
        event.pageNumber,
        event.perPage,
      );
      emit(SummaryState.successful(summaries));
    } on ApiException catch (e) {
      loggy.error(e.toString(), e);
      emit(SummaryState.failed(e.toString()));
    } catch (e) {
      loggy.error(e.toString(), e);
      emit(SummaryState.failed('Unknown application error'));
    }
  }
}
