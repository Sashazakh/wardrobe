protocol AuthServiceInput {
    func createNewAccount(login: String, password: String)

    func login(login: String, password: String)
}

protocol DataServiceInput {

}
