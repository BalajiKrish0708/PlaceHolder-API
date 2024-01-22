import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/jsonholder_api_bloc.dart';
import '../models/post_details.dart';
import 'post_details.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key, required this.title});

  final String title;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  bool isLoading = false;
  List<PostDetails>? postsList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JsonholderApiBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: BlocBuilder<JsonholderApiBloc, JsonholderApiState>(
          buildWhen: (previous, current) {
            return _getPostStates(current, context);
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (isLoading && postsList == null) _getLoadingStatus(),
                if (!isLoading && postsList != null && postsList!.isNotEmpty)
                  _getPostsListView(),
                if (!isLoading && postsList == null)
                  _getFetchDataButton(context),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _getPostStates(JsonholderApiState current, BuildContext context) {
    if (current is JsonholderApiInitial) {
      isLoading = true;
      return true;
    }
    if (current is NoInternetState) {
      isLoading = false;
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('No internet connection'),
                ),
              ));
      return true;
    }
    if (current is ErrorState) {
      isLoading = false;
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Error loading data. Please try again later.'),
                ),
              ));
      return true;
    }
    if (current is GetDataState) {
      isLoading = false;
      postsList = current.dataList;
      return true;
    }
    return false;
  }

  Expanded _getPostsListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: postsList!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailsPage(
                    userId: postsList![index].id,
                    title: postsList![index].title,
                    content: postsList![index].body,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  child: Center(child: Text('${index + 1}')),
                ),
                title: Text(postsList![index].title),
                subtitle: Text(postsList![index].body),
              ),
            ),
          );
        },
      ),
    );
  }

  Center _getFetchDataButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Action to be performed when the button is pressed
          context.read<JsonholderApiBloc>().add(GetDataEvent(''));
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(10.0),
          // You can customize more properties here
        ),
        child: const Text(
          'Press to Fetch Posts Data',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Center _getLoadingStatus() {
    return const Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Fetching Data...',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
