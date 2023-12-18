import 'package:diletta_flutter_test/data/repository/firebase_repository.dart';
import 'package:diletta_flutter_test/data/repository/product_repository.dart';
import 'package:diletta_flutter_test/domain/core/local_storage_wishlist.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  setup() async {
    await LocalStorageWishlist.setup();
    _setupRepositories();
  }

  void _setupRepositories() {
    Firebase.initializeApp();

    GetIt.I.registerSingleton<FirebaseRepository>(FirebaseRepository());
    GetIt.I.registerSingleton<ProductRepository>(ProductRepository());
  }
}
