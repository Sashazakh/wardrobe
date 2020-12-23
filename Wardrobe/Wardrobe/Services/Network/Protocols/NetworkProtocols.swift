protocol AuthServiceInput {
    func createNewAccount(login: String, password: String)

    func login(login: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void)
}

protocol DataServiceInput {

}
