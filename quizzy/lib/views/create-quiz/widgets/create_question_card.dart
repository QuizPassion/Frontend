import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/core/app_fonts.dart';

class QuestionData {
  String question;
  List<OptionData> options;

  QuestionData({
    required this.question,
    required this.options,
  });
}

class OptionData {
  bool isCorrect;
  String text;

  OptionData({
    required this.isCorrect,
    required this.text,
  });
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
  late TextEditingController _questionController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.data.question);
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void _addOption() {
    setState(() {
      widget.data.options.add(OptionData(isCorrect: false, text: ''));
    });
  }

  void _removeOption(int index) {
    setState(() {
      widget.data.options.removeAt(index);
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
            controller: _questionController,
            onChanged: (value) {
              widget.data.question = value;
            },
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
            'Options',
            style: TextStyle(
              color: AppColors.lightGrey,
              fontFamily: AppFonts.lato,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),

          // Liste des options
          ...widget.data.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return _OptionRow(
              data: option,
              onDelete: () => _removeOption(index),
            );
          }),

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

          // Actions : copier / supprimer
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
  final VoidCallback onDelete;

  const _OptionRow({
    required this.data,
    required this.onDelete,
  });

  @override
  State<_OptionRow> createState() => _OptionRowState();
}

class _OptionRowState extends State<_OptionRow> {
  late TextEditingController _optionController;

  @override
  void initState() {
    super.initState();
    _optionController = TextEditingController(text: widget.data.text);
  }

  @override
  void dispose() {
    _optionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.data.isCorrect,
          onChanged: (val) =>
              setState(() => widget.data.isCorrect = val ?? false),
          side: const BorderSide(color: AppColors.lightGrey, width: 1),
          checkColor: AppColors.anthraciteBlack,
          activeColor: AppColors.lightGrey,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _optionController,
            onChanged: (value) {
              widget.data.text = value;
            },
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
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.deepLavender),
          onPressed: widget.onDelete,
        )
      ],
    );
  }
}
