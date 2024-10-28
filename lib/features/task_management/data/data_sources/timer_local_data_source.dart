import "package:pomodore/core/services/database/collections/task_collection.dart";
import "package:pomodore/core/services/database/isar_helper.dart";
import "package:pomodore/core/utils/debug_print.dart";
import "package:pomodore/features/task_management/data/models/task_model.dart";


class TimerLocalDataSource {
  final IsarHelper db;

  TimerLocalDataSource(this.db);

  Future<TaskModel?> getTaskByUid(String? id) async {
    try {
      if (id == null) return null;
      TaskCollection? collection = await db.getTaskByUId(id);
      if (collection == null) return null;
      return TaskModel.collectionToModel(collection);
    } catch (e) {
      dPrint(e.toString());
      rethrow;
    }
  }
}
