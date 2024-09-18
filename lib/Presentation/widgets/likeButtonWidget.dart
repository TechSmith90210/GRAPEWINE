// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../Data/services/local_helper.dart';
// import '../../models/song.dart';
//
// class LikeButton extends StatefulWidget {
//   final int? songId;
//   final SongModel songModel;
//
//   const LikeButton({
//     super.key,
//     this.songId,
//     required this.songModel,
//   });
//
//   @override
//   _LikeButtonState createState() => _LikeButtonState();
// }
//
// class _LikeButtonState extends State<LikeButton> {
//   bool isLiked = false;
//   late LocalHelper _localHelper;
//
//   @override
//   void initState() {
//     super.initState();
//     _localHelper = Provider.of<LocalHelper>(context, listen: false);
//     _fetchLikeStatus();
//   }
//
//   Future<void> _fetchLikeStatus() async {
//     final likedStatus = await _localHelper.isLiked(widget.songModel.id);
//     if (mounted) {
//       setState(() {
//         isLiked = likedStatus;
//       });
//     }
//   }
//
//   Future<void> _toggleLikeStatus() async {
//     if (isLiked) {
//       await _localHelper.unlikeSong(widget.songModel.id);
//     } else {
//       await _localHelper.likeSong(widget.songModel);
//     }
//     // Update the UI
//     setState(() {
//       isLiked = !isLiked;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         isLiked ? Icons.favorite : Icons.favorite_border,
//         color: isLiked ? Colors.red : Colors.grey,
//       ),
//       onPressed: _toggleLikeStatus,
//     );
//   }
// }
