import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diletta_store/layers/presentation/controllers/auth_controller.dart';
import 'package:diletta_store/layers/presentation/controllers/products_controller.dart';
import 'package:diletta_store/layers/presentation/pages/sign_in_page.dart';
import 'package:diletta_store/layers/presentation/utils/show_error_snackbar.dart';
import 'package:diletta_store/layers/presentation/widgets/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({Key? key}) : super(key: key);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  final _productsController = GetIt.I.get<ProductsController>();
  final _authController = GetIt.I.get<AuthController>();
  late final ReactionDisposer errorReactionDisposer;

  @override
  void initState() {
    super.initState();
    _authController.getUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    errorReactionDisposer = reaction(
      (_) => _authController.errorMessage,
      (errorMessage) {
        if (errorMessage != null) {
          showErrorSnackBar(context, errorMessage);
          _authController.setErrorMessage(null);
        }
      },
    );
  }

  @override
  void dispose() {
    errorReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Image.asset("assets/images/diletta_logo.png"),
      ),
      leadingWidth: 80,
      elevation: 0,
      titleSpacing: 0,
      title: Observer(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              right: 5,
              left: 15,
              bottom: 5,
              top: 5,
            ),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: _productsController.searchTerm != null
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _productsController.searchTerm ?? "",
                    textScaleFactor: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // To search the user input;
                    if (_productsController.searchTerm == null) {
                      _productsController.setSearchTerm(
                        await showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        ),
                      );
                    }
                    // To remove search status;
                    else {
                      _productsController.setSearchTerm("");
                    }
                  },
                  child: _productsController.searchTerm != null
                      ? const Icon(Icons.close)
                      : const Icon(Icons.search),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        Observer(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  if (_authController.isUserLoggedIn) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      headerAnimationLoop: false,
                      btnCancelColor: Colors.transparent,
                      btnOkColor: Colors.red,
                      title: 'Sair de Sua Conta',
                      desc: 'Quer realmente sair de sua conta?\n${_authController.getUser()!.email}',
                      btnCancelOnPress: () {},
                      btnCancelText: "Cancelar",
                      btnOkOnPress: () async {
                        await _authController.signOut();
                        _productsController.getProducts(load: true);
                      },
                      btnOkText: "Sair",
                    ).show();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  }
                },
                icon: _authController.isUserLoggedIn
                    ? CircleAvatar(
                        child: Text(
                          _authController.getUser()!.email[0].toUpperCase(),
                          textScaleFactor: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                    : const Icon(Icons.person),
              ),
            );
          },
        ),
      ],
    );
  }
}
