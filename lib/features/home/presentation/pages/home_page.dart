
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/features/home/presentation/components/my_drawer.dart';
import 'package:social_app/features/post/presentation/components/post_tile.dart';
import 'package:social_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_app/features/post/presentation/cubits/post_states.dart';
import 'package:social_app/features/post/presentation/pages/upload_post_page.dart';
import 'package:social_app/responsive/constrained_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // post cubit
  late final postCubit = context.read<PostCubit>();

  // on start up
  @override
  void initState() {
    super.initState();

    // fetch all posts
    fetchAllPosts();
  }

  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPosts();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    // Scaffold
    return ConstrainedScaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          // upload new post button
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadPostPage(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
        // actions: [
        //   // logout button
        //   IconButton(
        //     onPressed: () {
        //       context.read<AuthCubit>().logout();
        //     },
        //     icon: const Icon(
        //       Icons.logout,
        //     ),
        //   ),
        // ],
      ),
      // Drawer
      drawer: const MyDrawer(),
      // BODY
      body: BlocBuilder<PostCubit, PostStates>(
        builder: (context, state) {
          // loading
          if (state is PostsLoading && state is PostUploading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // loaded
          else if (state is PostsLoaded) {
            final allPosts = state.posts;

            if (allPosts.isEmpty) {
              return const Center(
                child: Text("No post available"),
              );
            }
            return ListView.builder(
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                // get individual post
                final post = allPosts[index];

                // image
                return PostTile(post: post,onDeletePressed: () => deletePost(post.id),);
              },
            );
          }
          // error
          else if (state is PostsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
