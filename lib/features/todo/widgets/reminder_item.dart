import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techigh_todo/constants/gaps.dart';
import 'package:techigh_todo/constants/sizes.dart';
import 'package:techigh_todo/constants/tech_colors.dart';
import 'package:techigh_todo/features/todo/constants/Strings.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techigh_todo/features/todo/models/reminder_model.dart';
import 'package:techigh_todo/features/todo/view_models/reminders_vm.dart';

class ReminderItemWidget extends ConsumerStatefulWidget {
  final int index;
  final ListModel list;
  final ReminderModel? reminder;
  final bool isAdding;
  final bool isFocused;
  final Function onTap;
  const ReminderItemWidget({
    Key? key,
    required this.index,
    required this.list,
    this.reminder,
    required this.isAdding,
    required this.isFocused,
    required this.onTap,
  }) : super(key: key);

  @override
  ConsumerState<ReminderItemWidget> createState() => _ReminderItemWidgetState();
}

class _ReminderItemWidgetState extends ConsumerState<ReminderItemWidget> {
  bool isChecked = false;
  late TextEditingController _titleTextController;
  late TextEditingController _noteTextController;

//-------------------------------------------------------------------------------------
  void _onTitleTap() {
    if (widget.reminder != null) {
      _titleTextController.text = widget.reminder!.title;
    }
  }

//-------------------------------------------------------------------------------------
  void _onTitleSubmitted(String value) {
    ref
        .read(remindersProvider(widget.list.id).notifier)
        .addReminder(widget.list.id, value);
  }

//-------------------------------------------------------------------------------------
  void _onCompleteTap(bool value) {
    if (widget.reminder != null) {
      ref
          .read(remindersProvider(widget.list.id).notifier)
          .updateCompleteReminder(widget.list.id, widget.reminder!.uid, value);
    } else {
      return;
    }
  }

  //-------------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController();
    _noteTextController = TextEditingController();
  }

//-------------------------------------------------------------------------------------
  @override
  void dispose() {
    _titleTextController.dispose();
    _noteTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.reminder != null
                      ? widget.reminder!.completed
                          ? TechColors.allColors[widget.list.color]!
                          : Colors.grey.shade700
                      : Colors.grey.shade700,
                ),
              ),
              child: Transform.scale(
                scale: 0.8,
                child: Checkbox(
                  checkColor: Colors.transparent,
                  // activeColor: Colors.red,
                  // shape: const CircleBorder(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // side: BorderSide.none,
                  ),
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                  /// fillColor가 activeColor보다 우선
                  /// 만약 fillColor가 지정되어 있다면, 체크박스의 배경 색상은 fillColor에 정의된 색상으로 설정
                  /// fillColor은 체크박스의 선택 여부와 관계없이 상태에 따라 다른 색상을 지정
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      // return Colors.transparent;
                      if (states.contains(MaterialState.selected)) {
                        return TechColors.allColors[widget.list.color];
                      } else {
                        return Colors.transparent;
                      }
                    },
                  ),
                  value: widget.reminder != null
                      ? widget.reminder!.completed
                      : isChecked,
                  onChanged: (bool? value) {
                    if (value != null) {
                      _onCompleteTap(value);
                    }
                  },
                ),
              ),
            ),
            Gaps.h20,
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap(widget.index);
                    _onTitleTap();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.isAdding || widget.isFocused
                                ? CupertinoTextField(
                                    controller: _titleTextController,
                                    onSubmitted: _onTitleSubmitted,
                                    //
                                    placeholder: 'New Reminder',
                                    placeholderStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant,
                                      fontFamily: Strings.fontFamily,
                                    ),
                                    //
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: Strings.fontFamily,
                                    ),
                                    decoration: const BoxDecoration(),
                                    padding: EdgeInsets.zero,
                                    //
                                    suffix: const Icon(
                                      CupertinoIcons.info,
                                    ),
                                  )
                                : Text(
                                    widget.reminder!.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            if (widget.isAdding || widget.isFocused)
                              CupertinoTextField(
                                controller: _noteTextController,
                                //
                                placeholder: 'Add Note',
                                placeholderStyle: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                  fontFamily: Strings.fontFamily,
                                ),
                                //
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: Strings.fontFamily,
                                ),
                                //
                                decoration: const BoxDecoration(),
                                padding: const EdgeInsets.only(
                                  top: Sizes.size8,
                                ),
                              ),
                            if (!widget.isAdding &&
                                widget.reminder!.note != null)
                              Text(
                                widget.reminder!.note ?? 'Add Note',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: widget.reminder!.note == null
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
