import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notification_model.dart'; // Import the notification model
import 'dart:typed_data';

class Post {
  String username;
  final ImageProvider userImageUrl;
  String timestamp;
  String contentText;
  final ImageProvider contentImageUrl;
  int likes;
  int dislikes;
  bool isDisliked;
  bool isLiked;

  Post({
    required this.username,
    required this.userImageUrl,
    required this.timestamp,
    required this.contentText,
    required this.contentImageUrl,
    this.likes = 0,
    this.dislikes = 0,
    this.isDisliked = false,
    this.isLiked = false,
  });
}

List<Post> posts = [
  Post(
    username: 'John Doe',
    userImageUrl: const NetworkImage('https://picsum.photos/250?image=237'),
    timestamp: '21 hours ago',
    contentText: 'Enjoying the beautiful sunset at the beach!',
    contentImageUrl: const NetworkImage('https://picsum.photos/250?image=51'),
  ),
  Post(
    username: 'Orhero Onome',
    userImageUrl: const AssetImage('assets/myphoto.jpg'),
    timestamp: '3 day ago',
    contentText: 'Flutter enthusiast and creator EchoFeed',
    contentImageUrl: const AssetImage('assets/myphoto.jpg'),
  ),
  Post(
    username: 'Mark Doe',
    userImageUrl: const NetworkImage('https://picsum.photos/250?image=237'),
    timestamp: '5 day ago',
    contentText: 'Just got back from a fun vacation in the mountains.',
    contentImageUrl: const NetworkImage('https://picsum.photos/250?image=52'),
  ),
];

class Newsfeed extends StatefulWidget {
  final String fullName;
  final Uint8List? profileImage;

  const Newsfeed({
    super.key,
    required this.fullName,
    required this.profileImage,
  });

  @override
  NewsfeedState createState() => NewsfeedState();
}

class NewsfeedState extends State<Newsfeed> {
  late String fullName;
  late Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    fullName = widget.fullName;
    profileImage = widget.profileImage;

    // Debugging
  }

  final TextEditingController _postController = TextEditingController();

  void likeButton(int index) {
    setState(() {
      if (posts[index].isLiked) {
        posts[index].likes -= 1;
        posts[index].isLiked = false;
      } else {
        posts[index].likes += 1;
        posts[index].isLiked = true;
        Provider.of<NotificationModel>(context, listen: false).addNotification(
            'You like ${(posts[index].username == fullName ? 'your' : '${posts[index].username}\'s')} post');
      }
    });
  }

  void dislikeButton(int index) {
    setState(() {
      if (posts[index].isDisliked) {
        posts[index].dislikes -= 1;
        posts[index].isDisliked = false;
      } else {
        posts[index].dislikes += 1;
        posts[index].isDisliked = true;
        Provider.of<NotificationModel>(context, listen: false).addNotification(
            'You dislike ${(posts[index].username == fullName ? 'your' : '${posts[index].username}\'s')} post');
      }
    });
  }

  void _deletePost(int index) {
    setState(() {
      Provider.of<NotificationModel>(context, listen: false).addNotification(
          'You deleted ${(posts[index].username == fullName ? 'your' : '${posts[index].username}\'s')} post');
      posts.removeAt(index); // Remove the post from the list
    });
  }

  void _editPost(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editController =
            TextEditingController(text: posts[index].contentText);
        return AlertDialog(
          title: const Text('Edit Post'),
          content: TextField(
            controller: editController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: "Edit your post..."),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  posts[index].contentText =
                      editController.text; // Update the post
                });

                Provider.of<NotificationModel>(context, listen: false)
                    .addNotification(
                        'You edited ${(posts[index].username == fullName ? 'your' : '${posts[index].username}\'s')} post');

                Navigator.pop(context); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  String? postErrorMessage;

  // Method to add a new post
  void _addNewPost() {
    final newPost = Post(
      username: fullName,
      userImageUrl: profileImage != null
          ? MemoryImage(profileImage!) // Use MemoryImage here
          : const AssetImage('assets/default_user_image.png'),
      timestamp: 'Just now',
      contentText: _postController.text,
      contentImageUrl: const NetworkImage(
          'https://picsum.photos/250?image=53'), // Default content image
    );
    if (_postController.text.isEmpty) {
      setState(() {
        postErrorMessage = 'Please enter a text';
      });
    } else {
      // Add the new post to the top of the list
      setState(() {
        posts.insert(0, newPost);
        postErrorMessage = '';
      });
      Provider.of<NotificationModel>(context, listen: false)
          .addNotification('$fullName, your post have been added');
      // Clear the text field after posting
      _postController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding for the post input form at the top
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                margin: const EdgeInsets.only(bottom: 5),
                child: Column(
                  children: [
                    // Large TextFormField to add new posts
                    TextFormField(
                      controller: _postController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'What’s on your mind?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                    // Display error message if there's any
                    if (postErrorMessage != null)
                      Text(
                        postErrorMessage!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 169, 16, 5),
                          fontSize: 12,
                        ),
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _addNewPost,
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ),
            ),

            // Show either the feed or the message if posts are empty
            posts.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Text(
                        'You do not have any Feed',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                : ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents the list from scrolling independently
                    shrinkWrap:
                        true, // Makes the list take up only the space it needs
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            (posts[index].userImageUrl)),
                                    title: Text(posts[index].username),
                                    subtitle: Text(posts[index].timestamp),
                                    trailing: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'Edit') {
                                          _editPost(index); // Edit post
                                        } else if (value == 'Delete') {
                                          _deletePost(index); // Delete post
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          const PopupMenuItem(
                                            value: 'Edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'Delete',
                                            child: Text('Delete'),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                  // Post content
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(posts[index].contentText)),
                                  ),
                                  // Post image
                                  Image(
                                    image: posts[index].contentImageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  // Post actions (likes, dislikes, comments)
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${posts[index].likes} ${(posts[index].likes < 2) ? 'Like' : 'Likes'}',
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              '${posts[index].dislikes} ${(posts[index].dislikes < 2) ? 'Dislike' : 'Dislikes'}',
                                            ),
                                            const Spacer(),
                                            const Text('0 Comments'),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            MaterialButton(
                                              onPressed: () =>
                                                  likeButton(index),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 100.0),
                                                alignment: Alignment.center,
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(Icons.thumb_up),
                                                    SizedBox(width: 20),
                                                    Text('Like'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () =>
                                                  dislikeButton(index),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 100.0),
                                                alignment: Alignment.center,
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(Icons.thumb_down),
                                                    SizedBox(width: 20),
                                                    Text('Dislike'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: null,
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 100.0),
                                                alignment: Alignment.center,
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(Icons.comment),
                                                    SizedBox(width: 20),
                                                    Text('Comment'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
