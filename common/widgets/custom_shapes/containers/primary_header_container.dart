import 'package:flutter/cupertino.dart';
import '../../../../utils/constants/colors.dart';
import 'circular_container.dart';
import 'curved_edges/curved_edge_widget.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
        child: Container(
          color: TColors.primary,

        child: Stack(
          children: [
          Positioned(top: -150, right: -250, child: TCircularContainer(backGroundColor: TColors.textWhite.withOpacity(0.1))),
          Positioned(top: 100, right: -300, child: TCircularContainer(backGroundColor: TColors.textWhite.withOpacity(0.1))),
          child,  // Ensure the child is included here
          ],
                ),
              ),
    );
  }
}

