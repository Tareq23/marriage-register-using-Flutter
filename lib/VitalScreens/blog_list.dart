import 'package:blog_app/LogRegScreens/login_page_with_phone_number.dart';
import 'package:blog_app/ProfileScreens/profile_page.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/Services/common_widgets.dart';
import 'package:blog_app/VitalScreens/about.dart';
import 'package:blog_app/VitalScreens/assistent.dart';
import 'package:blog_app/VitalScreens/blog_post_details.dart';
import 'package:blog_app/VitalScreens/kaji_list.dart';
import 'package:blog_app/VitalScreens/my_blog_list.dart';
import 'package:blog_app/controller/network_controller.dart';
import 'package:blog_app/controller/post_controller.dart';
import 'package:blog_app/conversation/message_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogListPageView extends StatelessWidget {

  final PostController _postController = Get.put(PostController());
  final NetworkController _networkController = Get.put(NetworkController());

  final _globalScaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final Image defaultImage = Image.asset(
      "assets/default_blog_post_image.jpg",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _globalScaffoldKey,
      endDrawer: Drawer(
        elevation: 100,
        child: Container(
          // color: Colors.green,
          color: ConstValue.color,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 20,
              ),
              // const Divider(
              //   color: ConstValue.drawerIconColor
              // ),
              Container(

                padding: const EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BlogListPageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("????????????",style: ConstValue.drawerTestStyle,),
                    ],

                  ),
                ),

              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(

                padding: const EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KajiListPageViewExtend()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("???????????? ???????????????",style: ConstValue.drawerTestStyle,),
                    ],

                  ),
                ),

              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(

                padding: const EdgeInsets.all(16.0),

                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Assistant()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("?????????????????????????????????????????????",style: ConstValue.drawerTestStyle,),
                    ],

                  ),
                ),

              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => ProfilePageView()));
                        MaterialPageRoute(
                            builder: (context) => ProfilePageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.person,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("???????????? ????????????????????????",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyBlogListPageView()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.dashboard,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("???????????? ????????????",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Message()));
                    /*        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashBoardConfig()));*/
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.message,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("?????????????????????",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.money,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("?????????????????????",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.info,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("????????????????????????",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async{
                    final prefs = await SharedPreferences.getInstance();
                    final removeAccessToken = await prefs.remove('access_token');
                    final removeUserId = await prefs.remove('user_id');
                    if(removeAccessToken || removeUserId){
                      Get.to(() => const Login());
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.money,color: ConstValue.drawerIconColor,),
                      SizedBox(width: 10),
                      Text("Logout",style: ConstValue.drawerTestStyle,),
                    ],
                  ),
                ),
              ),
              const Divider(
                  color: ConstValue.drawerIconColor
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ConstValue.color,
        leading: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(0),
            child: Image.asset('assets/bmrplogo2.png')),
        // title: const Text('National MRDC',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        actions: [
          Container(
            margin: const EdgeInsets.all(0),
            // padding: const EdgeInsets.all(0),
              padding: const EdgeInsets.only(top: 18),
            width: screenSize.width * 0.7,
            height: double.infinity,
            child: Center(
              child: Marquee(
                text: '???????????????????????? ????????????????????? ??????????????????????????????????????? ?????????????????????????????? ?????????????????? ???????????????????????? ',
                style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ),
          IconButton(onPressed: (){
            _globalScaffoldKey.currentState?.openEndDrawer();
          }, icon: const Icon(Icons.menu_rounded)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearchDialog(context);
        },
        backgroundColor: const Color(0xFF002632),
        child: const Icon(
          Icons.search_rounded,
          color: Color(0xFFFFFFFF),
          size: 34,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              await _postController.fetchPosts();
            },
            child: Obx(() {
              if (NetworkController.networkError.value &&
                  _postController.allPostList.isEmpty) {
                return Center(
                  child: NetworkNotConnect(page: "allPost",controller: _postController,),
                );
              }else if(_postController.isAllPostLoading.value){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (_postController.allPostList.isNotEmpty) {
                return ListView(
                  children: [
                    const SizedBox(height: 15,),
                    ..._postController.allPostList.map((post){
                      String title =
                      post.headline.toString();
                      String author =
                      post.author.toString();
                      String dataTime =
                          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

                      String imageFileNameString =
                      post.image.toString();

                      // String img;
                      // // ignore: unnecessary_null_comparison
                      // if (imageFileNameString != null) {
                      //   img = imageFileNameString;
                      //   List imgUrlExplode = img.split("://");
                      //   if (img.length > 2000 || imgUrlExplode[0] != "https") {
                      //     img =
                      //     "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                      //   }
                      // } else {
                      //   img =
                      //   "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                      // }

                      // List img2 = img.split(".");
                      // // print(img2);
                      // String heroAnimationTag = post.id.toString();
                      // // var topPadding = index == 0 ? 15.0 : 0.0;
                      // if(img2[img2.length-1].toString().toLowerCase() != "jpg" && img2[img2.length-1].toString().toLowerCase() != "png"){
                      //   img = "https://icon-library.com/images/image-placeholder-icon/image-placeholder-icon-5.jpg";
                      // }
                      return Container(
                          padding:  const EdgeInsets.all(0),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 15),
                          width: MediaQuery.of(context).size.width - 10,
                          height: (MediaQuery.of(context).size.height * 0.2),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: GestureDetector(
                            onTap: () {

                              _networkController.onInit();
                              if(NetworkController.networkError.value){
                                NetworkController.showNetworkConnection();
                              }
                              _postController.postDetails.value = post;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BlogPostDetails(post.id.toString())));
                            },
                            child: Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    padding: const EdgeInsets.all(0),
                                    margin: const EdgeInsets.all(0),
                                    child: Hero(
                                      tag: post.id.toString(),
                                      child: post.image != null ? Image.network(
                                        post.image.toString(),
                                        width: double.infinity,
                                        height: double.infinity,
                                        loadingBuilder: (context, child, loadingProgress) =>
                                        (loadingProgress == null) ? child : const CircularProgressIndicator(strokeWidth: 3,color: Color(
                                            0xFF0A4000),),
                                        errorBuilder: (context, error, stackTrace) => defaultImage,
                                      ) : Image.asset(
                                        "assets/blank_post_image.PNG",
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),

                                    )
                                ),
                                Container(
                                    width: (screenSize.width * 0.65) - 25,
                                    height: screenSize.height * 0.2,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 0, top: 0, bottom: 0),
                                    margin: const EdgeInsets.all(0),
                                    alignment: Alignment.centerLeft,
                                    decoration:
                                    const BoxDecoration(color: Colors.white),
                                    child: Column(
                                      children: [
                                        /* Post Title */
                                        Scrollbar(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              width: double.infinity,
                                              height: screenSize.height * 0.18,
                                              padding: const EdgeInsets.all(0),
                                              margin: const EdgeInsets.all(0),
                                              child: Text(
                                                title,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        /* Author and Title */
                                        Container(
                                          width: double.infinity,
                                          height: screenSize.height * 0.02,
                                          padding: const EdgeInsets.all(0),
                                          margin: const EdgeInsets.all(0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  author,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  dataTime,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black54),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ));
                    }),
                    OutlinedButton(
                      onPressed: (){
                        _postController.isAllPostLoading.value = true;
                        _postController.allPostPage.value++;
                        _postController.fetchPosts();
                      },
                      child: const Text('Load more',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      style: OutlinedButton.styleFrom(
                        primary: ConstValue.whileColor,
                        backgroundColor: ConstValue.color,

                      ),
                    )
                  ],
                );


              } else {
                return EmptyListData(page: "allPost",controller: _postController,);
              }
            }),
          ),
        ),
      ),
    );
  }





  /* Pop up for post search */
  void showSearchDialog(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var searchText = "".obs;
    var isSearching = false.obs;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx((){
          return  AlertDialog(
            content: Container(
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.2,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff00132f)),
                        focusColor: Color(0xff00132f),
                        border: OutlineInputBorder(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 2, color: Colors.indigo.shade900)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF1F003E),
                            )),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF2C0131),
                              width: 2,
                            ))),
                    onChanged: (newValue) {
                      searchText.value = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
            actions: isSearching.value == false
            ? [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Color(0xFF001632),
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: OutlinedButton(
                  onPressed: () {
                    if (_postController.allPostList.isNotEmpty &&
                        searchText != "") {
                      isSearching.value = true;
                      var result = _postController.allPostList
                          .where((post) => post.headline!
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                          .toList();
                      _postController.allPostList.value = result;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Search',
                      style: TextStyle(
                          color: Color(0xFF001632),
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                )),
            ]
            : [],
          );
        });
      },
    );
  }
}
