
import 'package:blog_app/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogPostDetails extends StatelessWidget {

  String? author;
  String? title;
  String? createdAt;
  String heroAnimationTag;
  BlogPostDetails(this.heroAnimationTag, {Key? key}) : super(key: key);

  var _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade600,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded,size: 26,color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx((){
              String imageFileNameString = _postController.postDetails.value.image.toString();

              String img ;
              // ignore: unnecessary_null_comparison
              if (imageFileNameString != null) {
                img = imageFileNameString;
                List imgUrlExplode = img.split("://");
                if (img.length > 2000 || imgUrlExplode[0] != "https") {
                  img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                }
              } else {
                img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
              }
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: heroAnimationTag,
                    child: Image(
                      image: NetworkImage(img),
                      width: double.infinity,
                      height: screenSize.height * 0.27,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Author : ${_postController.postDetails.value.author}",
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.blueGrey.shade900),),
                      Text("Created at : ${_postController.postDetails.value.created_at}",
                        style : TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.blueGrey.shade900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SelectableText(
                    '${_postController.postDetails.value.headline}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.blueGrey.shade900),
                  ),
                  const SizedBox(height: 10,),
                  // SelectableText(
                  //   '${_postController.postDetails.value.content}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),
                  // ),
                  Html(
                    data:_postController.postDetails.value.content,
                    style: {
                      "p" : Style(
                        fontSize: const FontSize(17),
                        fontWeight: FontWeight.w400,
                      )
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
