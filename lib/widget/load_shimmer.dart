import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderShimmer extends StatelessWidget {
  LoaderShimmer({super.key});

  List<int> list = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).canvasColor,
              ),
              height: 80,
              width: 200,
            ),
          ),
        );
      },
    );
  }
}
