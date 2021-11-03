import UIKit
import RealmSwift

struct PhotoGallery {
    let galleryImage: UIImage?
    let description: String?
}

struct FriendsJSON: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendDB]
}

// MARK: - Item
class FriendDB: Object, Codable {
     
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    let photo50: URL
    @objc dynamic var trackCode, firstName: String
    let photo100: URL
    @objc dynamic var deactivated: String?
    
    var fullName: String {
        firstName + " " + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
        case deactivated
    }
}



class Friends {
    let image: UIImage?
    let name: String
    let secondname: String
    let groups: String
    let gallery: [PhotoGallery]?
    
    init(image: UIImage?, name: String, secondname: String, groups: String, gallery: [PhotoGallery]?) {
        self.image = image
        self.name = name
        self.secondname = secondname
        self.groups = groups
        self.gallery = gallery
    }
}

var friendsArray = [
    Friends(image: UIImage(named: "Alena"),
            name: "Алена ",
            secondname: "Харитонова",
            groups: "Cлавянки",
            gallery: [PhotoGallery(galleryImage: UIImage(named: "1"), description: "подружка"), PhotoGallery(galleryImage: UIImage(named: "7"), description: "контент")]),
    Friends(image: UIImage(named: "Elena")!,
            name: "Елена ", secondname: "Филатова",
            groups: "Спортсменки", gallery: [PhotoGallery(galleryImage: UIImage(named: "2"), description: "я"), PhotoGallery(galleryImage: UIImage(named: "7"), description: "киса")]),
    Friends(image: UIImage(named: "Maria"),
            name: "Мария ", secondname: "Кичук",
            groups: "Отличницы",
            gallery: [PhotoGallery(galleryImage: UIImage(named: "3"), description: "типа я"), PhotoGallery(galleryImage: UIImage(named: "4"), description: "с подружкой")]),
    Friends(image: UIImage(named: "Natalia"),
            name: "Наталья ",
            secondname: "Харитонова",
            groups: "Cлавянки",
            gallery: [PhotoGallery(galleryImage: UIImage(named: "5"), description: "сестричка"), PhotoGallery(galleryImage: UIImage(named: "6"), description: "я опять"), PhotoGallery(galleryImage: UIImage(named: "8"), description: "просто аниме баба для контента"), PhotoGallery(galleryImage: UIImage(named: "9"), description: "тоже аниме баба для контента")])
    ]

extension Friends: Equatable {
    static func == (lhs: Friends, rhs: Friends) -> Bool {
        lhs.name == rhs.name && lhs.groups == rhs.groups
    }
    
}

