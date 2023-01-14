// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageModel {
  final String? imagepath;
  ImageModel({
    this.imagepath,
  });

  ImageModel copyWith({
    String? imagepath,
  }) {
    return ImageModel(
      imagepath: imagepath ?? this.imagepath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagepath': imagepath,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      imagepath: map['imagepath'] != null ? map['imagepath'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageModel(imagepath: $imagepath)';

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.imagepath == imagepath;
  }

  @override
  int get hashCode => imagepath.hashCode;

  static Future<List<ImageModel>> getimagename() async{
    List<ImageModel> ilist=[];
    http.Response rs=await http.get(Uri.parse("http://192.168.0.105/ImageExampleAPI/api/image/getdata"));
    if (rs.statusCode==200) {
      var v=jsonDecode(rs.body.toString());
      for (var i in v) {
        ilist.add(ImageModel.fromMap(i));
      }
      return ilist;
    }
    return ilist;
  }
  static Future<String> uploadImage(File f) async{
    String url='http://192.168.0.105/ImageExampleAPI/api/image/UploadImage';
    Uri uri=Uri.parse(url);
   var request=http.MultipartRequest('POST',uri);
   http.MultipartFile newfile=await http.MultipartFile.fromPath('photo',f.path);
   request.files.add(newfile);
   var rs=await request.send();
    if (rs.statusCode==200) {
      return "uploaded";
    }
    return "";
  }
}
