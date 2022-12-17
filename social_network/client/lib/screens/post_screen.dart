import 'package:flutter/material.dart';
import 'package:client/models/post_model.dart';
import 'package:client/models/post_api.dart';
import 'package:client/models/user_api.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/view_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreen();
}

class _PostScreen extends State<PostScreen> {
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F6),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Instagram',
                  style: TextStyle(
                      fontFamily: 'Billabong',
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.live_tv),
                      iconSize: 30.0,
                      onPressed: () => print('IGTV'),
                    ),
                    const SizedBox(width: 16.0),
                    Container(
                      width: 35.0,
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        iconSize: 30.0,
                        onPressed: () => print('Direct Messages'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 97,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(74),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/user3.png',
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                          const Text('Utente'),
                        ],
                      ),
                    ],
                  ),
                );
              }, //image: AssetImage(stories[index - 1]),
            ),
          ),
          FutureBuilder(
            future: fetchPost(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              snapshot.data?.length;
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Container(
                          width: double.infinity,
                          height: 560.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black45,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          child: ClipOval(
                                              child: FutureBuilder(
                                            future: fetchUserfromId(
                                                snapshot.data[index].user_id),
                                            builder: (context, snaphotadad) {
                                              return Image(
                                                height: 50.0,
                                                width: 50.0,
                                                image: NetworkImage(
                                                    "http://2.34.202.83:5000/uploads/picture/" +
                                                        snaphotadad
                                                            .data!.picture),
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )),
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data[index].user_id,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle:
                                          Text(snapshot.data[index].created_at),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.more_horiz),
                                        color: Colors.black,
                                        onPressed: () => print('More'),
                                      ),
                                    ),
                                    InkWell(
                                      onDoubleTap: () =>
                                          print('Like PostModels'),
                                      onTap: () {
                                        //Navigator.push(
                                        //  context,
                                        //  MaterialPageRoute(
                                        //    builder: (context) =>
                                        //        ViewPostModelsScreen(
                                        //      PostModels: PostModelss[index],
                                        //    ),
                                        //  ),
                                        //);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(10.0),
                                        width: double.infinity,
                                        height: 400.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black45,
                                              offset: Offset(0, 5),
                                              blurRadius: 8.0,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'http://2.34.202.83:5000/uploads/' +
                                                    snapshot
                                                        .data[index].image[0]),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.favorite_border),
                                                    iconSize: 30.0,
                                                    onPressed: () => print(
                                                        'Like PostModels'),
                                                  ),
                                                  const Text(
                                                    '2,515',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 20.0),
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.chat),
                                                    iconSize: 30.0,
                                                    onPressed: () {
                                                      //Navigator.push(
                                                      //  context,
                                                      //  MaterialPageRoute(
                                                      //    builder: (context) =>
                                                      //        ViewPostModelsScreen(
                                                      //      PostModels: PostModelss[index],
                                                      //    ),
                                                      //  ),
                                                      //);
                                                    },
                                                  ),
                                                  const Text(
                                                    '350',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.bookmark_border),
                                            iconSize: 30.0,
                                            onPressed: () =>
                                                print('Save PostModels'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

//COSTRUTTORE DI POST
  Widget _buildPost(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 560.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage(posts[index].authorImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      posts[index].authorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(posts[index].timeAgo),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),
                  InkWell(
                    onDoubleTap: () => print('Like post'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewPostScreen(
                            post: posts[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 5),
                            blurRadius: 8.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(posts[index].imageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  iconSize: 30.0,
                                  onPressed: () => print('Like post'),
                                ),
                                const Text(
                                  '2,515',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.chat),
                                  iconSize: 30.0,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewPostScreen(
                                          post: posts[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Text(
                                  '350',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          iconSize: 30.0,
                          onPressed: () => print('Save post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
