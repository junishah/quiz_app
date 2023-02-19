import 'package:flutter/material.dart';

class LifeLine extends StatefulWidget {
  const LifeLine({Key? key}) : super(key: key);

  @override
  State<LifeLine> createState() => _LifeLineState();
}

class _LifeLineState extends State<LifeLine> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(

        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                child: Text('Life Line',style: TextStyle(
                  fontSize: 22,fontWeight: FontWeight.bold
                ),)),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purpleAccent,

                        ),
                        child: Icon(Icons.people,size: 30,color: Colors.white, ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Text('Audience \n pool',textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.05 ),)
                  ],
                ),

                Column(
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purpleAccent,

                        ),
                        child: Icon(Icons.people,size: 30,color: Colors.white, ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Text('Audience \n pool',textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.05 ),)
                  ],
                ),

                Column(
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black38,

                        ),
                        child: Icon(Icons.people,size: 30,color: Colors.white, ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Text('Audience \n pool',textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.05 ),)
                  ],
                ),

                Column(
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purpleAccent,

                        ),
                        child: Icon(Icons.people,size: 30,color: Colors.white, ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Text('Audience \n pool',textAlign: TextAlign.center,style: TextStyle(fontSize: size.width*0.05 ),)
                  ],
                ),

              ],
            ),
            SizedBox(height: size.height*0.02,),
            Divider(color: Colors.black38,thickness: 4,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
                child: Text('Life Line',style: TextStyle(
                    fontSize: 22,fontWeight: FontWeight.bold
                ),)),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: 480,
                child: ListView.builder(
                  shrinkWrap: true,

                       reverse: true,
                    itemCount: 9,
                    itemBuilder: (context,index){
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12
                        ),
                        child: ListTile(
                          leading: Text('${index+1}',style: TextStyle(fontSize: 20,color: Colors.grey),),
                          title: Text('Rs ${(5000)*(index+1)}',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                          trailing: Icon(Icons.circle),
                        ),
                      );

                }
                ),
              ),
            )

          ],
        ),

      ),
    );
  }
}
