//
//  AboutRouter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation
import UIKit

protocol AboutRouterProtocol: AnyObject{
    var view: AboutViewProtocol! {get set}
    
    func presentViewer(withLink link: String)
}
class AboutRouter: AboutRouterProtocol{
    weak var view: AboutViewProtocol!
  
    func presentViewer(withLink link: String) {
        let viewer = ViewerView(imageLink: link)
       
        view.presentViewController(viewController: viewer,
                                   presentationStyle: .overFullScreen,
                                   transitionStyle: .crossDissolve,
                                   animated: true)
    }
    
}
