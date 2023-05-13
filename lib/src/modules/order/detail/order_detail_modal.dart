import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import 'widgets/order_info_tile.dart';
import 'widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  const OrderDetailModal({super.key});

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: screenWidth * (screenWidth > 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhe do Pedido',
                        textAlign: TextAlign.center,
                        style: context.textStyles.title,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: _closeModal,
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Nome do Cliente: ',
                      style:
                          context.textStyles.extraBold.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Gabriel Blandy',
                      style: context.textStyles.medium.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const Divider(),
                ...List.generate(3, (index) => index)
                    .map((e) => const OrderProductItem())
                    .toList(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do Pedido',
                        style: context.textStyles.extraBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        300.0.toCurrencyPTBR,
                        style: context.textStyles.extraBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const OrderInfoTile(
                  label: 'Endereço de entrega : ',
                  info: 'Av. Paulista, 300',
                ),
                const Divider(),
                const OrderInfoTile(
                  label: 'Forma de Pagamento: ',
                  info: 'Cartão de Crédito',
                ),
                const Divider(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}