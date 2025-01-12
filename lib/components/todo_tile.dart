import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskChanged;
  final Function(bool?)? onChanged;
  final Function(BuildContext) editFunction;
  final Function(BuildContext) delFunction;
  const TodoTile(
      {super.key,
      required this.taskName,
      required this.taskChanged,
      required this.onChanged,
      required this.editFunction,
      required this.delFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: delFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
        ]),
        child: GestureDetector(
          onTap: () => editFunction(context),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Checkbox(
                  value: taskChanged,
                  onChanged: onChanged,
                  activeColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                        decoration: taskChanged
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
