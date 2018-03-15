//
//  WebController.swift
//  eletmodvaltok
//
//  Created by Imre Ujlaki on 2017. 05. 08..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit
import WebKit
class WebController : UIViewController, WKUIDelegate, WKNavigationDelegate, PageControllerDelegate {
    
    var contentWebView: WKWebView!
    var rootURL: URL? = URL(string: "http://ok.com")
    private var visitedURLs: [String] = []
    var unloadedURL: Int = 0
    var pages: [String: [Page]] = [String: [Page]] ()
    var staticContent: Bool = false
    var favourites: [Page] = []
    static let htmlStyle =  "<style>html, body{padding:10px;font-size:28px;font-family: \"HelveticaNeue-Light\", \"Helvetica Neue Light\", \"Helvetica Neue\"!important}</style>"
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(goBack), name: Constants.Notifications.GoBackNotification, object: nil)
        self.loadPage()
        self.addSearchNavigationItem()
    }
    
    private func initializeWKWebView(){
        guard let path = Bundle.main.path(forResource: "styles", ofType: "css") else { return }
        let cssString = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
        let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        let config = WKWebViewConfiguration()
        let script = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        self.contentWebView = WKWebView(frame: self.view.bounds, configuration: config)
        self.contentWebView.uiDelegate = self
        self.contentWebView.navigationDelegate = self
        self.view.addSubview(self.contentWebView)
    }
    
    private func loadPage() {
        if (self.contentWebView == nil){
            self.initializeWKWebView()
        }
        if unloadedURL == 0 {
            self.contentWebView.load(URLRequest(url: self.rootURL!))
        } else {
            self.checkContent()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame != nil && (navigationAction.targetFrame?.isMainFrame)! {
            if (navigationAction.request.url?.absoluteString.contains("eletmodvaltok.com"))!{
                if (navigationAction.request.url?.absoluteString.contains("regisztracio"))! {
                    decisionHandler(.cancel)
                    if DataStore.shared.userData == nil {
                        NotificationCenter.default.post(name: Constants.Notifications.ShowRegistrationNotification, object: nil)
                    }
                    return
                } else if (navigationAction.request.url?.absoluteString.contains("belepes"))! {
                    decisionHandler(.cancel)
                    if DataStore.shared.userData == nil {
                        NotificationCenter.default.post(name: Constants.Notifications.ShowLoginNotification, object: nil)
                    }
                    return
                }
                if navigationAction.request.url?.absoluteString != visitedURLs.last {
                    visitedURLs.append((navigationAction.request.url?.absoluteString)!)
                }
            } else if (navigationAction.request.url?.absoluteString.contains("hazipatika.com"))! {
                //UIApplication.shared.openURL(navigationAction.request.url!)
                decisionHandler(.cancel)
                return
            } else {
                decisionHandler(.cancel)
                return
            }
        }
        if (navigationAction.request.url != nil && navigationAction.request.url!.absoluteString.contains("#favourite/")) {
            if let postId = navigationAction.request.url?.absoluteString.components(separatedBy: "/").last {
                RestClient.favouritePost(postId: postId, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (success: Bool?) in
                    MessageUtils.show(message: "Receipt.Favourited".localized, on: self)
                })
            }
            decisionHandler(.cancel)
            return
        } else if (navigationAction.request.url != nil && navigationAction.request.url!.absoluteString.contains("#unfavourite/")) {
            if let postId = navigationAction.request.url?.absoluteString.components(separatedBy: "/").last {
                RestClient.unFavouritePost(postId: postId, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (success: Bool?) in
                    print(success!)
                    self.favourites = self.favourites.filter{$0.id != postId}
                    self.loadFavourites(self.favourites)
                    MessageUtils.show(message: "Receipt.UnFavourited".localized, on: self)
                })
            }
            decisionHandler(.cancel)
            return
        }
        if ( navigationAction.targetFrame == nil ){
            if let url = navigationAction.request.url {
                UIApplication.shared.openURL(url)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
        if self.staticContent == false {
            if self.contentWebView.canGoBack {
                self.addBackNavigationItem()
            } else {
                self.addMenuNavigationItem()
            }
        }
    }
    
    func goBack() {
        self.contentWebView.goBack()
    }
    
    func insertContentsOfCSSFile(into webView: WKWebView) {
        
        
    }
    
    func pagesLoaded(pages: [Page], programId: String) {
        self.unloadedURL -= 1
        self.pages[programId] = pages
        self.checkContent()
    }
    
    func checkContent() {
        if self.unloadedURL == 0 {
            var html = WebController.htmlStyle
            var orderedContent: [String: String] = [String: String]()
            for (programId, pages) in self.pages {
                let program: Program = DataStore.shared.programs!.filter {$0.id == programId}.first!
                var htmlString = ""
                pages.forEach({ (page: Page) in
                    htmlString += "<div class='appcontent'>"
                    htmlString += page.content
                    htmlString += "</div>"
                    if page.name.contains("recept") {
                        htmlString += "<div class='bg-red favourite-block text-center'><h1><a href='#favourite/"+(page.id ?? ""    )+"' class='btn bg-red add-to-favorites'><i class='fa fa-star' aria-hidden='true'></i> <span>Kedvencekhez adom</span></a></h1></div></div>"
                    }
                })
                orderedContent[program.position] = htmlString
            }
            for i in 0...10 {
                if let content = orderedContent["\(i)"] {
                    html += content
                }
            }
            if self.contentWebView != nil {
                self.contentWebView.loadHTMLString(html, baseURL: self.rootURL!)
            }
        }
    }
    
    func loadFavourites(_ favourites: [Page]) {
        self.favourites = favourites
        var htmlString = WebController.htmlStyle
        favourites.forEach({ (page: Page) in
            htmlString += "<div class='appcontent'>"
            htmlString += page.content
            htmlString += "</div>"
            if page.name.contains("recept") {
                htmlString += "<div class='bg-red favourite-block text-center'><h1><a href='#unfavourite/"+(page.id ?? ""    )+"' class='btn bg-red add-to-favorites'><i class='fa fa-star' aria-hidden='true'></i> <span>Eltávolítom a kedvencekből</span></a></h1></div></div>"
            }
        })
        if (self.contentWebView == nil){
            self.initializeWKWebView()
            self.contentWebView.frame.origin.y = 80.0
            self.contentWebView.scrollView.contentSize.height += 80.0
            self.contentWebView.scrollView.contentOffset.y += 80.0
            self.contentWebView.frame.size.height -= 80.0
        }
        
        if favourites.count == 0 {
            htmlString += "<div style=\"font-size:2em;text-align:center;margin:50% auto;\">Még nincs kedvenc recepted</div>"
        }
        if self.contentWebView != nil {
            self.contentWebView.loadHTMLString(htmlString, baseURL: self.rootURL!)
        }
    }
}
