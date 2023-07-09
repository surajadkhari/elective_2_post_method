import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_const.dart';

class PostDataUI extends StatefulWidget {
  const PostDataUI({super.key});

  @override
  State<PostDataUI> createState() => _PostDataUIState();
}

class _PostDataUIState extends State<PostDataUI> {
  late TextEditingController nameController;
  late TextEditingController jobController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    jobController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Please enter name",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job";
                    }
                    return null;
                  },
                  controller: jobController,
                  decoration: const InputDecoration(
                      hintText: "Please enter job",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> userData = {
                        "name": nameController.text,
                        "job": jobController.text
                      };

                      Dio dio = Dio(BaseOptions(baseUrl: apibaseUrl));
                      final result = await dio.post(userPath, data: userData);
                      nameController.clear();
                      jobController.clear();
                      print(result.statusCode);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          content: Text("Submit successfully"),
                        ));
                      }
                    }
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
