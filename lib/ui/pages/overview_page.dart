import 'package:animebrowser/blocs/status_enum.dart';
import 'package:animebrowser/blocs/summary/summary_bloc.dart';
import 'package:animebrowser/blocs/summary/summary_event.dart';
import 'package:animebrowser/blocs/summary/summary_state.dart';
import 'package:animebrowser/ui/widgets/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  static const BottomNavigationBarItem navItem = BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Overview',
  );

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<SummaryBloc, SummaryState>(
          builder: (BuildContext context, SummaryState state) {
            if (state.status == StatusEnum.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == StatusEnum.failed) {
              return Center(child: Text(state.errorMessage ?? 'Unknown'));
            } else if (state.status == StatusEnum.successful) {
              return RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<SummaryBloc>(context)
                      .add(const RetrieveSummaryEvent(1, 50));
                  return Future.delayed(const Duration(milliseconds: 150));
                },
                child: ListView.separated(
                  itemCount: state.data.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (_, int index) => SummaryWidget(
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
        ),
      ),
    );
  }
}
