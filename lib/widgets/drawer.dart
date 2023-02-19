import 'package:flutter/material.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/quizscreens/profile.dart';
import 'package:quiz_app/views/strtupscreens/loginscreen.dart';

import '../services/auth.dart';

class SideNav extends StatelessWidget {
SideNav({Key? key,required this.name,required this.money,
  required this.rank,required this.profileUrl,required this.level}) : super(key: key);
  String name;
  String money;
  String rank;
String level;
  String profileUrl;

  @override
  Widget build(BuildContext context) {
    final Size size =MediaQuery.of(context).size;
    return Drawer(
      child:Material(
       color: Color.fromRGBO(128, 0, 128, 1),
        child: ListView(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    ProfileScreen(profileUrl: profileUrl, name: name, rank: rank, money: money, level: level,)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    child: Row(children: [
                       CircleAvatar(
                        radius: 30,
                        //backgroundColor: Colors.white60,
                        backgroundImage: NetworkImage(profileUrl),
                      ),
                      SizedBox(width: 20,),
                      SizedBox(
                        width: size.width*0.5,
                        child: Column(
                          children: [
                            Text(name,style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 10,),
                            Text("Rs.$money",style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),

                          ],
                        ),
                      )
                    ],),

                  ),

              Container(
                padding: EdgeInsets.only(left: 25),
                child: Text('Leaderboard  ${rank}th rank',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),

              ),
                ],
              ),
            ),
            SizedBox(height: 24,),
            Divider(thickness: 1,color: Colors.white,indent: 10,endIndent: 10,),
            SizedBox(height: 24,),

            ListItem(
              label :" Daily quiz",
              icon: Icons.quiz, context: context, path: MaterialPageRoute(builder: (context)=>Home()),
            ),
            ListItem(
              label :" Leader Board",
              icon: Icons.leaderboard,
              context: context, path: MaterialPageRoute(builder: (context)=>Home()),


            ),
            ListItem(
              label :" How to use",
              icon: Icons.question_answer,
              context: context, path: MaterialPageRoute(builder: (context)=>Home()),
            ),
            ListItem(
              label :" About us",
              icon: Icons.face_retouching_off_rounded,
              context: context, path: MaterialPageRoute(builder: (context)=>Home()),
            ),
            ListItem(
              label :" LogOut",
              icon: Icons.logout,
              context: context, path: MaterialPageRoute(builder: (context)=>LoginScreen()),
            ),
          ],
        ),
      )
    );
  }

  Widget ListItem({required String label,
    required IconData icon,
    required BuildContext context,
     required MaterialPageRoute path })
  {
    final color= Colors.white;
    final hovercolor= Colors.white60;
    return ListTile(
      leading: Icon(icon,color: color,),
      hoverColor: hovercolor,
      title: Text(label,style: TextStyle(
        color: color,
      ),),
      onTap: ()async{
        await signOut();

        Navigator.pushReplacement(context, path);
      },


    );
  }
}
