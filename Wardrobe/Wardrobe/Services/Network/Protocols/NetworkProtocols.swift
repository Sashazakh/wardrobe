protocol AuthServiceInput {
    func createNewAccount(login: String, password: String)

    func login(login: String, password: String, completion: () -> Void)
}

protocol DataServiceInput {

}
