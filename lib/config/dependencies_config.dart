import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/repositories/media_details_repository.dart';
import 'package:animebrowser/api/repositories/seasonal_anime_repository.dart';
import 'package:animebrowser/blocs/media/media_details_cubit.dart';
import 'package:animebrowser/blocs/seasonal_anime/seasonal_anime_bloc.dart';
import 'package:animebrowser/blocs/media/media_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';

final GetIt getIt = GetIt.instance;

void initializeDependencies() {
  Loggy.initLoggy();

  getIt.registerSingleton<APIProvider>(APIProvider());
  getIt.registerSingleton<ISeasonalAnimeRepository>(SeasonalAnimeRepository());
  getIt.registerSingleton<IDetailsRepository>(DetailsRepository());
}

MultiBlocProvider initializeBlocs({
  required Widget mainAppWidget,
}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<SeasonalAnimeBloc>(
        create: (_) => SeasonalAnimeBloc()..add(const RetrieveMediaEvent(1, 50)),
      ),
      BlocProvider<MediaDetailsCubit>(create: (_) => MediaDetailsCubit()),
    ],
    child: mainAppWidget,
  );
}
