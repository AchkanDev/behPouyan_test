import 'dart:async';
import 'dart:typed_data';
import 'package:beh_pouyan_test/data/Reopsitory/post_repository.dart';
import 'package:beh_pouyan_test/screens/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beh_pouyan_test/screens/post/bloc/add_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  StreamSubscription<AddPostState>? streamSubscription;
  TextEditingController caption = TextEditingController();
  Uint8List? file;
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? xfile = await imagePicker.pickImage(source: source);
    if (xfile != null) {
      return xfile.readAsBytes();
    }
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Not Selected")));
  }

  selectImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take Camera"),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List image = await pickImage(ImageSource.camera);
                setState(() {
                  file = image;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Import From Gallery"),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List image = await pickImage(ImageSource.gallery);
                setState(() {
                  file = image;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancell"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return file == null
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Add Post"),
              centerTitle: true,
            ),
            body: Container(
              alignment: Alignment.center,
              child: Center(
                child: IconButton(
                    onPressed: () => selectImage(context),
                    icon: Icon(
                      Icons.upload_file_outlined,
                      size: 30,
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
              ),
            ))
        : BlocProvider<AddPostBloc>(
            create: (context) {
              final bloc = AddPostBloc(postRepository);
              // bloc.add(PostStarted());
              streamSubscription = bloc.stream.listen((state) {
                if (state is AddPostSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Posted !"),
                  ));
                  file = null;
                  Navigator.of(context).pop();

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPostScreen(),
                  ));
                } else if (state is AddPostError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.appException.messageError),
                  ));
                }
              });
              return bloc;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddPostScreen(),
                      ));
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: BlocBuilder<AddPostBloc, AddPostState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AspectRatio(
                                aspectRatio: 487 / 451,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: MemoryImage(file!),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: TextField(
                                controller: caption,
                                decoration: InputDecoration(
                                    hintText: "Write your caption ...",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context)),
                                    filled: true),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<AddPostBloc>(context)
                                          .add(PostImage(file!, caption.text));
                                    },
                                    child: const Text("Post")),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
