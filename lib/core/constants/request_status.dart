enum RequestStatus {
  pending('pending'),
  accepted('accepted'),
  rejected('rejected');

  const RequestStatus(this.request);
  final String request;
}
