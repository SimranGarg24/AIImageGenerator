//
//  ImageStyle.swift
//  AIImageGeneratorApp
//
//  Created by Saheem Hussain on 03/11/23.
//

import Foundation

struct ImageStyle {
    var image: String
    var style: Style
}

extension ImageStyle {
    
    static var data = [
        ImageStyle(image: "block", style: .noStyle),
        ImageStyle(image: "oil painting", style: .oilPaint),
        ImageStyle(image: "anime", style: .anime),
        ImageStyle(image: "sketch", style: .sketch),
        ImageStyle(image: "illustration", style: .illustration),
        ImageStyle(image: "hyper realistic", style: .hyperRealistic),
        ImageStyle(image: "cartoon", style: .cartoon),
        ImageStyle(image: "abstract", style: .abstract),
        ImageStyle(image: "logo", style: .logo),
        ImageStyle(image: "ink", style: .ink),
        ImageStyle(image: "retro", style: .retro),
        ImageStyle(image: "haunted", style: .haunted),
        ImageStyle(image: "water color", style: .waterColor),
        ImageStyle(image: "3d", style: .threeD),
        ImageStyle(image: "pop art", style: .popArt)
    ]
}
