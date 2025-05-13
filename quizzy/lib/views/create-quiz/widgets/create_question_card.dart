import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/core/app_fonts.dart';

class QuestionData {
  TextEditingController titleController;
  List<OptionData> options;

  QuestionData({
    TextEditingController? titleController,
    List<OptionData>? options,
  })  : titleController = titleController ?? TextEditingController(),
        options = options ?? [OptionData(), OptionData()];

  QuestionData.clone(QuestionData original)
      : titleController =
            TextEditingController(text: original.titleController.text),
        options = original.options.map((o) => OptionData.clone(o)).toList();
}


class OptionData {
  bool isCorrect;  // Utilisation de isCorrect à la place de check1 et check2
  TextEditingController textController;

  OptionData({
    this.isCorrect = false,  // initialisé à false
    String text = '',
  }) : textController = TextEditingController(text: text);

  OptionData.clone(OptionData original)
      : isCorrect = original.isCorrect,
        textController =
            TextEditingController(text: original.textController.text);
}


class CreateQuestionCard extends StatefulWidget {
  final QuestionData data;
  final VoidCallback onCopy;
  final VoidCallback onDelete;

  const CreateQuestionCard({
    super.key,
    required this.data,
    required this.onCopy,
    required this.onDelete,
  });

  @override
  State<CreateQuestionCard> createState() => _CreateQuestionCardState();
}

class _CreateQuestionCardState extends State<CreateQuestionCard> {
  void _addOption() {
    setState(() {
      widget.data.options.add(OptionData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.deepLavender,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.data.titleController,
            style: const TextStyle(
              color: AppColors.lightGrey,
              fontFamily: AppFonts.lato,
            ),
            decoration: const InputDecoration(
              hintText: 'Question title',
              hintStyle: TextStyle(
                color: AppColors.lightGrey,
                fontFamily: AppFonts.lato,
                fontSize: 18,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.deepLavender, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.royalPurple, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'True/False',
            style: TextStyle(
              color: AppColors.lightGrey,
              fontFamily: AppFonts.lato,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          ...widget.data.options.map((option) => _OptionRow(data: option)),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: _addOption,
            child: const Text(
              'Add an option',
              style: TextStyle(
                color: AppColors.lightGrey,
                fontFamily: AppFonts.lato,
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // copy and delete
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ← REPLACE THIS IconButton
                GestureDetector(
                  onTap: widget.onCopy,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.deepLavender),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.copy,
                      color: AppColors.lightGrey,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // ← AND THIS IconButton
                GestureDetector(
                  onTap: widget.onDelete,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.deepLavender),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColors.lightGrey,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionRow extends StatefulWidget {
  final OptionData data;

  const _OptionRow({required this.data});

  @override
  State<_OptionRow> createState() => _OptionRowState();
}

class _OptionRowState extends State<_OptionRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.data.isCorrect,  // Utilisation de isCorrect
          onChanged: (val) => setState(() => widget.data.isCorrect = val ?? false),
          side: const BorderSide(color: AppColors.lightGrey, width: 1),
          checkColor: AppColors.anthraciteBlack,
          activeColor: AppColors.lightGrey,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: widget.data.textController,
            style: const TextStyle(
              color: AppColors.lightGrey,
              fontFamily: AppFonts.lato,
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              hintText: 'Réponse',
              hintStyle: TextStyle(
                color: AppColors.lightGrey,
                fontStyle: FontStyle.italic,
                fontFamily: AppFonts.lato,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
