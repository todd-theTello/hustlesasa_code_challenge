/// Lifecycle of a BaseResponse:
/// BaseResponse.loading() retrieving started
/// BaseResponse.loading(localData) retrieving continues, local data
/// BaseResponse.success(remoteData) retrieving successful, remote data
/// BaseResponse.error('msg') retrieving unsuccessful, no data
///
///
///
/// Base Response entity
class BaseResponse<T> {
  /// Use static methods to initialize this class
  const BaseResponse({required this.status, this.data, this.message});

  /// set the base response status
  final bool status;

  /// Network response data from network request
  final T? data;

  /// Network response message
  final String? message;

  /// Return a base response with data on success and set response
  static BaseResponse<T> success<T>(T data) => BaseResponse(
        status: true,
        data: data,
      );

  /// set error when an error occurs
  static BaseResponse<T> errorMessage<T>({required String? message, T? data}) {
    return BaseResponse(status: false, data: data, message: message);
  }

  /// set error when an error occurs
  static BaseResponse<T> error<T>({required String? message, T? data}) {
    return BaseResponse(status: false, data: data, message: message);
  }
}

/// Base Response entity
class BaseResponsePaginated<T> {
  /// Use static methods to initialize this class
  const BaseResponsePaginated({
    required this.status,
    this.data,
    this.message,
    this.currentPage,
    this.lastPage,
  });

  /// set the base response status
  final bool status;

  /// Network response data from network request
  final T? data;

  /// Network response message
  final String? message;

  /// current page number of the paginated data
  final int? currentPage;

  /// last page number of the paginated data
  final int? lastPage;

  /// Return a base response with data on success and set response
  static BaseResponsePaginated<T> success<T>(T data, {int? currentPage, int? lastPage}) {
    return BaseResponsePaginated(
      status: true,
      data: data,
      lastPage: lastPage,
      currentPage: currentPage,
    );
  }

  /// set error when an error occurs
  static BaseResponsePaginated<T> errorMessage<T>({required String? message, T? data}) {
    return BaseResponsePaginated(status: false, data: data, message: message);
  }

  /// set error when an error occurs
  static BaseResponse<T> error<T>({required String? message, T? data}) {
    return BaseResponse(status: false, data: data, message: message);
  }
}
