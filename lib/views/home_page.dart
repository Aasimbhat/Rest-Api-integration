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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          "Posts Fetched",
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 28
          ),
        ),
        

      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context , index){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                
                height: 130,
                width: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[700],
                ),
                padding: EdgeInsets.all(16),
                child:Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[500],
                        image: DecorationImage(
                          image: AssetImage(
                            "asset/img2.jpg"
                            
                          ))
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
              ),
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