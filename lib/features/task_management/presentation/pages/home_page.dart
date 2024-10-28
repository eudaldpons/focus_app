import "package:flutter/material.dart";
import "package:ionicons/ionicons.dart";
import "package:pomodore/core/shared_widgets/base_app_bar.dart";

import "../../../../exports.dart";
import "../../../notification_management/presentation/pages/notifications_page.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: BaseAppBar(
        title: localization.homeTitle,
        action: const Icon(Ionicons.notifications),
        onPressed: () =>
            Navigator.pushNamed(context, NotificationsPage.routeName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Social Feed')
      ),
    );
  }
}
