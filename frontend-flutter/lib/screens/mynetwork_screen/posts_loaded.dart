import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/models/post_model.dart';
import 'package:sentimento/screens/mynetwork_screen/detailed_post.dart';
import 'package:sentimento/widgets/header_clippath.dart';

class PostsLoaded extends StatelessWidget {
  const PostsLoaded({Key? key, required this.isUser, required this.posts})
      : super(key: key);
  final bool isUser;
  final List<Vacancy> posts;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        children: <Widget>[
          const HeaderClipPath(times: 0.3),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.084, left: size.width * 0.4),
            child: Text(
              "Total: ${posts.length}",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                for (int i = 0; i < posts.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (context) => DetailedPost(
                                    post: posts[i],
                                    isUser: isUser,
                                  ));
                        },
                        tileColor: Colors.grey[350],
                        title: Text(posts[i].title!),
                        subtitle: Text("${posts[i].wageHr!}/hr"),
                        trailing: const Icon(
                          CupertinoIcons.info,
                          color: Colors.teal,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  )
              ],
            )),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.06, left: 20),
            child: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 40,
                )),
          ),
        ],
      ),
    );
  }
}
