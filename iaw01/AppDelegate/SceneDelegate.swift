import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    private var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(scene: scene, connectionOptions: connectionOptions)
    }
    
    private func setupWindow(scene: UIScene, connectionOptions: UIScene.ConnectionOptions? = nil) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
    }
}
