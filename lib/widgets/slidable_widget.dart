import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  final SlidableActionCallback? ontapped;
  final Widget child;
  const SlidableWidget({required this.child, this.ontapped, super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(10)),
          onPressed: ontapped,

          // onPressed: (context) =>
          //     _deleteExpense(context, expense),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: true,
        children: [
          SlidableAction(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(10)),
            onPressed: ontapped,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: child,
    );
  }
}
