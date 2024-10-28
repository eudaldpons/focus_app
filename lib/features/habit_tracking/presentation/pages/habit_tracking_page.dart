import "dart:convert";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_countdown_timer/flutter_countdown_timer.dart";
import "package:intl/intl.dart";
import "package:pomodore/core/constant/constant.dart";

import "package:pomodore/core/shared_widgets/base_app_bar.dart";
import "package:pomodore/core/shared_widgets/global_indicator.dart";
import "package:pomodore/features/habit_tracking/domain/entities/habit_entity.dart";

import "package:pomodore/features/habit_tracking/presentation/pages/add_habit_page.dart";
import "package:pomodore/features/habit_tracking/presentation/shared_widgets/habit_item_widget.dart";

import "../../../../di.dart";
import "../../../../exports.dart";
import "../blocs/habit_tracker_bloc/habit_tracker_bloc.dart";

class HabitTrackingPage extends StatelessWidget {
  const HabitTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<HabitTrackerBloc>()..add(AllHabitsFetched()),
      child: const HabitTrackingView(),
    );
  }
}

class HabitTrackingView extends StatefulWidget {
  const HabitTrackingView({super.key});

  @override
  State<HabitTrackingView> createState() => _HabitTrackingViewState();
}

class _HabitTrackingViewState extends State<HabitTrackingView> {
  List<HabitEntity> habits = [];
    Map<String, String>? quotes;

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }
  Future<void> loadQuotes() async {
    final String response = await rootBundle.loadString("assets/quotes.json");
    final Map<String, dynamic> data = json.decode(response);
    setState(() {
      quotes = data.map((key, value) => MapEntry(key, value.toString()));
    });
  }
  String getQuoteForToday() {
    //TODO: ADD LOCALIZATION
    if (quotes == null) {
      return "Today is the only day. Yesterday is gone.";
    }
    final String formattedDate = DateFormat("ddMMyyyy").format(DateTime.now());
    return quotes![formattedDate] ?? "Today is the only day. Yesterday is gone.";
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
        // Calculate the end time for the countdown (June 21st, 12:00 AM)
    DateTime now = DateTime.now();
    DateTime summerStart = DateTime(now.year, 6, 21);
    if (now.isAfter(summerStart)) {
      summerStart = DateTime(now.year + 1, 6, 21);
    }
    int endTime = summerStart.millisecondsSinceEpoch;

    return Scaffold(
      appBar: BaseAppBar(
        title: localization.habitTrackingTitle,
      ),
      body: Column(
        children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: CountdownTimer(
            endTime: endTime,
            widgetBuilder: (_, time) {
              if (time != null) {
              return Text(
                "${time.days ?? 0}d ${time.hours ?? 0}h ${time.min ?? 0}m ${time.sec ?? 0}s",
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              );
              }
              return SizedBox();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 35),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: BorderRadius.circular(AppConstant.radius),
              
            ),
            child: Text(
              textAlign: TextAlign.center,
              getQuoteForToday(),
              style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8.0, right: 22.0, left: 22),
          child: Row( 
            children: [
              Text(
                    'Today, ${DateFormat("MMM d'th'").format(DateTime.now())}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(), 
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddHabitPage.routeName).then(
                (value) => context.read<HabitTrackerBloc>().add(
                      AllHabitsFetched(),
                    ),
              );
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
            ],
          ),
        ),
          BlocConsumer(
            bloc: context.read<HabitTrackerBloc>(),
            listener: (context, state) {
              if (state is DeleteHabit && !state.loading && !state.error) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is FetchHabits) {
                if (state.loading) {
                  return const Center(
                    child: GlobalIndicator(),
                  );
                }
                if (state.habits.isEmpty) {
                  return Center(
                    child: Text(localization.noHabitMessage),
                  );
                }
                if (!state.loading && !state.error && state.habits.isNotEmpty) {
                  habits = state.habits;
                }
              }
          
              if (state is DeleteHabit && !state.error && !state.loading) {
                habits = state.habits;
              }
          
              if (state is DoneHabit && !state.error && !state.loading) {
                habits = state.habits;
              }
          
              if (state is EditHabit && !state.error && !state.loading) {
                habits = state.habits;
              }
          
              return Expanded(
                child: ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) => ListTile(
                    title: HabitItemWidget(
                      item: habits[index],
                      habits: habits,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
