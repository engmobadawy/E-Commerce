//
//  ControllerProvidor.swift


import UIKit

enum StoryboardType:String {
    case Onboarding = "OnboardingSB"
    case home = "HomeSB"
    case cart = "CartSB"
    case profile = "ProfileSB"
    case favorite = "FavoriteSB"
    case mainTabBar = "MainTabBarSB"
 
}
enum VCIdentifier:String {
    case Onboarding = "OnboardingVC"
    case homeNC = "HomeNC"
    case cartNC = "CartNC"
    case profileNC = "ProfileNC"
    case favoriteNC = "FavoriteNC"
    case mainTabBar = "MainTabBarVC"
}


enum TransitionMove {
    case push
    case present
}

class ControllerProvider: NSObject {
    
    public class func viewController<vc: UIViewController>(className: vc.Type, storyboard: StoryboardType) -> vc {
        let target = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let identifier = String(describing: className.self)
        let instantiation = target.instantiateViewController(withIdentifier: identifier) as! vc
        return instantiation
    }
    
    //change rootview
    public class func changeRoot(_ vc:UIViewController) {
        UIView.transition(with: UIWindow.key!, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            UIWindow.key?.rootViewController = vc
        }, completion: nil)
    }
}

extension UINavigationController {
    
    func viewControllersTransition(vc: UIViewController, transitionType: TransitionMove) {
        if transitionType == .push {
            navigationController?.pushViewController(vc, animated: true)
        }else{
            present(vc, animated: true, completion: .none)
        }
    }

    func popBack(_ nb: Int, completion:(()->Void)?) {
        let viewControllers: [UIViewController] = self.viewControllers
        guard viewControllers.count < nb else {
          self.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
          return
        }
      }

   /// pop back to specific viewcontroller
   func popBack<T: UIViewController>(toControllerType: T.Type) {
       var viewControllers: [UIViewController] = self.viewControllers
       viewControllers = viewControllers.reversed()
       for currentViewController in viewControllers {
           if currentViewController .isKind(of: toControllerType) {
               self.popToViewController(currentViewController, animated: true)
               break
           }
       }
   }
}

