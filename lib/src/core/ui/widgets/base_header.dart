import 'package:flutter/material.dart';

import '../helpers/size_extensions.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? searchChange;
  final String buttonLabel;
  final VoidCallback? buttonPressed;
  final bool addButton;
  final Widget? filterWidget;

  const BaseHeader({
    super.key,
    required this.title,
    this.searchChange,
    this.buttonLabel = '',
    this.buttonPressed,
    this.addButton = true,
    this.filterWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) {
        return Wrap(
          children: [
            Visibility(
              visible: filterWidget == null,
              replacement: filterWidget ?? const SizedBox.shrink(),
              child: SizedBox(
                width: constrains.maxWidth * .15,
                child: TextFormField(
                  onChanged: searchChange,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search,
                      size: _getIconSize(constrains.maxWidth),
                    ),
                    label: Text(
                      'Buscar',
                      style: context.textStyles.regular.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: constrains.maxWidth * .65,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: context.textStyles.title,
                  ),
                  Container(
                    width: title.length.toDouble() * 15,
                    height: 8,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: addButton,
              child: Visibility(
                visible: constrains.maxWidth > 950,
                replacement: Tooltip(
                  message: buttonLabel,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.colors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: buttonPressed,
                      icon: Icon(
                        Icons.add,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: constrains.maxWidth * .15,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: buttonPressed,
                    icon: Icon(
                      Icons.add,
                      size: _getIconSize(constrains.maxWidth),
                    ),
                    label: Text(buttonLabel),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _getIconSize(double maxWidth) {
    if (maxWidth < 600) {
      return maxWidth * 0.04;
    } else if (maxWidth < 800) {
      return maxWidth * 0.03;
    } else if (maxWidth < 1000) {
      return maxWidth * 0.025;
    }
    return maxWidth * 0.02;
  }
}
