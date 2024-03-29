import 'dart:convert';

import 'package:blog_app/Model/post_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class PostController extends GetxController{

  var isAllPostLoading = true.obs;
  var allPostList = <PostModel>[].obs;
  var postDetails = PostModel().obs;
  var allPostPage = 1.obs;

  var isUserPostLoading = true.obs;
  var userPostList = <PostModel>[].obs;
  var updatePost = PostModel().obs;
  var postUpdateResult = false.obs;

  var postDeleteResult = false.obs;

  var selectImagePath = ''.obs;

  var createPost = PostModel().obs;
  var createPostResult = false.obs;
  var createPostStatusCode = "".obs;
  var isInputFieldEmpty = false.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }





  Future<void> fetchPosts() async {
    try{
      if(isAllPostLoading.value){
        var allPosts = await AppService.fetchAllPost({
          "limit" : "",
          "title" : "",
          "page" : allPostPage.value.toString(),
          "type" : 5.toString()
        });
        // print("check post length: post controller : ${allPosts.length}");
        if(allPostPage.value == 1){
          allPostList.assignAll(allPosts);
        }
        else{
          allPostList.addAll(allPosts);
        }
        update();
        isAllPostLoading.value = false;
      }
      // print("check post length: post controller : ${allPostList.length}");
    }
    finally{
      await fetchUserPosts();
    }
  }


  Future<void> fetchUserPosts() async {
    try{
      if(isUserPostLoading.value){
        var userPosts = await AppService.fetchUserPost();
        userPostList.assignAll(userPosts);
        isUserPostLoading.value = false;
      }
    }
    finally{

    }
  }

  void postUpdate() async{
    Map map = {
      "headline" : updatePost.value.headline,
      "content" : updatePost.value.content,
      "type" : "5",
      "status" : "1"
    };

    var result = (await AppService.updatePost(map, updatePost.value.id as int));
    if(result == true){
      postUpdateResult.value = true;
      fetchUserPosts();
    }
    else{
      showErrorSnackbar("Something's missing for update post");
    }
  }

  void getImage(ImageSource imageSource) async
  {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      selectImagePath.value = pickedFile.path;
    }
    else{
     if(selectImagePath.value == null){
       showErrorSnackbar("No select Image");
     }
    }
  }

  void showErrorSnackbar(String message)
  {
    Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffa02612),
        colorText: Colors.white
    );
  }
  void showSuccessSnackbar(String message)
  {
    Get.snackbar(
        "Success",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xff003402),
        colorText: Colors.white
    );
  }


  Future<void> createNewPost() async
  {
    var bytes =  selectImagePath.value != '' ?  File(selectImagePath.value).readAsBytesSync() : null;
    try{
      Map<String,dynamic> postBody = {
        "headline" : createPost.value.headline,
        "content" : createPost.value.content,
        "status" : createPost.value.status,
        // "job_id" : createPost.value.job_id,
        "image" : selectImagePath.value != '' ? "data:image/png:base64, "+base64Encode(bytes!) : "",
        "video" : createPost.value.videlUrl
      };
      createPostStatusCode.value = await AppService.createPost(postBody);
    }
    catch(message){
      showErrorSnackbar(message.toString());
    }
    finally{
      fetchUserPosts();
    }
  }

  bool checkCreatePostInputField()
  {
    if(createPost.value.headline == null) return false;
    if(createPost.value.content == null) return false;
    // if(createPost.value.job_id == null) return false;
    // if(createPost.value.status == null) return false;
    // if(selectImagePath.isEmpty) return false;
    return true;
  }

  Future<bool> deletePost(String postId) async{
    var result = await AppService.deletePost(postId);
    postDeleteResult.value = true;
    return result;
  }

}