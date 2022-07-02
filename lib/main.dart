import 'package:benshi/repository/post_repository.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:benshi/screens/posts/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benshi ai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PostCubit>(
        create: (context) => PostCubit(PostRepossitory()),
        child: const PostList(),
      ),
    );
  }
}
