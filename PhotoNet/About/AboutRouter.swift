//
//  AboutRouter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation

protocol AboutRouterProtocol: AnyObject{
    var view: AboutViewProtocol! {get set}
}
class AboutRouter: AboutRouterProtocol{
    weak var view: AboutViewProtocol!
}
