import 'package:animebrowser/api/models/details_model.dart';
import 'package:animebrowser/blocs/details/details_cubit.dart';
import 'package:animebrowser/blocs/details/details_state.dart';
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
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
          if (state.status == StatusEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == StatusEnum.failed) {
            return Center(child: Text(state.errorMessage ?? 'Unknown'));
          } else if (state.status == StatusEnum.successful &&
              state.data != null) {
            final data = state.data as DetailsModel;
            return ListView(
              padding: const EdgeInsets.only(bottom: 16.0),
              children: [
                Image.network(
                  data.mediaURL,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    data.title.second != null
                        ? '${data.title.first} (${data.title.second})'
                        : data.title.first,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${data.type}, ${data.format} | ${data.genres.join(', ')}',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withAlpha(235),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (data.duration != null)
                  ListTile(
                    leading: const Icon(Icons.timelapse),
                    title: Text(
                      '${data.duration} minutes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                if (data.episodes != null)
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: Text(
                      '${data.episodes} episodes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
