import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/post/presentation/controller/post_controller.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  late final TextEditingController _contentController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Rooms _selectedRoom = Rooms.general;
  @override
  Widget build(BuildContext context) {
    ref.listen(
      postControllerProvider,
      (previous, current) {
        if (current.isLoading) {
          context.loaderOverlay.show();
        }
        if (current.hasError && (!current.isLoading)) {
          context.loaderOverlay.hide();
        }
      },
    );
    return LoaderOverlay(
      overlayColor: Colors.black38,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.posts.create_post),
          leading: IconButton(
            onPressed: ref.read(goRouterProvider).pop,
            icon: const Icon(FontAwesomeIcons.xmark),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ref
                      .read(postControllerProvider.notifier)
                      .addPost(_contentController.text, _selectedRoom);
                }
              },
              child: Text(
                t.posts.post,
                style: context.bodyLarge!.bold,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _contentController,
                  minLines: 5,
                  maxLines: 10,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.length < 5) {
                      return t.chat.too_short;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: t.posts.write_something,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.hashtag),
                title: Text(
                  t.posts.select_room,
                  style: context.bodyLarge!.bold,
                ),
                subtitle: Text(
                  t.posts.choose_room,
                  style: context.bodyMedium,
                ),
                trailing: DropdownButton(
                  value: _selectedRoom,
                  icon: const Icon(Icons.expand_more),
                  items: Rooms.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            t['rooms.${e.name}'] as String,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (room) {
                    setState(() {
                      _selectedRoom = room!;
                    });
                  },
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 30),
        ),
      ),
    );
  }
}
