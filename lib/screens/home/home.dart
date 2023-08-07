import 'package:beh_pouyan_test/data/Reopsitory/post_repository.dart';
import 'package:beh_pouyan_test/data/post.dart';
import 'package:beh_pouyan_test/screens/home/bloc/home_bloc.dart';
import 'package:beh_pouyan_test/screens/home/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        final bloc = HomeBloc(postRepository)..add(HomeStarted());
        return bloc;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("BehPouyan Test"),
            centerTitle: true,
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              if (state is HomeSuccess) {
                return StreamBuilder(
                    stream: state.snapshot,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Connecting...")
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Post post =
                              Post.fromJson(snapshot.data!.docs[index].data());
                          return PostCard(
                            post: post,
                          );
                        },
                      );
                    });
              } else if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Text(state.appException.messageError),
                );
              } else {
                throw Exception("State is not valid");
              }
            },
          )),
    );
  }
}
