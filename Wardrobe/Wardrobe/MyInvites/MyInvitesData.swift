import Foundation

struct MyInvitesData {
    let id: Int
    let login: String
    let name: String
    let imageUrl: String?

    init(with inviteRaw: InviteRaw) {
        self.id = inviteRaw.wardrobeIdInvite
        self.login = inviteRaw.login
        self.name = inviteRaw.wardrobeName
        self.imageUrl = inviteRaw.imageUrl
    }
}
