import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);


  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  TextEditingController postEditingController = TextEditingController();


  void addPost()async{

     await FirebaseFirestore.instance.collection('posts').add({
      'text': postEditingController.text,
      'date': DateTime.now().toString,
    });
    postEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').orderBy('date').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  List<DocumentSnapshot> postsData = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: postsData.length,
                        itemBuilder: (context, index){
                          Map<String, dynamic> postData = postsData[index].data() as Map<String, dynamic>;
                          return postCard(postData);
                        }
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              children: [
                Flexible(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      controller: postEditingController,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                      onPressed: (){addPost();},
                      icon: const Icon(Icons.send)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget postCard(Map<String, dynamic> postData){
    return Card(
      child: ListTile(
        title: Text(postData['text']),
      ),
    );
  }
}
