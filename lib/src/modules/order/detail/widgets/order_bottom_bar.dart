import 'package:flutter/material.dart';

import '../../../../core/dto/order/order_dto.dart';
import '../../../../core/ui/helpers/assets.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/orders/order_status.dart';
import '../../order_controller.dart';

class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;

  const OrderBottomBar({
    super.key,
    required this.controller,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderBottomBarButton(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Colors.blue,
          image: Assets.assets_images_icons_finish_order_white_ico_png,
          buttonLabel: 'Finalizar',
          onPressed: order.status == OrderStatus.confirmado
              ? () {
                  controller.changeStatus(OrderStatus.finalizado);
                }
              : null,
        ),
        OrderBottomBarButton(
          borderRadius: BorderRadius.zero,
          color: Colors.green,
          image: Assets.assets_images_icons_confirm_order_white_icon_png,
          buttonLabel: 'Confirmar',
          onPressed: order.status == OrderStatus.pendente
              ? () {
                  controller.changeStatus(OrderStatus.confirmado);
                }
              : null,
        ),
        OrderBottomBarButton(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.red,
          image: Assets.assets_images_icons_cancel_order_white_icon_png,
          buttonLabel: 'Cancelar',
          onPressed: order.status != OrderStatus.cancelado &&
                  order.status != OrderStatus.finalizado
              ? () {
                  controller.changeStatus(OrderStatus.cancelado);
                }
              : null,
        ),
      ],
    );
  }
}

class OrderBottomBarButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color color;
  final String image;
  final String buttonLabel;
  final VoidCallback? onPressed;
  const OrderBottomBarButton({
    super.key,
    required this.borderRadius,
    required this.color,
    required this.image,
    required this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              const SizedBox(width: 10),
              Text(
                buttonLabel,
                style: context.textStyles.bold.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
