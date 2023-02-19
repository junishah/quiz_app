import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/localdb.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
    required this.profileUrl,
    required this.name,
    required this.rank,
    required this.money,
    required this.level,
  }) : super(key: key);
  String name;
  String profileUrl;
  String rank;
  String level;
  String money;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> leaderlist;
  getleaders() async {
    await firestore.collection('user').orderBy('money').get().then((value) {
      setState(() {
        leaderlist = value.docs.toList();
        widget.rank = (leaderlist.indexWhere(
                    (element) => element.data()["name"] == widget.name) +
                1)
            .toString();
      });
    });
    await localDb.saveUserRank(widget.rank);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getleaders();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person_add)),
        ],
        title: Text(
          'profile',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0.02,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 330,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.profileUrl),
                        backgroundColor: Colors.black12,
                        radius: 40,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  Text(
                    "${widget.name}\n ${widget.money}",
                    style: TextStyle(
                        fontSize: size.width / 14, color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "#${widget.rank}",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          Text(
                            'RanK',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height / 45,
            ),
            Text(
              "LeaderBoard",
              style: TextStyle(
                  fontSize: size.width / 15, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      leaderlist[index].data()["photourl"]),
                                ),
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                Text(leaderlist[index]
                                            .data()["name"]
                                            .toString()
                                            .length >=
                                        12
                                    ? " ${leaderlist[index].data()["name"].toString().substring(0, 14)}.."
                                    : "${leaderlist[index].data()["name"].toString()}"),
                              ],
                            ),
                            leading: Text(
                              "#${index + 1}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                                "Rs.${leaderlist[index].data()["money"]}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1,
                          );
                        },
                        itemCount: leaderlist.length),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('CHECK POSSITION')))
              ],
            )
          ],
        ),
      ),
    );
  }
}
