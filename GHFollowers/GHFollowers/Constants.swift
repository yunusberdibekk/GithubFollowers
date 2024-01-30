//
//  Constants.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import UIKit

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName:  "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
}

enum Images {
    static let ghLogo = UIImage(resource: .ghLogo)
    static let placeholder = UIImage(resource: .avatarPlaceholder)
    static let emptyStateLogo = UIImage(resource: .emptyStateLogo)
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let maxLenght = max(ScreenSize.width, ScreenSize.height)
    static let minLenght = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isIphoneSE = idiom == .phone && ScreenSize.maxLenght == 568.0
    static let isIphone8Standart = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale == scale
    static let isIphone8Zoomed = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale > scale
    static let isIphone8PlusStandart = idiom == .phone && ScreenSize.maxLenght == 736
    static let isIphone8SPlusZoomed = idiom == .phone && ScreenSize.maxLenght == 736 && nativeScale < scale
    static let isIphoneX = idiom == .phone && ScreenSize.maxLenght == 812.0
    static let isIphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLenght == 896.0
    static let isIpad = idiom == .pad && ScreenSize.maxLenght >= 1024.0

    static func isIphoneXAspectRatio() -> Bool {
        return isIphoneX || isIphoneXsMaxAndXr
    }
}
