import 'package:get_storage/get_storage.dart';

class BellNotificationStorage {
  BellNotificationStorage._privateConstructor();
  static final _box = GetStorage();

  static const _readNotificationsKey = "read_notifications";

  static List<String> getReadNotifications() {
    final list = _box.read(_readNotificationsKey);
    if (list == null) return [];
    return List<String>.from(list);
  }

  static void markAsRead(String id) {
    final readList = getReadNotifications();
    if (!readList.contains(id)) {
      readList.add(id);
      _box.write(_readNotificationsKey, readList);
    }
  }

  static void removeRead(String id) {
    final readList = getReadNotifications();
    readList.remove(id);
    _box.write(_readNotificationsKey, readList);
  }

  static void clearRead() => _box.remove(_readNotificationsKey);

}
