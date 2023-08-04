import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/img/empty_state.svg',
          width: 200,
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Your Task List is Empty',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
