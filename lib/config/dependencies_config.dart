import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/repositories/details_repository.dart';
import 'package:animebrowser/api/repositories/summary_repository.dart';
import 'package:animebrowser/blocs/details/details_cubit.dart';
import 'package:animebrowser/blocs/summary/summary_bloc.dart';
import 'package:animebrowser/blocs/summary/summary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';

final GetIt getIt = GetIt.instance;

void initializeDependencies() {
  Loggy.initLoggy();

  getIt.registerSingleton<ApiProvider>(ApiProvider());
  getIt.registerSingleton<ISummaryRepository>(SummaryRepository());
  getIt.registerSingleton<IDetailsRepository>(DetailsRepository());
}

MultiBlocProvider initializeBlocs({
  required Widget mainAppWidget,
}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<SummaryBloc>(
        create: (_) => SummaryBloc()..add(const RetrieveSummaryEvent(1, 50)),
      ),
      BlocProvider<DetailsCubit>(create: (_) => DetailsCubit()),
    ],
    child: mainAppWidget,
  );
}
