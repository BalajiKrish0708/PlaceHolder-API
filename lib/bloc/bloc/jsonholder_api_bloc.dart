// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../models/comments.dart';
import '../../models/post_details.dart';

part 'jsonholder_api_event.dart';
part 'jsonholder_api_state.dart';

class JsonholderApiBloc extends Bloc<JsonholderApiEvent, JsonholderApiState> {
  JsonholderApiBloc() : super(JsonholderApiInitial()) {
    on<GetDataEvent>((event, emit) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(NoInternetState());
        return;
      }
      emit(JsonholderApiInitial());
      var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      var response = await client.get(uri);
      //Check for response
      if (response.statusCode == 200) {
        var json = response.body;
        List<PostDetails>? postDetails = postFromJson(json);
        emit(GetDataState(dataList: postDetails));
      } else {
        emit(ErrorState());
      }
    });
    on<GetPostCommentsEvent>((event, emit) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(NoInternetState());
        return;
      }
      emit(JsonholderApiInitial());
      final comments = <Comments>[];
      var response = await client.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/${event.id}/comments'));
      if (response.statusCode == 200) {
        var parsed = json.decode(response.body);

        for (var comment in parsed) {
          var c = Comments.fromMap(comment);
          comments.add(c);
        }
        emit(GetCommentsState(comments: comments));
      } else {
        emit(ErrorState());
      }
    });
  }
  var client = http.Client();
}
