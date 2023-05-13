import 'package:flutter/material.dart';

import '../../../core/ui/helpers/assets.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import '../payment_type_controller.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel payment;
  const PaymentTypeItem({
    super.key,
    required this.payment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final enabledColor = payment.enabled ? Colors.black : Colors.grey;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/icons/payment_${payment.acronym.toLowerCase()}_icon.png',
                  color: enabledColor,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Assets.assets_images_icons_payment_notfound_icon_png,
                      color: enabledColor,
                    );
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formas de Pagamento',
                        style: context.textStyles.textRegular
                            .copyWith(color: enabledColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        payment.name.trim(),
                        style: context.textStyles.textTitle
                            .copyWith(color: enabledColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.editPayment(payment);
                  },
                  child: Text(
                    'Editar',
                    style: context.textStyles.textMedium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
