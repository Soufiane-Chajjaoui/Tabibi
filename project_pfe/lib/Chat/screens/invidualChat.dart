import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pfe/Agent/screens/doctors.dart';
import 'package:project_pfe/Chat/screens/widgets/messageUI.dart';
import 'package:project_pfe/actions/Message.dart';
 import 'package:project_pfe/actions/Socket.dart';
import 'package:project_pfe/actions/UserChat.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

class ChatInvidual extends StatefulWidget {
  ChatInvidual({super.key, required this.userInvidual});
  UserChat userInvidual;
  @override
  State<ChatInvidual> createState() => _ChatInvidualState();
}

class _ChatInvidualState extends State<ChatInvidual> {
  bool emojishowing = false;
  FocusNode focusNode_controll = FocusNode();
  ScrollController _contollerScroller = ScrollController();

  IconData? Icondata = Icons.mic_rounded;

  TextEditingController _controller = TextEditingController();

  List<MessageChat> messages = [];

  String? idSender;
  late bool isAgent = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getIdSender() async {
    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString("_id");
    idSender = id!;

    isAgent = (await _pref.getBool('isAgent'))!;
  }

  void socketMethod() {
    DateTime currentTime = DateTime.now();

    Socketmanager.ConnectionSocket();
    //   socket?.onConnectError(
    //       (data) => print('Error connection with server socket $data'));
    Socketmanager.socket?.on('/receive', (msg) {
      // messages.add(MessageChat.fromJson(msg));

      if (mounted) {
        setState(() {
          print(msg);
          messages.add(MessageChat(
              isMe: false,
              content: msg['content'],
              dateMessage: DateFormat.Hm().format(currentTime)));
          _contollerScroller.animateTo(
              _contollerScroller.position.maxScrollExtent,
              duration: Duration(milliseconds: 1),
              curve: Curves.linear);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdSender();
    socketMethod();
    focusNode_controll.addListener(() {
      if (focusNode_controll.hasFocus) {
        setState(() {
          emojishowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.userInvidual.username}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        leadingWidth: MediaQuery.of(context).size.width / 4.3,
        actions: [
          isAgent
              ? PopupMenuButton(
                  splashRadius: 25,
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => ListDoctors(),
                                  settings: RouteSettings(
                                      arguments: widget.userInvidual.id))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.share),
                              Text('Share'),
                            ],
                          ),
                        ),
                      ),
                    ];
                  })
              : SizedBox.shrink(),
        ],
        backgroundColor: Colors.deepOrangeAccent[200],
        leading: InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: () => Navigator.of(context).pop(),
          child: Row(children: [
            Icon(Icons.arrow_back),
            CircleAvatar(
                backgroundColor: Colors.green,
                radius: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    alignment: Alignment.center,
                    imageUrl:
                        "https://res.cloudinary.com/dw2qfkws9/image/upload/v1684929857/uploads/q1fc07m0qy1dmbggrist.jpg",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 55,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: Image.network(
                          "https://res.cloudinary.com/dw2qfkws9/image/upload/v1684929857/uploads/q1fc07m0qy1dmbggrist.jpg"),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ))
          ]),
        ),
      ),
      body: WillPopScope(
          child: Stack(
            children: [
              Image.asset(
                'images/doctors_start_page.jpeg',
                color: Color.fromARGB(229, 173, 35, 35).withOpacity(0.7),
                fit: BoxFit.cover,
                width: double.infinity,
                colorBlendMode: BlendMode.modulate,
                height: height,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 60),
                width: width,
                height: height - 25,
                child: ListView.builder(
                  padding: EdgeInsetsDirectional.only(top: 7, bottom: 40),
                  controller: _contollerScroller,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MessageBox(messages[index].content, context,
                        "${messages[index].dateMessage}",
                        isMe: messages[index].isMe);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextFormField(
                                    controller: _controller,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          Icondata = Icons.send;
                                        });
                                      } else {
                                        setState(() {
                                          Icondata = Icons.mic_rounded;
                                        });
                                      }
                                    },
                                    focusNode: focusNode_controll,
                                    textAlignVertical: TextAlignVertical.center,
                                    cursorHeight: 20,
                                    keyboardType: TextInputType.text,
                                    maxLines: 6,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Message',
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.emoji_emotions),
                                        splashRadius: 22,
                                        onPressed: () {
                                          focusNode_controll.unfocus();
                                          // focusNode_controll.canRequestFocus = false;
                                          setState(() {
                                            emojishowing = !emojishowing;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CircleAvatar(
                              radius: 23,
                              child: IconButton(
                                icon: Icon(Icondata),
                                onPressed: () async {
                                  DateTime currentTime = DateTime.now();
                                  if (_controller.text.length > 0) {
                                    Socketmanager.SendMessage(MessageChat(
                                        isMe: true,
                                        content: _controller.text,
                                        idSender: idSender,
                                        idReceiver: widget.userInvidual.id,
                                        dateMessage: DateFormat.Hm()
                                            .format(currentTime)));
                                    // await Person.SendMessage(MessageChat(
                                    //     isMe: true,
                                    //     content: _controller.text,
                                    //     idSender: idSender,
                                    //     idReceiver: widget.userInvidual.id,
                                    //     dateMessage: DateFormat.Hm()
                                    //         .format(currentTime)));

                                    setState(() {
                                      messages.add(MessageChat(
                                          isMe: true,
                                          content: _controller.text,
                                          dateMessage: DateFormat.Hm()
                                              .format(currentTime)));
                                      _controller.clear();
                                    });
                                  }

                                  _contollerScroller.animateTo(
                                      _contollerScroller
                                          .position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 1),
                                      curve: Curves.linear);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Offstage(
                        offstage: !emojishowing,
                        child: SizedBox(
                            height: height / 2,
                            child: EmojiPicker(
                              textEditingController: _controller,
                              config: Config(
                                columns: 9,
                                // Issue: https://github.com/flutter/flutter/issues/28894
                                emojiSizeMax: 25 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: const Color(0xFFF2F2F2),
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                showRecentsTab: true,
                                recentsLimit: 28,
                                replaceEmojiOnLimitExceed: false,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                loadingIndicator: const SizedBox.shrink(),
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                                checkPlatformCompatibility: true,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          onWillPop: () {
            if (emojishowing) {
              setState(() {
                emojishowing = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          }),
    );
  }
}
