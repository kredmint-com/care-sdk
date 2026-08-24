import 'package:get_storage/get_storage.dart';

import '../../app/data/models/dto/user_model.dart';

class Storage {
  Storage._privateConstructor();

  static final String boxName = "loan-sdk-storage-box";

  static final _box = GetStorage(boxName);

  static void setSdkUser(SdkUserModel? user) =>
      _box.write(StorageKeys.sdkUserModel, user?.toJson());

  static SdkUserModel? getSdkUser() =>
      _box.read(StorageKeys.sdkUserModel) == null
          ? null
          : SdkUserModel.fromJson(_box.read(StorageKeys.sdkUserModel));

  static void clearStorage() => _box.erase();
}

class StorageKeys {
  StorageKeys._privateConstructor();

  static const String sdkUserModel = "sdkUserModel";
}
