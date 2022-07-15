//
//  String+.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/13.
//

import UIKit

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
    
    // MARK: 특정 영역 색깔과 폰트 변경
    func attributeStringFontAndColor(_ string : String,
                                     _ font: String,
                                     _ fontSize : CGFloat,
                                     _ start : Int, _ end: Int, _ color : UIColor ) -> NSMutableAttributedString {
        let fontSize = UIFont(name: font, size: fontSize)
        let attributeString = NSMutableAttributedString(string: string)
        attributeString.addAttribute(.font, value: fontSize, range: NSRange(location: start, length: end))
        attributeString.addAttribute(.foregroundColor, value: color, range: NSRange(location: start, length: end))
        
        return attributeString
    }
}
