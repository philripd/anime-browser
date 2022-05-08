import 'package:animebrowser/api/models/media_list_model.dart';
import 'package:animebrowser/blocs/media/media_details_cubit.dart';
import 'package:animebrowser/ui/pages/media_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaListItem extends StatelessWidget {
  final SummaryModel data;

  const MediaListItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          BlocProvider.of<MediaDetailsCubit>(context).retrieveDetails(data.id);
          DetailsPage.navigateTo(context);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onBackground,
              width: 2,
            ),
          ),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 6 / 4,
                  child: Image.network(data.mediaURL, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 2),
                  child: Text(
                    data.title.second != null
                      ? '${data.title.second}'
                      : data.title.first,
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (data.title.second != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text('(${data.title.first})',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 12, 24),
                  child: Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withAlpha(235),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
