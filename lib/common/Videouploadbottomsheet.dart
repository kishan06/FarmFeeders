// import 'package:farmfeeders/Utils/Videofilepicker.dart';
// import 'package:farmfeeders/Utils/Videopickermethod.dart';
// import 'package:farmfeeders/Utils/sized_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageUploadBottomSheet {
//   showModal(
//     BuildContext context,
//     Function(String) onImagePicked,
//   ) {
//     return 
//      showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30.r),
//           topRight: Radius.circular(30.r),
//         ),
//       ),
//       builder: (context) {
//         return Container(
//           height: 100.h,
//           margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
//           child: Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         if (uploadVideo) {
//                           _onImageButtonPressed(ImageSource.camera);
//                           Get.back();
//                         } else {
//                           getImage(ImageSource.camera);
//                           Get.back();
//                         }
//                         // getImage(ImageSource.camera);
//                         // Get.back();
//                       },
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.camera,
//                             size: 30.sp,
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Text(
//                             'Camera',
//                             style: TextStyle(fontSize: 15.sp),
//                           )
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         if (uploadVideo) {
//                           _onImageButtonPressed(ImageSource.gallery);
//                           Get.back();
//                         } else {
//                           getImage(ImageSource.gallery);
//                           Get.back();
//                         }
//                         // getImage(ImageSource.gallery);
//                         // Get.back();
//                       },
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.image,
//                             size: 30.sp,
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Text(
//                             'Gallery',
//                             style: TextStyle(fontSize: 15.sp),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class VideoUploadBottomSheet {
//   showModal(
//     BuildContext context,
//     Function(XFile) onVideoPicked,
//   ) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       builder: (context) {
//         return Container(
//           height: 100,
//           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         _pickVideo(ImageSource.camera, onVideoPicked);
//                       },
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.videocam,
//                             size: 30,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Record Video',
//                             style: TextStyle(fontSize: 15),
//                           )
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _pickVideo(ImageSource.gallery, onVideoPicked);
//                       },
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.video_library,
//                             size: 30,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Choose from Gallery',
//                             style: TextStyle(fontSize: 15),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _pickVideo(ImageSource source, Function(XFile) onVideoPicked) async {
//     final XFile? pickedVideo = await ImagePicker().pickVideo(source: source);
//     if (pickedVideo != null) {
//       onVideoPicked(pickedVideo);
//       Get.back();
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VideoUploadBottomSheet {
  showModal(
    BuildContext context,
    Function(XFile) onVideoPicked,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 36, vertical: 26),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Video',
                  style: TextStyle(
                    color: const Color(0xff444444),
                    fontSize: 22,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await ImagePicker().pickVideo(
                          source: ImageSource.camera,
                        );
                        if (result != null) {
                          onVideoPicked(XFile(result.path));
                        }
                        Get.back();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xff143C6D),
                            child: Icon(
                              Icons.videocam_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Record Video',
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xff444444),
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 36),
                    GestureDetector(
                      onTap: () async {
                        final result = await ImagePicker().pickVideo(
                          source: ImageSource.gallery,
                        );
                        if (result != null) {
                          onVideoPicked(XFile(result.path));
                        }
                        Get.back();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xff143C6D),
                            child: Icon(
                              Icons.video_collection_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Gallery Video',
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xff444444),
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
