//
//  AvatarFullScreenViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.09.2021.
//

import UIKit

class AvatarFullScreenViewController: UIViewController {
    @IBOutlet var slider: UIView!
    @IBOutlet var fullScreen: UIImageView!
    private var selectedImage: [PhotoGallery] = []
    private var indexN: Int = 0
    
  // ------ Загрузка изображения, конфигурирование UIImageView
    
    
    func avatarFull(fullimage: [PhotoGallery], selectIndex: Int) {
        self.selectedImage = fullimage
        self.indexN = selectIndex
    }
    
    private func presentImage() {
        fullScreen.image = selectedImage[indexN].galleryImage
        
    }
 // ------   viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentImage()
        
        let panGR = UIPanGestureRecognizer(
            target: self,
            action: #selector(swipePan(_:)))
        fullScreen?.isUserInteractionEnabled = true
        fullScreen?.addGestureRecognizer(panGR)
}
    
// -------- Свайп вниз для возрата на предыдущий экран
    
    private var propertyAnimator: UIViewPropertyAnimator?
     

     @objc
     private func swipePan(_ gesture: UIPanGestureRecognizer) {
         let translation = gesture.translation(in: slider)
         switch gesture.state {
         case .began:
             propertyAnimator = UIViewPropertyAnimator(
                 duration: 2,
                 curve: .easeInOut,
                 animations: {
                     self.fullScreen?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                     self.fullScreen?.alpha = 0.8
                 }
             )
             propertyAnimator?.pauseAnimation()
         case .changed:
             propertyAnimator?.fractionComplete = abs(translation.x / 100)
         case .ended:
             propertyAnimator?.stopAnimation(true)
             propertyAnimator?.finishAnimation(at: .current)

             fullScreen?.transform = CGAffineTransform(scaleX: 1, y: 1)
             fullScreen?.alpha = 1

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
    
         switch direction {
         case .left:
             print("Swiped left, doing nothing")
         case .right:
         print("swiped right, doing nothing")
         case .down:
             print("Swiped Down, presenting AvatarVC")
             
                 // ----- Переход на экран слайдера
             
                         let avatarVC = UIStoryboard(
                             name: "Main",
                             bundle: nil)
                             .instantiateViewController(withIdentifier: "AvatarVievControllerID") as! AvatarVievController
             avatarVC.setImage(images: selectedImage, indexAt: indexN)
             show(avatarVC, sender: nil)

             
         case .up:
             print("Swiped UP, do nothing")
         }
     }
}
