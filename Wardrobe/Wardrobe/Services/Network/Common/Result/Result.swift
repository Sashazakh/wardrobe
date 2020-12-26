struct Result<DataType, ErrorType> {
    var data: DataType?
    var error: ErrorType?
}

struct SingleResult<ErrorType> {
    var error: ErrorType?
}
