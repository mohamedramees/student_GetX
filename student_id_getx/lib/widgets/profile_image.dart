import 'dart:io';

import 'package:flutter/material.dart';

class CustomProfileAvatar extends StatelessWidget {
  final Color cirlebackground;
  final Color backgroundColor;
  final String? imagePath;
  final VoidCallback onTapGalleryTap;
  final VoidCallback onCameraTap;
  const CustomProfileAvatar(
      {super.key,
      required this.cirlebackground,
      required this.backgroundColor,
      this.imagePath,
      required this.onCameraTap,
      required this.onTapGalleryTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
              radius: 60,
              backgroundColor: backgroundColor,
              child: ClipOval(
                  child: imagePath != null
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        ), 
                        ),
          InkWell(
            onTap: (){
              showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              icon: const Icon(
                Icons.image_outlined,color: Colors.white,size: 30,),
              title: const Text('Select Image',textAlign: TextAlign.center,),
              actions: [
                InkWell(
                  onTap: (){
                    onTapGalleryTap();
                    Navigator.of(context).pop();
                  },
                  child:const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Gallery'),
                  ),
                ),
                InkWell(
                  onTap: (){
                    onCameraTap();
                    Navigator.of(context).pop();
                  },
                  child:const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text('Camera'),
                  ),
                )
              ],
            ));
            },
            child: CircleAvatar(
              backgroundColor: cirlebackground,
              child:const Icon(
                Icons.add,
                color:  Colors.black
                ),
            ),
          )
        ],
      ),
    );
  }
}
