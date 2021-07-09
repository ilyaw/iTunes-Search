//
//  AppDetailPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 05.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol AppDetailViewInput: AnyObject {
    var app: ITunesApp { get set }
}

protocol AppDetailViewOutput: AnyObject {
    func getSizeText(text: String) -> CGSize
}

class AppDetailPresenter {
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth =  UIScreen.main.bounds.width - 16 * 2
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font], context: nil)
        // получаем ширину блока, переводим её в Double
        let width = Double(rect.size.width)
        // получаем высоту блока, переводим её в Double
        let height = Double(rect.size.height)
        // получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
}

extension AppDetailPresenter: AppDetailViewOutput {
    func getSizeText(text: String) -> CGSize {
        return getLabelSize(text: text, font: UIFont.systemFont(ofSize: 15))
    }
}


