//
//  TabBarVC.swift
//  E-Commerce
//
//  Created by MohamedBadawi on 14/09/2025.
//

import UIKit

class TabBarVC: UITabBarController {

    let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //since shadows are drawn outside the view’s frame and would be clipped if masksToBounds were true.
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()

        override func viewDidLoad()
        {
            super.viewDidLoad()
            setupTabbar()
            addCustomTabBarView()
            tabbarDesignSetup()
        }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
        customTabBarView.frame = tabBar.frame
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    private func tabbarDesignSetup() {
        UITabBar.appearance().tintColor = UIColor(resource: .orangeF17547)
        tabBar.contentMode = .center
        tabBar.center = view.center
        tabBar.unselectedItemTintColor = .black.withAlphaComponent(0.5)
        tabBar.frame.size.height = CGFloat(70)
        tabBar.frame.origin.y = view.frame.height - CGFloat(70)
        tabBar.isTranslucent = true
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.layer.borderWidth = 0.1
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        
    }
        
    
    // TabBarVC.swift
    private func setupTabbar() {
        
        let home = UINavigationController(rootViewController: HomeVC())
        home.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(named: "home"),
                                       selectedImage: nil)

        let favorite = UINavigationController(rootViewController: FavoriteVC())
        favorite.tabBarItem = UITabBarItem(title: "Favorite",
                                           image: UIImage(named: "favorite"),
                                           selectedImage: nil)

        let cart = UINavigationController(rootViewController: CartVC())
        cart.tabBarItem = UITabBarItem(title: "Cart",
                                       image: UIImage(named: "cart"),
                                       selectedImage: nil)

        let profile = UINavigationController(rootViewController: ProfileVC())
        profile.tabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(named: "profile"),
                                          selectedImage: nil)

        viewControllers = [home, favorite, cart, profile] // comment: assign tabs
    }

    // comment: temporary placeholders so it runs now
    
    
    
    
        
        
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Find and sort UIControl subviews (representing tab bar buttons)
        let tabBarButtonViews = tabBar.subviews
            .filter { $0 is UIControl }
            .sorted { $0.frame.minX < $1.frame.minX }
        // Find the index of the selected item
        guard let index = tabBar.items?.firstIndex(of: item),
              tabBarButtonViews.indices.contains(index) else { return }
        // Find the image view in the selected tab bar button
        let tabBarButton = tabBarButtonViews[index]
        if let imageView = tabBarButton.subviews.compactMap({ $0 as? UIImageView }).first {
            performSpringAnimation(imgView: imageView)
        }
    }

    func performSpringAnimation(imgView: UIImageView) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                imgView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    imgView.transform = CGAffineTransform.identity
                })
            }
        )
    }

    }




extension TabBarVC {
    
    func hideMainTabBar(isHidden:Bool){
        tabBar.isHidden = isHidden
        customTabBarView.isHidden = isHidden
    }
}

