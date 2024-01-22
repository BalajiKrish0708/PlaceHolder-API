part of 'jsonholder_api_bloc.dart';

@immutable
abstract class JsonholderApiState {}

final class JsonholderApiInitial extends JsonholderApiState {}

class GetDataState extends JsonholderApiState {
  GetDataState({this.dataList});
  final List<PostDetails>? dataList;
}

class GetCommentsState extends JsonholderApiState {
  GetCommentsState({this.comments});
  final List<Comments>? comments;
}

final class NoInternetState extends JsonholderApiState {}

final class ErrorState extends JsonholderApiState {}
