import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonholder_api/bloc/bloc/jsonholder_api_bloc.dart';
import 'package:jsonholder_api/models/comments.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({super.key, this.userId, this.title, this.content});

  final int? userId;
  final String? title;
  final String? content;

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  bool isLoading = false;
  List<Comments>? commentsList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          JsonholderApiBloc()..add(GetPostCommentsEvent(widget.userId!)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Details'),
        ),
        body: BlocBuilder<JsonholderApiBloc, JsonholderApiState>(
            buildWhen: (previous, current) {
          return _getPostsDetailsStates(current, context);
        }, builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading && commentsList == null) _getLoadingStatus(),
              if (!isLoading &&
                  commentsList != null &&
                  commentsList!.isNotEmpty)
                _getPostDetailsCard(),
              if (!isLoading &&
                  commentsList != null &&
                  commentsList!.isNotEmpty)
                _getCommentsText(),
              if (!isLoading &&
                  commentsList != null &&
                  commentsList!.isNotEmpty)
                _getCommentsList()
            ],
          );
        }),
      ),
    );
  }

  Card _getPostDetailsCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Id : ${widget.userId}'),
          const SizedBox(
            height: 10,
          ),
          Text('Title : ${widget.title}'),
          const SizedBox(
            height: 10,
          ),
          Text('Content : ${widget.content}')
        ]),
      ),
    );
  }

  Align _getCommentsText() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 5, left: 20),
        child: Text(
          'Comments',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  Expanded _getCommentsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: commentsList!.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(commentsList![index].body),
            ),
          );
        },
      ),
    );
  }

  bool _getPostsDetailsStates(
      JsonholderApiState current, BuildContext context) {
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
    if (current is GetCommentsState) {
      commentsList = current.comments;
      isLoading = false;
      return true;
    }

    return false;
  }

  Widget _getLoadingStatus() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
