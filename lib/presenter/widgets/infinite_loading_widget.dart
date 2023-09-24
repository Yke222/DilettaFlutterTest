import 'package:flutter/material.dart';

class InfiniteLoadingWidget extends StatelessWidget {
  const InfiniteLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Center(
          child: SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
