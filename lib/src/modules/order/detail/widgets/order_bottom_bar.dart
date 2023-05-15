import 'package:flutter/material.dart';

import '../../../../core/ui/helpers/assets.dart';
import '../../../../core/ui/styles/text_styles.dart';

class OrderBottomBar extends StatelessWidget {
  const OrderBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        OrderBottomBarButton(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Colors.blue,
          image: Assets.assets_images_icons_finish_order_white_ico_png,
          buttonLabel: 'Finalizar',
        ),
        OrderBottomBarButton(
          borderRadius: BorderRadius.zero,
          color: Colors.green,
          image: Assets.assets_images_icons_confirm_order_white_icon_png,
          buttonLabel: 'Confirmar',
        ),
        OrderBottomBarButton(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.red,
          image: Assets.assets_images_icons_cancel_order_white_icon_png,
          buttonLabel: 'Cancelar',
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
  const OrderBottomBarButton({
    super.key,
    required this.borderRadius,
    required this.color,
    required this.image,
    required this.buttonLabel,
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
            side: BorderSide(color: color),
            backgroundColor: color,
          ),
          onPressed: () {},
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
