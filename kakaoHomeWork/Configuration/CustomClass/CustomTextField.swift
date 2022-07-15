//
//  TextField+.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/15.
//

import UIKit

//MARK: Debounce TextField
class CustomTextField :  UITextField {
    deinit {
            self.removeTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
        }

        private var workItem: DispatchWorkItem?
        private var delay: Double = 0
        private var callback: ((String?) -> Void)? = nil

        func debounce(delay: Double, callback: @escaping ((String?) -> Void)) {
            self.delay = delay
            self.callback = callback
            DispatchQueue.main.async {
                self.callback?(self.text)
            }
            self.addTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
        }

        @objc private func editingChanged(_ sender: UITextField) {
          self.workItem?.cancel()
          let workItem = DispatchWorkItem(block: { [weak self] in
              self?.callback?(sender.text)
          })
          self.workItem = workItem
          DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: workItem)
        }
}
