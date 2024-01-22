part of 'jsonholder_api_bloc.dart';

@immutable
abstract class JsonholderApiEvent {}

class GetDataEvent extends JsonholderApiEvent {
  GetDataEvent(this.endpoint);
  final String endpoint;
}

class GetPostCommentsEvent extends JsonholderApiEvent {
  GetPostCommentsEvent(this.id);
  final int id;
}
