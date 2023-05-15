import 'package:flutter/material.dart';

import '../../../../core/dto/order/order_product_dto.dart';
import '../../../../core/extensions/formatter_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';

class OrderProductItem extends StatelessWidget {
  final OrderProductDto orderProduct;

  const OrderProductItem({super.key, required this.orderProduct});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              orderProduct.product.name,
              style: textStyles.regular,
            ),
          ),
          Text(
            '${orderProduct.amount}',
            style: textStyles.medium,
          ),
          Expanded(
            child: Text(
              orderProduct.totalPrice.toCurrencyPTBR,
              textAlign: TextAlign.end,
              style: textStyles.medium,
            ),
          ),
        ],
      ),
    );
  }
}
