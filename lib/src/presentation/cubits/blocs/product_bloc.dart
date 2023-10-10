import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shample_app/src/domain/repositories/products_repository.dart';
import 'package:shample_app/src/presentation/cubits/events/produc_events.dart';
import 'package:shample_app/src/presentation/cubits/states/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final _productRepository = ProductsRepository();

  ProductBloc() : super(ProductInitialState()) {
    on<LoadProductEvent>((event, emit) async {
      try {
        final products = await _productRepository.getProducts();
        emit(ProductSuccessState(products: products));
      } catch (e) {
        // emit();
      }
    });
  }
}
