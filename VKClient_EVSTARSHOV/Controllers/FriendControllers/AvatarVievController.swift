

import UIKit

enum SwipeDirection {
    case left
    case right
    case down
    case up
}

class AvatarVievController: UIViewController {
    
    @IBOutlet var sliderArea: UIView!
    @IBOutlet var sliderIndicator: UIStackView!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var avatarLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeLabel: UILabel!
    private var indicatorImages = [UIImageView]()
    var likes = 0
    private var friend: Friends?
    private var imagesArray: [PhotoGallery] = []
    private var currentIndex: Int = 0 {
        didSet {
            changeimageLabel()
            changeSliderIndicator()
        }
    }
    
    
    //private var imageLabel: UILabel?

    //------------ Конфигурирование UIImage, UILabel
    
    
    func setImage(images: [PhotoGallery], indexAt: Int) {
        self.imagesArray = images
        self.setSliderIndicator()
        self.currentIndex = indexAt
    }
    
    private func presentDefaultImage() {
        avatarImage?.image = imagesArray[currentIndex].galleryImage
        changeimageLabel()
    }
    
    private func changeimageLabel() {
        avatarLabel?.text = imagesArray[currentIndex].description
    }

    //--------- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentDefaultImage()
        indicatorViewConfig()
        changeimageLabel()
        
        let panGR = UIPanGestureRecognizer(
            target: self,
            action: #selector(swipePan(_:)))
        avatarImage?.isUserInteractionEnabled = true
        avatarImage?.addGestureRecognizer(panGR)
    }
    
   // ------ индикатор слайдов
    
    private func setSliderIndicator() {
        for _ in imagesArray.enumerated() {
            let indicatorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
            indicatorImageView.image = UIImage(systemName: "circle.fill")
            indicatorImageView.tintColor = UIColor.systemBlue
            indicatorImages.append(indicatorImageView)
        }
    }
    
    private func indicatorViewConfig() {
        for item in indicatorImages {
            sliderIndicator.addArrangedSubview(item)
        }
    }
    
    private func changeSliderIndicator() {
        for item in indicatorImages {
            item.tintColor = UIColor.systemBlue
        }
        indicatorImages[currentIndex].tintColor = UIColor.red
    }
    
    private func imageViewConfig() {
        avatarImage = UIImageView(frame: sliderArea.bounds)
        avatarImage?.contentMode = .scaleAspectFill
        avatarImage?.isUserInteractionEnabled = true
       
        guard let imageView = avatarImage
        else { return }
        
        sliderArea.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = imageView.topAnchor.constraint(equalTo: sliderArea.topAnchor)
        let leadingConstraint = imageView.leadingAnchor.constraint(equalTo: sliderArea.leadingAnchor)
        let trailingConstraint = imageView.trailingAnchor.constraint(equalTo: sliderArea.trailingAnchor)
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: sliderArea.bottomAnchor)
        sliderArea.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
    
    private func imageLabelViewConfig() {
        avatarLabel = UILabel()
        avatarLabel?.adjustsFontSizeToFitWidth = true
        avatarLabel?.backgroundColor = UIColor.lightGray
        avatarLabel?.alpha = 0.8
        avatarImage?.addSubview(avatarLabel ?? UILabel())
        avatarLabel?.translatesAutoresizingMaskIntoConstraints = false

        guard let imageLabel = avatarLabel,
              let imageView = avatarImage
        else { return }
        
        NSLayoutConstraint.activate([
            imageLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageLabel.heightAnchor.constraint(equalToConstant: 50),
            imageLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }


    // ------- Кнопка лайк
    
    @IBAction func likePressed(_ sender: Any) {
        if likeButton?.isSelected == false {
        print("Liked")

        likeButton.isSelected = true
        likes += 1
        likeLabel.text = String(likes)
        likeButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 1.6,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.2,
                           options: .curveEaseOut,
                           animations: {
                               self.likeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                           },
                           completion: nil)
        likeButton.setImage(UIImage(named: "heartfill"), for: .selected)
        } else {
            print("Disliked")
            likeButton.isSelected = false
            likes -= 1
            likeLabel.text = String(likes)
        }
        
    }
    
    

    // --------- Блок анимаций перелистывания
    
    
   private var propertyAnimator: UIViewPropertyAnimator?
    

    @objc
    private func swipePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: sliderArea)
        switch gesture.state {
        case .began:
            propertyAnimator = UIViewPropertyAnimator(
                duration: 2,
                curve: .easeInOut,
                animations: {
                    self.avatarImage?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.avatarImage?.alpha = 0.8
                }
            )
            propertyAnimator?.pauseAnimation()
        case .changed:
            propertyAnimator?.fractionComplete = abs(translation.x / 100)
        case .ended:
            propertyAnimator?.stopAnimation(true)
            propertyAnimator?.finishAnimation(at: .current)

            avatarImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
            avatarImage?.alpha = 1

            if abs(translation.x) > 50 {
                changeSlide(direction: translation.x > 0 ? SwipeDirection.left : SwipeDirection.right)
            }
            else if abs(translation.y) > 50 {
                changeSlide(direction: translation.y > 0 ? SwipeDirection.down : SwipeDirection.up)
            }
            
        default:
            return
        }
    }

    private func changeSlide(direction: SwipeDirection) {
        var imageDirectionOffest: CGFloat = 1000
        var showImage = false

        switch direction {
        case .left:
            if currentIndex > 0 {
                currentIndex -= 1
                showImage = true
            }
            imageDirectionOffest *= -1
        case .right:
            if imagesArray.count - 1 > currentIndex {
                currentIndex += 1
                showImage = true
            }
        case .down:
            print("Swiped Down, presenting FriendsCollectionVC")
                        let friendCollection = UIStoryboard(
                            name: "Main",
                            bundle: nil)
                            .instantiateViewController(withIdentifier: "friendTable")
                        //friendCollection.transitioningDelegate = AvatarVievController
                        present(friendCollection, animated: true)
            friendCollection.modalTransitionStyle = .coverVertical
            
        case .up:
            print("Swiped UP, presenting FriendsTableVC")
//            let friendCollection = UIStoryboard(
//                name: "Main",
//                bundle: nil)
//                .instantiateViewController(withIdentifier: "friendTable")
//            //friendCollection.transitioningDelegate = AvatarVievController
//            present(friendCollection, animated: true)
        
        }

        if showImage {
            avatarImage?.image = imagesArray[currentIndex].galleryImage
            // Hide off the screen
            avatarImage?.center.x += imageDirectionOffest
            sliderArea.addSubview(avatarImage ?? UIImageView())
            
            UIView.animate(
                withDuration: 0.6,
                delay: 0.0,
                options: [.curveLinear, .transitionCrossDissolve]
            ) {
                self.avatarImage?.center.x += (imageDirectionOffest * -1)
            }
        }
    }
    
    // ------ Переход на экран с полноразмерной фото
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            guard let selectedImage = segue.destination as? AvatarVievController
//            else {return}
//            let indexPath = sender as! IndexPath
//        let selectedIndex = currentIndex
//        selectedImage.setImage(images: avatarImage, indexAt: currentIndex)
//        }
//
//    }

}
