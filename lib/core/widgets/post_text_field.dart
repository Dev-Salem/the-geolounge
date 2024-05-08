// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class PostTextField extends StatefulWidget {
  const PostTextField({
    required this.onSend,
    super.key,
    this.validator,
    this.replyTo,
    this.hintText,
  });
  final void Function(String?) onSend;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? replyTo;

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField> {
  late final TextEditingController _controller;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textField = Container(
      height: 70,
      width: double.infinity,
      color: context.hoverColor,
      child: Row(
        children: [
          const SizedBox(
            width: 24,
          ),
          Expanded(
            flex: 5,
            child: Form(
              key: formKey,
              child: Theme(
                data: context.theme.copyWith(
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.all(9),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
                child: TextFormField(
                  minLines: 1,
                  controller: _controller,
                  validator: widget.validator,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? t.posts.write_something,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: IconButton.filled(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.onSend(_controller.text);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.send),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
    return widget.replyTo == null
        ? textField
        : _ReplyWidget(text: widget.replyTo!, textField: textField);
  }
}

class _ReplyWidget extends StatelessWidget {
  final String text;
  final Widget textField;
  const _ReplyWidget({
    required this.text,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.dividerColor,
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Reply to: $text',
              style: context.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          textField,
        ],
      ),
    );
  }
}
