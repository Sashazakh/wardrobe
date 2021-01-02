import UIKit

protocol AuthServiceInput {
    func register(login: String,
                  fio: String,
                  password: String,
                  imageData: Data?,
                  completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)

    func login(login: String,
               password: String,
               completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)

    func isAuthorized(completion: @escaping (Result<Bool, NetworkError>) -> Void)

    func getUserLogin() -> String?

    func getUserName() -> String?

    func getUserImageURL() -> String?

    func dropUser()
}

protocol DataServiceInput {
    func getUserWardrobes(for user: String,
                          completion: @escaping (Result<[WardrobeRaw], NetworkError>) -> Void)

    func getAllLookClothes(with id: Int,
                           completion: @escaping (Result<LookRaw, NetworkError>) -> Void)

    func createLook(wardrobeID: Int,
                    name: String,
                    imageData: Data?,
                    choosedItems: [Int],
                    completion: @escaping (SingleResult<NetworkError>) -> Void)

    func updateLook(lookID: Int,
                    itemIDs: [Int],
                    completion: @escaping (SingleResult<NetworkError>) -> Void)

    func deleteItemFromLook(lookID: Int,
                            itemID: Int,
                            completion: @escaping (SingleResult<NetworkError>) -> Void)

    func getAllItems(for login: String,
                     completion: @escaping (Result<AllItemsRaw, NetworkError>) -> Void)

    func getItem(id: Int,
                 completion: @escaping (Result<EditItemRaw, NetworkError>) -> Void)

    func updateItem(id: Int,
                    name: String?,
                    imageData: Data?,
                    completion: @escaping (SingleResult<NetworkError>) -> Void)

    func changeName(newName: String,
                    completion: @escaping (SingleResult<NetworkError>) -> Void)

    func getUserInvites(completion: @escaping (Result<[InviteRaw], NetworkError>) -> Void)

    func wardrobeResponseInvite(inviteId: Int,
                                response: InviteWardrobeResponse,
                                completion: @escaping (SingleResult<NetworkError>) -> Void)

    func addUserToWardrobe(with login: String,
                           wardobeId: Int,
                           completion: @escaping (SingleResult<NetworkError>) -> Void)

    func getLooks(for wardrobeId: Int,
                  completion: @escaping (Result<[WardrobeDetailLookRaw], NetworkError>) -> Void)
}
