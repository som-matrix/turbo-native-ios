import UIKit
import Turbo

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private lazy var navigationController = UINavigationController()
    private lazy var session: Session = {
        let session = Session()
        session.delegate = self
        return session
    }()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        visit()
    }
    
    private func visit() {
        let url = URL(string: "http://localhost:3002")!
        let controller = VisitableViewController(url: url)
        session.visit(controller, action: .advance)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension SceneDelegate: SessionDelegate {
    
    func session(_ session: Session, didProposeVisit proposal: VisitProposal) {
        let controller = VisitableViewController(url: proposal.url)
        session.visit(controller, options: proposal.options)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, error: Error) {
        //TODO: Handle Errors
    }

    
    func sessionWebViewProcessDidTerminate(_ session: Session) {
        //TODO: Handle dead web view
    }
    
    
}

