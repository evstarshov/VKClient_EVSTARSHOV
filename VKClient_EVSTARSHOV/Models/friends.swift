import UIKit
import RealmSwift
import Alamofire

protocol DBProtocol {
    //CRUD - create, read, update, delete
    
    func create(_ friends: [FriendModel])
    func read() -> [FriendModel]
    func delete(_ friends: [FriendModel])
    func update(_ friends: [FriendModel])
}

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

class FriendDB: DBProtocol {
    
    let migration = Realm.Configuration(schemaVersion: 6) //миграция работает как на расширение так и на уделение
    lazy var mainRealm = try! Realm(configuration: migration)
    
    func create(_ friends: [FriendModel]) {
        mainRealm.beginWrite()
        do {
            mainRealm.add(friends) //добавляем объект в хранилище
            try mainRealm.commitWrite()
            print(mainRealm.configuration.fileURL ?? "")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [FriendModel] {
        
        let friends = mainRealm.objects(FriendModel.self)
        friends.forEach { print($0.lastName) }
        print(mainRealm.configuration.fileURL ?? "")
        return Array(friends) //враппим Result<> в Array<>
    }
    
    func delete(_ friends: [FriendModel]) {
        do {
            mainRealm.beginWrite()
            mainRealm.delete(friends)
            try mainRealm.commitWrite()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(_ friends: [FriendModel]) {
        do {
            let oldFriends =  mainRealm.objects(FriendModel.self).filter("id == %@", friends)
            mainRealm.beginWrite()
            mainRealm.delete(oldFriends)
            mainRealm.add(friends)
            try mainRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
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

