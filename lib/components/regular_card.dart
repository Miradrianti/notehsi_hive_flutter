import 'package:flutter/material.dart';

class RegularCard extends StatelessWidget {
  
  const RegularCard({
    super.key, 
    this.children = const []
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}