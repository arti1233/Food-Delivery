import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navTabBarController = TabBarController()
        let builder = ModuleBuilder()
        let router = Router(navigationTabBarController: navTabBarController, builder: builder)
        router.initialViewControllers()
        guard let window else { return }
        window.rootViewController = navTabBarController
        window.makeKeyAndVisible()
    }
}

