import Foundation

struct MyInvitesData {
    let id: Int
    let login: String
    let name: String
    let imageUrl: String?

    init(with inviteRaw: InviteRaw) {
        self.id = inviteRaw.inviteId
        self.login = inviteRaw.login
        self.name = inviteRaw.wardrobeName
        if let imageUrl = inviteRaw.imageUrl {
            self.imageUrl = imageUrl + "&apikey=" + DataService.shared.getApiKey()
        } else {
            imageUrl = nil
        }
    }
}
