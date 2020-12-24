protocol AuthServiceInput {
    func register(login: String,
                  fio: String,
                  password: String,
                  completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)

    func login(login: String,
               password: String,
               completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
}

protocol DataServiceInput {

}
