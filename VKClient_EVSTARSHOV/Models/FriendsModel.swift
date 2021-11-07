import UIKit
import RealmSwift
import Alamofire


struct FriendsJSON: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendModel]
}

// MARK: - Item
class FriendModel: Object, Codable {
     
    let friend = FriendsAPI()
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var photo100: String = ""
    
    var fullName: String {
        firstName + " " + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
    
    let baseURL = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let version = "5.81"
}

final class FriendDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }
    
    func save(_ items: [FriendModel]) {
        let realm = try! Realm()
        
        do {
            try! realm.write {
                realm.add(items)
            }
        }
    }
    
    func load() -> Results<FriendModel> {
        
        let realm = try! Realm()
        
        let friends: Results<FriendModel> = realm.objects(FriendModel.self)
        
        return friends
        
    }
    
    func delete(_ items: FriendModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(items)
        }
    }
}

// Тестовые данные



struct PhotoGallery {
    let galleryImage: UIImage?
    let description: String?
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

