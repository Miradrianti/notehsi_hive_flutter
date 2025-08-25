import 'package:flutter/material.dart';

class TagInputField extends StatefulWidget {
  final bool enabled;
  final List<String> initialTags;
  final Function(List<String>)? onChanged;

  const TagInputField({
    super.key,
    this.initialTags = const [],
    this.enabled = true,
    this.onChanged,
  });

  @override
  State<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  void _addTag(String tag) {
    setState(() {
      _tags.add(tag);
    });
    widget.onChanged?.call(_tags);
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onChanged?.call(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final tag in _tags)
          TextButton(
            onPressed: widget.enabled ? () => _removeTag(tag) : null,
            child: Text(tag),
          ),
        if (widget.enabled)
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Color.fromRGBO(57, 70, 117, 1),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              side: BorderSide(
                color: Color.fromRGBO(57, 70, 117, 1),
                width: 1,
              )
            ),
            onPressed: () async {
              final newTag = await showDialog<String>(
                context: context,
                builder: (context) {
                  final controller = TextEditingController();
                  return AlertDialog(
                    title: const Text("Tambah Tag"),
                    content: TextField(
                      controller: controller,
                      autofocus: true,
                      onSubmitted: (val) => Navigator.pop(context, val),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context, controller.text),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
              if (newTag != null && newTag.trim().isNotEmpty) {
                _addTag(newTag.trim());
              }
            },
            child: const Text("+ Tag"),
          ),
      ],
    );
  }
}