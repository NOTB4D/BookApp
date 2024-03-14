//
//  BPickerTextField.swift
//  BookApp
//
//  Created by Eser Kucuker on 14.03.2024.
//

import Extensions
import UIKit

public protocol BPickerTextFieldDelegate: AnyObject {
    func pickerTextFieldNumberOfRows(_ textField: BPickerTextField) -> Int
    func pickerTextField(_ textField: BPickerTextField, titleForRow row: Int) -> String?
    func pickerTextField(_ textField: BPickerTextField, didSelectRow row: Int)
}

public class BPickerTextField: UITextField {
    public init() {
        super.init(frame: .zero)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        font = UIFont(name: "Helvetica", size: 12) ?? .systemFont(ofSize: 12)
    }

    public var items: [String]?

    public weak var pickerDelegate: BPickerTextFieldDelegate? {
        didSet {
            setPicker()
        }
    }

    private var picker: UIPickerView?

    public var selectedRow: Int? {
        get {
            (text == nil || text!.isEmpty) ? nil : picker?.selectedRow(inComponent: 0)
        }
        set {
            picker?.selectRow(newValue.intValue, inComponent: 0, animated: false)
            doneSelectedPicker()
        }
    }

    override public func caretRect(for _: UITextPosition) -> CGRect {
        CGRect.zero
    }

    override public func selectionRects(for _: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        performActions(action, withSender: sender)
    }

    private func setPicker() {
        picker = UIPickerView()
        picker?.reloadAllComponents()
        picker?.delegate = self
        picker?.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .darkGray
        toolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Tamam", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneSelectedPicker))

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        inputView = picker
        inputAccessoryView = toolBar
        picker?.reloadInputViews()
    }

    @objc public func doneSelectedPicker() {
        endEditing(false)
        selectRow()
    }

    @objc private func selectRow() {
        if let row = picker?.selectedRow(inComponent: 0) {
            text = pickerDelegate?.pickerTextField(self, titleForRow: row)
        }
    }

    @objc private func donePicker() {
        if let row = picker?.selectedRow(inComponent: 0) {
            text = pickerDelegate?.pickerTextField(self, titleForRow: row)
        }
    }

    public func setRightIcon() {
        let imageView = UIImageView(image: UIImage(named: "BlackDownArrowIcon"))
        imageView.frame = CGRect(x: 0, y: frame.height / 3, width: 16, height: 16)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.height))
        view.addSubview(imageView)
        rightView = view
        rightView?.isUserInteractionEnabled = false
        rightViewMode = .always
    }

    func performActions(_ action: Selector, withSender sender: Any?) -> Bool {
        let disallowedActions = [
            #selector(copy(_:)),
            #selector(cut(_:)),
            #selector(selectAll(_:)),
            #selector(paste(_:)),
        ]

        if disallowedActions.contains(action) {
            return false
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
}

extension BPickerTextField: UIPickerViewDelegate {
    public func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        pickerDelegate?.pickerTextField(self, titleForRow: row)
    }

    public func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        text = pickerDelegate?.pickerTextField(self, titleForRow: row)
        pickerDelegate?.pickerTextField(self, didSelectRow: row)
    }
}

extension BPickerTextField: UIPickerViewDataSource {
    public func numberOfComponents(in _: UIPickerView) -> Int {
        1
    }

    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        (pickerDelegate?.pickerTextFieldNumberOfRows(self)).intValue
    }
}
