import UIKit

var greeting = "Hello, playground"

struct Friends {
    let image: UIImage?
    let name: String
    let secondname: String
    let groups: String
}

var friendsArray = [
    Friends(image: UIImage(named: "Алена"), name: "Алена ", secondname: "Харитонова ", groups: "Cлавянки"),
    Friends(image: UIImage(named: "Елена"), name: "Елена ", secondname: "Филатова", groups: "Спортсменки"),
    Friends(image: UIImage(named: "Мария"), name: "Мария ", secondname: "Кичук", groups: "Отличницы")
    ]

var sortedByletter = friendsArray.sorted(by: {$0.secondname < $1.secondname})

print(sortedByletter)
