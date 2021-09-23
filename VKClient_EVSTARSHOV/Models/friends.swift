import UIKit

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
            secondname: "Харитонова ",
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
//var friendsArray = [
//    Friends(image: UIImage(named: "Алена")!, name: "Алена ", secondname: "Харитонова ", groups: "Cлавянки"),
//    Friends(image: UIImage(named: "Елена")!, name: "Елена ", secondname: "Филатова", groups: "Спортсменки"),
//    Friends(image: UIImage(named: "Мария")!, name: "Мария ", secondname: "Кичук", groups: "Отличницы"),
//    Friends(image: UIImage(named: "Наталья")!, name: "Наталья ", secondname: "Харитонова", groups: "Cлавянки")
//    ]
//


extension Friends: Equatable {
    static func == (lhs: Friends, rhs: Friends) -> Bool {
        lhs.name == rhs.name && lhs.groups == rhs.groups
    }
    
}

//let galleryArray: [PhotoGallery] = [
//
//    PhotoGallery(galleryImage: UIImage(named: "1"), description: "подружка"),
//    PhotoGallery(galleryImage: UIImage(named: "2"), description: "с подружкой"),
//    PhotoGallery(galleryImage: UIImage(named: "3"), description: "сестричка"),
//    PhotoGallery(galleryImage: UIImage(named: "4"), description: "киса"),
//    PhotoGallery(galleryImage: UIImage(named: "5"), description: "я"),
//    PhotoGallery(galleryImage: UIImage(named: "6"), description: "просто кошкодевочка"),
//    PhotoGallery(galleryImage: UIImage(named: "7"), description: "просто надо что то для контента"),
//
//
//]





//let imagecollectionArray:[UIImage] = [
//    UIImage(named: "1")!,
//    UIImage(named: "2")!,
//    UIImage(named: "3")!,
//    UIImage(named: "4")!,
//    UIImage(named: "5")!,
//    UIImage(named: "6")!,
//    UIImage(named: "7")!,
//]
