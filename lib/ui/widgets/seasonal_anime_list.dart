import 'package:animebrowser/blocs/seasonal_anime/seasonal_anime_bloc.dart';
import 'package:animebrowser/blocs/status_enum.dart';
import 'package:animebrowser/blocs/summary/summary_bloc.dart';
import 'package:animebrowser/blocs/media/media_event.dart';
import 'package:animebrowser/blocs/media/media_state.dart';
import 'package:animebrowser/ui/widgets/media_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeasonalAnimeList extends StatelessWidget {
  const SeasonalAnimeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeasonalAnimeBloc, MediaState>(
      builder: (BuildContext context, MediaState state) {
        if (state.status == StatusEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == StatusEnum.failed) {
          return Center(child: Text(state.errorMessage ?? 'Unknown'));
        } else if (state.status == StatusEnum.successful) {
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<SummaryBloc>(context)
                  .add(const RetrieveMediaEvent(1, 50));
              return Future.delayed(const Duration(milliseconds: 150));
            },
            child: ListView.separated(
              itemCount: state.data.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
              itemBuilder: (_, int index) => MediaListItem(
                data: state.data[index],
              ),
            ),
          );
        } else {
          return const Center(
              child: Text('Application error')
          );
        }
      },
    );
  }
}