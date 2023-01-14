import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_example_with_api/imagemodel.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageOnServerWithApi extends StatefulWidget {
  const UploadImageOnServerWithApi({super.key});

  @override
  State<UploadImageOnServerWithApi> createState() =>
      UploadImageOnServerWithApiState();
}

File? imgfile;
List<ImageModel> ilist=[];


class UploadImageOnServerWithApiState
    extends State<UploadImageOnServerWithApi> {
  
  getimagepathlist() async{
    ilist=await ImageModel.getimagename();
    setState(() {
      
    });
  }
  @override
  void initState() {
    super.initState();
    getimagepathlist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              XFile? file =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (file != null) {
                imgfile = File(file.path);
                await ImageModel.uploadImage(imgfile!);
                getimagepathlist();
              }
              setState(() {});
            },
            icon: const Icon(
              Icons.camera_alt,
              size: 40,
            ),
          ),
          Container(
              height: 300,
              width: double.infinity,
              child: ListView.builder(
                itemCount: ilist.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("http://192.168.0.105/ImageExampleAPI/Image/"+ilist[index].imagepath!),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
