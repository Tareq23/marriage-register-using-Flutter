import 'dart:ffi';

import 'package:blinking_text/blinking_text.dart';
import 'package:blog_app/Model/message_model.dart';
import 'package:blog_app/Services/color.dart';
import 'package:blog_app/controller/message_controller.dart';
import 'package:blog_app/conversation/send_message.dart';
import 'package:blog_app/conversation/user_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LogRegScreens/login_page_with_phone_number.dart';
import '../ProfileScreens/profile_page.dart';
import '../Services/common_widgets.dart';
import '../VitalScreens/about.dart';
import '../VitalScreens/assistent.dart';
import '../VitalScreens/blog_list.dart';
import '../VitalScreens/kaji_list.dart';
import '../VitalScreens/my_blog_list.dart';
import '../controller/network_controller.dart';
import '../controller/unread_message_controller.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message>
    with TickerProviderStateMixin {
  late final MessageController messageController;
  final _refreshIndicatorKeyMyMsg= GlobalKey<RefreshIndicatorState>();
  final _refreshIndicatorKeyAdminMsg = GlobalKey<RefreshIndicatorState>();

  final ScrollController _scrollController = ScrollController();
  late TabController tabController;

  num unreadMessage=0;

  @override
  void initState() {
    Get.delete<MessageController>();
    messageController = Get.put(MessageController());
    messageController.fetchMessages();
    UnreadMessageController.fetchUnreadMessageNumber();
    if(UnreadMessageController.unreadMessage['admin'].toString() != "null"){
      setState(() {
        unreadMessage += UnreadMessageController.unreadMessage['admin'];
      });
    }
    if(UnreadMessageController.unreadMessage['user'].toString() != "null"){
      setState(() {
        unreadMessage += UnreadMessageController.unreadMessage['user'];
      });
    }
    // print("checkkkkkkk   ${UnreadMessageController.unreadMessage['admin']}");

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if(tabController.indexIsChanging)
        if(tabController.index == 0){
          messageController.fetchMessages();
        }
        else{
          messageController.fetchAdminMessage();
          UnreadMessageController.fetchUnreadMessageNumber();
        }
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                const Divider(color: ConstValue.drawerIconColor),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlogListPageView()));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.dashboard,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ব্লগ",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
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
                        Icon(
                          Icons.person,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "আমার প্রোফাইল",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
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
                        Icon(
                          Icons.dashboard,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "আমার লেখা",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KajiListPageViewExtend()));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.dashboard,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "কাজী লিস্ট",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Assistant()));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.dashboard,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "অ্যাসিস্ট্যান্ট",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
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
                      children: [
                        Icon(
                          Icons.message,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ম্যাসেজ",
                          style: ConstValue.drawerTestStyle,
                        ),
                        if(unreadMessage != 0) SizedBox(width: 30,),
                        if(unreadMessage !=0)
                          BlinkText(
                              unreadMessage.toString(),
                              style: TextStyle(fontSize: 32.0, color: Colors.redAccent),
                              beginColor: Color(0xa6ff0000),
                              endColor: Color(0xffff0000),
                              times: 10,
                              duration: Duration(seconds: 1)
                          ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.info,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "সম্পর্কে",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(
                          Icons.money,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "পেমেন্ট",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final removeAccessToken =
                          await prefs.remove('access_token');
                      final removeUserId = await prefs.remove('user_id');
                      if (removeAccessToken || removeUserId) {
                        Get.to(() => const Login());
                      }
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.money,
                          color: ConstValue.drawerIconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Logout",
                          style: ConstValue.drawerTestStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: ConstValue.drawerIconColor),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: ConstValue.color,
          leading: IconButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPageView()));
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_sharp,
              )),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tab(text: 'My Message'),
                  if (UnreadMessageController.unreadMessage['user'] != 0)
                    Text(
                      "${UnreadMessageController.unreadMessage['user']}",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tab(text: 'Admin Message'),
                  if (UnreadMessageController.unreadMessage['admin'] != 0)
                    Text(
                      "${UnreadMessageController.unreadMessage['admin']}",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      ),
                    )
                ],
              ),
            ],
          ),
          title: const Text('ম্যাসেজ'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            // Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SendMessage()));
            showSendMessageDialog(context, 0);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            RefreshIndicator(
              key: _refreshIndicatorKeyMyMsg,
              onRefresh: () async {
                messageController.isLoadingMessage.value = true;
                await messageController.fetchMessages();
              },
              child: Obx(() {
                if (NetworkController.networkError.value &&
                    messageController.msgList.isEmpty) {
                  return Center(
                    child: NetworkNotConnect(
                      page: "myMessage",
                      controller: messageController,
                    ),
                  );
                } else if (messageController.isLoadingMessage.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (messageController.msgList.isNotEmpty) {
                  return ListView.builder(
                    // reverse: true,
                    // itemCount: messList.length,
                    itemCount: messageController.msgList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          showSendMessageDialog(
                              context, messageController.msgList[index].id);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 10, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      // backgroundImage: NetworkImage(widget.imageUrl.toString()),

                                      // ignore: unnecessary_null_comparison
                                      // backgroundImage: AssetImage("assets/default_person.jpg"),
                                      backgroundImage: (messageController
                                                      .msgList[index].imgUrl ==
                                                  null ||
                                              messageController
                                                      .msgList[index].imgUrl ==
                                                  '')
                                          ? const AssetImage(
                                              "assets/default_person.jpg")
                                          : NetworkImage(messageController
                                              .msgList[index].imgUrl
                                              .toString()) as ImageProvider,
                                      maxRadius: 30,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${messageController.msgList[index].messageText}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF181818),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                messageController.msgList[index]
                                                            .name !=
                                                        null
                                                    ? Text(
                                                        "${messageController.msgList[index].name}",
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xFF505050)),
                                                      )
                                                    : const Text(""),
                                                Text(
                                                  "${messageController.msgList[index].createdAtAgo}",
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xFF505050)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return EmptyListData(
                      page: "myMessage", controller: messageController);
                }
              }),
            ),

            // Admin Message
            RefreshIndicator(
              key: _refreshIndicatorKeyAdminMsg,
              onRefresh: () async{
                messageController.isLoadingAdminMessage.value = true;
                await messageController.fetchAdminMessage();
              },
              child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  child: Obx(() {
                    if (NetworkController.networkError.value &&
                        messageController.adminMessageList.isEmpty) {
                      return Center(
                        child: NetworkNotConnect(
                          page: "adminMessage",
                          controller: messageController,
                        ),
                      );
                    } else if (messageController.isLoadingAdminMessage.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (messageController.adminMessageList.isNotEmpty) {
                      return ListView(
                        reverse: true,
                        children: [
                          ...messageController.adminMessageList.map((element) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 10, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          // backgroundImage: NetworkImage(widget.imageUrl.toString()),

                                          // ignore: unnecessary_null_comparison
                                          // backgroundImage: AssetImage("assets/default_person.jpg"),
                                          backgroundImage: (element.imgUrl ==
                                                      null ||
                                                  element.imgUrl == '')
                                              ? const AssetImage(
                                                  "assets/default_person.jpg")
                                              : NetworkImage(
                                                      element.imgUrl.toString())
                                                  as ImageProvider,
                                          maxRadius: 30,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${element.messageText}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF181818),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    element.name != null
                                                        ? Text(
                                                            "${element.name}",
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                color: Color(
                                                                    0xFF505050)),
                                                          )
                                                        : const Text(""),
                                                    Text(
                                                      "${element.createdAtAgo}",
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          color:
                                                              Color(0xFF505050)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          //TextButton(onPressed: onPressed, child: child)
                        ],
                      );
                    } else {
                      return EmptyListData(
                          page: "adminMessage", controller: messageController);
                    }
                  })),
            )
          ],
        ));
  }

  void showSendMessageDialog(BuildContext context, int? id) {
    //print("User Id -> $id");
    Get.defaultDialog(
        title: "Message To Admin",
        titleStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
        content: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(0),
            child: TextFormField(
              onChanged: (value) {
                messageController.text.value = value;
              },
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none),
              ),
            )),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF710046),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Obx(() {
            if (messageController.isSendMessage.value) {
              return const CircularProgressIndicator();
            } else {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF0053E5),
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  messageController.text.value =
                      messageController.text.value.trim();
                  // print(messageController.text.value);
                  if (messageController.text.value.isNotEmpty) {
                    messageController.isSendMessage.value = true;
                    var result = await messageController.sendMessage(id ?? 0);
                    if (result) {
                      messageController.text.value = '';
                      await messageController.fetchMessages();
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }
          }),
        ]);
  }
}
