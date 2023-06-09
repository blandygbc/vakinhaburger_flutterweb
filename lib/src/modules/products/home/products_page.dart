import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/helpers/debouncer.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/widgets/base_header.dart';
import 'products_controller.dart';
import 'widgets/product_item.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages {
  final controller = Modular.get<ProductsController>();
  late final ReactionDisposer statusDisposer;
  final debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch (status) {
          case ProductStateStatus.initial:
            break;
          case ProductStateStatus.loading:
            showLoader();
            break;
          case ProductStateStatus.loaded:
            hideLoader();
            break;
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao buscar produtos');
            break;
          case ProductStateStatus.addOrUpdateProduct:
            hideLoader();
            final productSelected = controller.productSelected;
            var uri = '/products/detail/';

            if (productSelected != null) {
              uri += '?id=${productSelected.id}';
            }

            await Modular.to.pushNamed(uri);
            controller.loadProducts();
            break;
        }
      });
      controller.loadProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseHeader(
          title: 'ADMINISTRAR PRODUTOS',
          buttonLabel: 'ADICIONAR',
          buttonPressed: controller.addProduct,
          searchChange: (value) {
            debouncer.call(() {
              controller.filterByName(value);
            });
          },
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    maxCrossAxisExtent: 280,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ProductItem(product: product);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
