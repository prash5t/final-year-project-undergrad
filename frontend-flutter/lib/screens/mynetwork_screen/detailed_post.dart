import 'package:flutter/material.dart';
import 'package:sentimento/api/mynetwork_requests.dart';
import 'package:sentimento/models/post_model.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedPost extends StatelessWidget {
  const DetailedPost({Key? key, required this.post, required this.isUser})
      : super(key: key);
  final Vacancy post;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.grey[350],
              title: const Text("Role"),
              subtitle: Text(post.title!),
              trailing: const Icon(
                Icons.work,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.grey[350],
              title: const Text("Email"),
              subtitle: Text(post.contactEmail!),
              trailing: const Icon(
                Icons.email,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.grey[350],
              title: const Text("Contact Number"),
              subtitle: Text(post.contactNumber!),
              trailing: const Icon(
                Icons.phone,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.grey[350],
              title: const Text("Wage"),
              subtitle: Text("${post.wageHr}/hr"),
              trailing: const Icon(
                Icons.monetization_on,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.grey[350],
              title: const Text("Negotiable"),
              subtitle: Text(post.isNegotiable! ? "Yes" : "No"),
              trailing: const Icon(
                Icons.handyman_sharp,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.grey[350],
              title: const Text("Description"),
              subtitle: Text(post.description!),
              trailing: const Icon(
                Icons.description,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    if (isUser) {
                      var resp = await deleteSelectedPost(post.id);
                      if (resp["success"] == "true") {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.homescreen, (route) => false);
                      }
                    } else {
                      if (await canLaunch("tel:${post.contactNumber}")) {
                        await launch("tel:${post.contactNumber}");
                      } else {
                        manualToastMsg("Could not contact");
                      }
                    }
                  },
                  child: Text(isUser ? "Delete Post" : "Contact")),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Not Interested")),
            ],
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
