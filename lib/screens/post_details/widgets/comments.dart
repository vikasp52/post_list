import 'package:benshi/repository/model/comment.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  final List<Comment> commentsList;
  const CommentList({
    Key? key,
    required this.commentsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: commentsList.length,
      itemBuilder: (context, index) {
        Comment comment = commentsList[index];
        return Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(comment.name ?? '')),
                  Text(comment.email ?? ''),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(comment.body ?? ''),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
        );
      },
    );
  }
}
