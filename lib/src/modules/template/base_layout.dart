import 'package:flutter/material.dart';

import '../../core/ui/helpers/assets.dart';
import '../../core/ui/helpers/size_extensions.dart';
import 'menu/menu_bar.dart' as menu;

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final shortestSide = context.screenShortestSide;
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              constraints: BoxConstraints(
                minWidth: screenWidth,
                minHeight: shortestSide * .15,
                maxHeight: shortestSide * .15,
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: shortestSide * .13,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset(
                  Assets.assets_images_logo_png,
                ),
              ),
            ),
            Positioned.fill(
              top: shortestSide * .13,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
