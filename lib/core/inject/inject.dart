import 'package:diletta_store/layers/data/datasources/local/wishlist_datasource/wishlist_datasouce_imp.dart';
import 'package:diletta_store/layers/data/datasources/local/wishlist_datasource/wishlist_datasource.dart';
import 'package:diletta_store/layers/data/datasources/remote/auth_datasource/auth_datasource.dart';
import 'package:diletta_store/layers/data/datasources/remote/auth_datasource/auth_datasource_imp.dart';
import 'package:diletta_store/layers/data/datasources/remote/products_datasource/products_datasource.dart';
import 'package:diletta_store/layers/data/datasources/remote/products_datasource/products_datasource_imp.dart';
import 'package:diletta_store/layers/data/repositories/auth_repository_imp.dart';
import 'package:diletta_store/layers/data/repositories/products_repository_imp.dart';
import 'package:diletta_store/layers/domain/repositories/auth_repository.dart';
import 'package:diletta_store/layers/domain/repositories/products_repository.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/get_user_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_alphabetical_order_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_price_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_sale_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_wishlist_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_products_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/search_term_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/toggle_product_favorite_status_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/get_all_products_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/sign_in_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:diletta_store/layers/presentation/controllers/auth_controller.dart';
import 'package:diletta_store/layers/presentation/controllers/products_controller.dart';
import 'package:get_it/get_it.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    // DataSources
    getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImp(),
    );
    getIt.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSourceImp(),
    );
    getIt.registerLazySingleton<WishlistDataSource>(
      () => WishlistDataSourceImp(),
    );

    // Repositories
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(
        authDataSource: getIt<AuthDataSource>(),
      ),
    );
    getIt.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImp(
        wishlistDataSource: getIt<WishlistDataSource>(),
        productsDataSource: getIt<ProductsDataSource>(),
      ),
    );

    // UseCases
    getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(
        getIt<AuthRepository>(),
        getIt<ProductsRepository>(),
      ),
    );
    getIt.registerLazySingleton<GetAllProductsUseCase>(
      () => GetAllProductsUseCase(getIt<ProductsRepository>()),
    );
    getIt.registerLazySingleton<ToggleProductFavoriteStatusUseCase>(
      () => ToggleProductFavoriteStatusUseCase(getIt<ProductsRepository>()),
    );
    getIt.registerLazySingleton<SearchTermUseCase>(
      () => SearchTermUseCase(),
    );
    getIt.registerLazySingleton<FilterBySaleUseCase>(
      () => FilterBySaleUseCase(),
    );
    getIt.registerLazySingleton<FilterByWishlistUseCase>(
      () => FilterByWishlistUseCase(),
    );
    getIt.registerLazySingleton<FilterByPriceUseCase>(
      () => FilterByPriceUseCase(),
    );
    getIt.registerLazySingleton<FilterByAlphabeticalOrderUseCase>(
      () => FilterByAlphabeticalOrderUseCase(),
    );
    getIt.registerLazySingleton<FilterProductsUseCase>(
      () => FilterProductsUseCase(
        filterBySaleUseCase: getIt<FilterBySaleUseCase>(),
        filterByWishlistUseCase: getIt<FilterByWishlistUseCase>(),
        filterByPriceUseCase: getIt<FilterByPriceUseCase>(),
        filterByAlphabeticalOrderUseCase: getIt<FilterByAlphabeticalOrderUseCase>(),
      ),
    );

    // Controllers
    getIt.registerLazySingleton<AuthController>(
      () => AuthController(
        signInUseCase: getIt<SignInUseCase>(),
        signUpUseCase: getIt<SignUpUseCase>(),
        signOutUseCase: getIt<SignOutUseCase>(),
        getUserUseCase: getIt<GetUserUseCase>(),
      ),
    );
    getIt.registerLazySingleton<ProductsController>(
      () => ProductsController(
        getAllProductsUseCase: getIt<GetAllProductsUseCase>(),
        toggleProductFavoriteStatus:
            getIt<ToggleProductFavoriteStatusUseCase>(),
        searchTermUseCase: getIt<SearchTermUseCase>(),
        filterProductsUseCase: getIt<FilterProductsUseCase>(),
      ),
    );
  }
}
