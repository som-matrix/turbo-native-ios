import WebKit
import Turbo
import Strada

final class SceneController: UIResponder {
    private lazy var session = makeSession()

    private func makeSession() -> Session {
           let webView = WKWebView(frame: .zero,
                                   configuration: .appConfiguration)
           if #available(iOS 16.4, *) {
               webView.isInspectable = true
           }
           
           // Initialize Strada bridge.
           Bridge.initialize(webView)
           
           let session = Session(webView: webView)
           return session
       }
       
}
