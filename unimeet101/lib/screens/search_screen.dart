import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unimeet101/screens/profile_screen.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 26),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.search,
                  color: activeColor,
                ),
              ),
              //labelText: 'Search for a user',
              hintText: 'username',
            ),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
        body: MediaQuery.of(context).size.width < webScreenSize
            ? isShowUsers
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('username',
                            isGreaterThanOrEqualTo: searchController.text)
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                          }
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  uid: (snapshot.data! as dynamic).docs[index]
                                      ['uid'],
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['photoUrl']),
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('posts').get(),
                    builder: (builder, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) => Image.network(
                              (snapshot.data! as dynamic).docs[index]
                                  ['postUrl']),
                          staggeredTileBuilder: (index) => width > webScreenSize
                              ? StaggeredTile.count(
                                  (index % 7 == 0) ? 1 : 1,
                                  (index % 7 == 0) ? 1 : 1,
                                )
                              : StaggeredTile.count(
                                  (index % 7 == 0) ? 2 : 1,
                                  (index % 7 == 0) ? 2 : 1,
                                ),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                      );
                    },
                  )
            : isShowUsers
                ? Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 600,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .where('username',
                                isGreaterThanOrEqualTo: searchController.text)
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ListView.builder(
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                              }
                              return InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      uid: (snapshot.data! as dynamic)
                                          .docs[index]['uid'],
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        (snapshot.data! as dynamic).docs[index]
                                            ['photoUrl']),
                                  ),
                                  title: Text(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['username'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 800,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .get(),
                        builder: (builder, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 3,
                              itemCount:
                                  (snapshot.data! as dynamic).docs.length,
                              itemBuilder: (context, index) => Image.network(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['postUrl']),
                              staggeredTileBuilder: (index) =>
                                  width > webScreenSize
                                      ? StaggeredTile.count(
                                          (index % 7 == 0) ? 1 : 1,
                                          (index % 7 == 0) ? 1 : 1,
                                        )
                                      : StaggeredTile.count(
                                          (index % 7 == 0) ? 2 : 1,
                                          (index % 7 == 0) ? 2 : 1,
                                        ),
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
      ),
    );
  }
}
