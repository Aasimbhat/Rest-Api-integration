import 'package:flutter/material.dart';
import 'package:rest_api/models/post.dart';
import 'package:rest_api/services/remote_services.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts>? posts;
  var isLoaded=false;


   @override
   
   void initState() {
     super.initState();
     getData();
     
   }
  getData()async{
    posts=await RemoteService().getPosts();
    if(posts != null){
      setState(() {
        isLoaded=true;
      });

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts"
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context , index){
            return Container(
              padding: EdgeInsets.all(16),
              child:Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[500]
                    ),
                  ),
                  SizedBox(
                    width: 16 ,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(posts![index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(posts![index].body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                  
                      ],
                    ),
                  ),
                ],
              ) ,
            );
      
          }
          ),
          replacement: const Center(
            child:CircularProgressIndicator()
          ) ,
      ),
    );
  }
}