import 'package:flutter/material.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
        ),
      ),
      child: const Text('BODY'),
    );
  }
}
