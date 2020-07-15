class ApiError {
    final int code;
    final String message;
    final dynamic data;

    ApiError({
        this.code,
        this.message,
        this.data
    });
}