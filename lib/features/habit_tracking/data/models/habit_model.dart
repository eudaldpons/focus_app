import "package:pomodore/core/services/database/collections/habit_collection.dart";

import "../../../../core/resources/params/habit_params.dart";
import "../../../../core/utils/utils.dart";
import "../../domain/entities/habit_entity.dart";

class HabitModel extends HabitEntity {
  const HabitModel({
    required super.overviews,
    required super.title,
    required super.id,
    required super.description,
    required super.iconName,
    required super.uuid,
    required super.color,
    required super.isCompleteToday,
  });

  factory HabitModel.fromJson(Map json) {
    final overviews = json["overviews"] as Map<DateTime, int>;
    final completed =
        overviews.keys.any((element) => Utils.checkDateIsToday(element));

    return HabitModel(
      id: json["habit"]["_id"] ?? 0,
      uuid: json["habit"]["uuid"] ?? 0,
      color: json["habit"]["habitColor"] ?? 0,
      overviews: json["overviews"] ?? {},
      title: json["habit"]["habitTitle"] ?? "",
      description: json["habit"]["habitDescription"] ?? "",
      iconName: json["habit"]["habitIcon"] ?? "",
      isCompleteToday: completed,
    );
  }

  static Map<String, dynamic> toJson(HabitParams item) {
    return {
      "uuid": item.uuid,
      "habitTitle": item.title,
      "habitDescription": item.description,
      "habitIcon": item.icon,
      "habitColor": item.color,
    };
  }

  static HabitModel collectionToModel(HabitCollection collection) {
    Map<DateTime, int> overviewsMap = {};
    collection.overviews?.forEach((element) {
      overviewsMap.addAll({DateTime.parse(element): 1});
    });
    final completed =
        overviewsMap.keys.any((element) => Utils.checkDateIsToday(element));
    return HabitModel(
      overviews: overviewsMap,
      title: collection.habitTitle!,
      id: collection.id,
      description: collection.habitDescription!,
      iconName: collection.habitIcon!,
      uuid: collection.uuid!,
      color: collection.habitColor!,
      isCompleteToday: completed,
    );
  }

  static HabitEntity getEntity(HabitModel item) => HabitEntity(
        overviews: item.overviews,
        title: item.title,
        color: item.color,
        description: item.description,
        iconName: item.iconName,
        id: item.id,
        uuid: item.uuid,
        isCompleteToday: item.isCompleteToday,
      );
}
