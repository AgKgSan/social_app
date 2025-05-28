import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/profile/presentation/components/user_tile.dart';
import 'package:social_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_app/responsive/constrained_scaffold.dart';

class FollowerPage extends StatelessWidget {
  final List<String> followers;
  final List<String> following;
  const FollowerPage({
    super.key,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ConstrainedScaffold(
        appBar: AppBar(
          bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.inversePrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              tabs: [
                Tab(text: "Followers"),
                Tab(text: "Following"),
              ]),
        ),
        body: TabBarView(children: [
          _builtUserList(followers, "No followers", context),
          _builtUserList(following, "No following", context),
        ]),
      ),
    );
  }

  // build user list

  Widget _builtUserList(
      List<String> uids, String emptyMessage, BuildContext context) {
    return uids.isEmpty
        ? Center(child: Text(emptyMessage))
        : ListView.builder(
            itemCount: uids.length,
            itemBuilder: (context, index) {
              // get each uid
              final uid = uids[index];

              return FutureBuilder(
                future: context.read<ProfileCubit>().getUserProfile(uid),
                builder: (context, snapshot) {
                  // loaded
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return ListTile(
                      title: UserTile(user: user),
                    );
                  }

                  // loading
                  else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const ListTile(
                      title: Text("Loading..."),
                    );
                  }

                  // not found...
                  else {
                    return const ListTile(
                      title: Text("User Not Found..."),
                    );
                  }
                },
              );
            },
          );
  }
}
