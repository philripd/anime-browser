import 'package:animebrowser/api/models/media_details_model.dart';
import 'package:animebrowser/blocs/media/media_details_cubit.dart';
import 'package:animebrowser/blocs/media/media_details_state.dart';
import 'package:animebrowser/blocs/status_enum.dart';
import 'package:animebrowser/utils/helpers/time.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  static const String routeName = '/details';
  static void navigateTo(BuildContext context) {
    Navigator.pushNamed(context, DetailsPage.routeName);
  }

  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<MediaDetailsCubit, MediaDetailsState>(
        builder: (BuildContext context, MediaDetailsState state) {
          if (state.status == StatusEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == StatusEnum.failed) {
            return Center(child: Text(state.errorMessage ?? 'Unknown'));
          } else if (state.status == StatusEnum.successful &&
              state.data != null) {
            final data = state.data as MediaDetailsModel;
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(45),
                    1: FlexColumnWidth(55),
                  },
                  children: [
                    TableRow(
                      children: [
                        Image.network(
                          data.coverImage,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title.second != null
                                  ? '${data.title.second}'
                                  : data.title.first,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  data.title.second != null
                                    ? '(${data.title.first})'
                                    : "",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  data.seasonYear != null
                                    ? '${data.seasonYear}'
                                    : "",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                ),
                              ),
                              if (data.format != null && data.episodes != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    data.episodes == 1
                                      ? '${data.format} • 1 episode'
                                      : '${data.format} • ${data.episodes} episodes',
                                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ),
                              if (data.format != null && data.episodes == null)
                                Padding(
                                padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${data.format}',
                                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star_outlined,
                                      color: Colors.orangeAccent,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        '${data.averageScore}',
                                        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 32),
                                      child: Icon(Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        '${data.favourites}',
                                        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.people,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        '${data.popularity}',
                                        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (data.type == "ANIME")
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.calendar_today,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          'Ep ${data.nextAiringEpisode.second} is airing on ',
                                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    convertSecondsToDate('${data.nextAiringEpisode.first}'),
                                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ExpandablePanel(
                    header: Text(
                      "Synopsis",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    collapsed: Text(
                      data.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                    ),
                    expanded: Text(
                      data.description,
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                    ),
                    theme: ExpandableThemeData(
                      iconColor: Theme.of(context).colorScheme.onBackground,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    "Info",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(30),
                      1: FlexColumnWidth(70),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text(
                            'Romaji',
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          ),
                          Text(
                            data.title.first,
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          ),
                        ],
                      ),
                      if (data.title.second != null)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'English',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                data.title.second != null
                                  ? '${data.title.second}'
                                  : "",
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                          ],
                        ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Native',
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              data.title.third,
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Synonyms',
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              data.synonyms.join('\n'),
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Genres',
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              data.genres.join(', '),
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                        ],
                      ),
                      if (data.episodes != null)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Episodes',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '${data.episodes}',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                          ],
                        ),
                      if (data.duration != null)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child:  Text(
                                'Episode Duration',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                data.duration == 1
                                  ? '1 minute'
                                  : '${data.duration} minutes',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Application error, ${state.runtimeType}'),
            );
          }
        },
      ),
    );
  }
}
