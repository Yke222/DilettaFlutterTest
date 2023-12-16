import 'package:diletta_flutter_test/core/local_storage_wishlist.dart';
import 'package:diletta_flutter_test/repository/firebase_repository.dart';
import 'package:diletta_flutter_test/repository/product_repository.dart';
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
