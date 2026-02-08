import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.line_axis_outlined, size: 50,),
        Text("Oops! it's empty", style: context.textTheme.headlineMedium,),
        Text("Looks like you don't have anything in your list")
      ],
    ),);
  }
}