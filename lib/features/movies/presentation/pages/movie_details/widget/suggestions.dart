// import 'package:flutter/material.dart';
//
// class SuggestionsMovieItem extends StatelessWidget {
//   final Movies movie;
//
//   const SuggestionsMovieItem({super.key, required this.movie,});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: context.width * .04, vertical: context.height * .012),
//       alignment: Alignment.topLeft,
//       width: context.width * .33,
//       height: context.height * .1 ,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         image: movie.mediumCoverImage != null
//             ? DecorationImage(
//           image: NetworkImage(movie.mediumCoverImage!),
//           fit: BoxFit.cover,
//         )
//             : null,
//         color: ColorApp.grayColor,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: ColorApp.transparentGray,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: context.width * .02, vertical: context.height * .005),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('${movie.rating ?? 0}', style: TextApp.regular16White),
//             const SizedBox(width: 4),
//             Image.asset(PathImage.star,width: 15,height: 15,)          ],
//         ),
//       ),
//     );
//   }
// }
