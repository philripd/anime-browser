import 'package:animebrowser/api/models/media_details_model.dart';
import 'package:animebrowser/blocs/media/media_details_cubit.dart';
import 'package:animebrowser/blocs/media/media_details_state.dart';
import 'package:animebrowser/blocs/status_enum.dart';
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
      appBar: AppBar(title: const Text('Details')),
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
              padding: const EdgeInsets.only(bottom: 16.0),
              children: [
                Image.network(
                  data.mediaURL,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                  child: Text(
                    data.title.second != null
                      ? '${data.title.second}'
                      : data.title.first,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    data.title.second != null
                      ? '(${data.title.first})'
                      : "",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${data.format}',
                        style: TextStyle(
                          color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withAlpha(235),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          data.genres.join(', '),
                          style: TextStyle(
                            color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withAlpha(235),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (data.episodes != null)
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: Text(
                      data.episodes == 1
                        ? '1 episode'
                        : '${data.episodes} episodes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                if (data.duration != null)
                  ListTile(
                    leading: const Icon(Icons.timelapse),
                    title: Text(
                      data.duration == 1
                        ? '1 minute'
                        : '${data.duration} minutes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    data.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
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
