//
//  FloatLabelTextField.swift
//
//  Created by Mohammad Sadegh Panadgoo on 12/15/16.
//  Copyright © 2016 Behsazan Mellat. All rights reserved.
//

import UIKit
import ContactsUI

class FloatLabelTextField: UITextField, UITextFieldDelegate, CNContactPickerDelegate, HBDefaultPickerViewDelegate {
    
    let animationDuration       = 0.5
    
    var errorFlag               = false
    
    ///To Control maxLength of Field, if __NO style__ (_FloatLabelTextFieldStyle_) specified.
    var maxFieldLength          : Int? = nil

    var title                   = UILabel()
    var bottomBorderLine        = UIView()
    var error                   = UITextView()
    var rialLabel               = UILabel()
    var persianAmountDescLabel  = UILabel()
    let triangleImageView       = UIImageView.init(image: #imageLiteral(resourceName: "triangle"))
    let calenderButton          = UIButton()
    let accountSelectButton     = UIButton()
    let favoriteButton          = UIButton()
    let contactButton           = UIButton()
    let turnOverButton          = UIButton()

    var isPasteAllow            : Bool = true
        
    enum FloatLabelTextFieldStyle {
        case date
        case payerId
        case payerID_30
        case account
        case mellat // Card & AccountNo
        case pan
        case sheba
        case contract
        case amount
        case mobile
        case cvv2
        case pin
        case expireDate
        case billNo
        case payNo
        case none
        case recordCount
        case chequeSerie
        case chequeSerial
        case chequeSerie_4
        case chequeSerial_8
        case secondPass
        case disposablePass
        case iranInsurancePayId
        case requestNo
        case branchCode
        case branchCode_4Digit
        case latinName
        case sayadId
        case description_PersianEnglishDigits
        case time
        case password
        case passport
    }
    
    // MARK:- Properties
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        triangleImageView.removeFromSuperview()
        rialLabel.removeFromSuperview()
        accountSelectButton.removeFromSuperview()
        calenderButton.removeFromSuperview()
        favoriteButton.removeFromSuperview()
        contactButton.removeFromSuperview()
    }
    
    override var accessibilityLabel: String? {
        get {
            if let txt = text, txt.isEmpty {
                return title.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }

    override var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()

            guard let tmpText = placeholder else {
                self.attributedPlaceholder = NSAttributedString(string: "")
                return
            }
            let textRange = NSMakeRange(0, tmpText.count)
            let attributedText = NSMutableAttributedString(string: tmpText)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor , value: UIColor.clear, range: textRange)
            self.attributedPlaceholder = attributedText
        }
    }
    
    override var isHidden: Bool {
        didSet {
            calenderButton.isHidden         = isHidden
            accountSelectButton.isHidden    = isHidden
        }
    }
    
    var titleAlignment          : NSTextAlignment           = .right
    var titleFont               : UIFont                    = UIFont.systemFont(ofSize: 15.0) { didSet { title.font = titleFont } }
    var titleActiveFont         : UIFont                    = UIFont.systemFont(ofSize: 13.0) { didSet { title.font = titleActiveFont } }
    var titleTextColor          : UIColor                   = .black { didSet { if !isFirstResponder { title.textColor = titleTextColor } } }
    var titleActiveTextColor    : UIColor                   = .componentColorPacificBlue { didSet { if isFirstResponder { title.textColor = titleActiveTextColor } } }
    var activeBottomBorderColor : UIColor! { didSet { if isFirstResponder { bottomBorderLine.backgroundColor = activeBottomBorderColor } } }
    var bottomBorderWidth       : CGFloat                   = 1.0 { didSet { bottomBorderLine.frame.size.height = bottomBorderWidth } }
    var errorFont               : UIFont!                   = UIFont.mediumFont { didSet { error.font = errorFont } }
    
    var style: FloatLabelTextFieldStyle = .none {
        didSet {
            switch style {
            case .latinName,
                 .description_PersianEnglishDigits,
                 .password          : self.keyboardType = .default
            case .date              : self.addTarget(self, action: #selector(textFieldEditing(sender:)), for: .editingDidBegin)
            case .time              : self.addTarget(self, action: #selector(timeTextFieldEditing(sender:)), for: .editingDidBegin)
            default                 : self.keyboardType = .numberPad
            }
        }
    }

    var plusY: CGFloat! = 0 {
        didSet {
            self.frame.origin.y += plusY
            error.frame.origin.y += plusY
        }
    }
    
    var minusY: CGFloat! = 0 {
        didSet {
            self.frame.origin.y -= plusY
            error.frame.origin.y -= plusY
        }
    }
    
    var bottomBorderColor: UIColor! {
        didSet {
            borderStyle = UITextField.BorderStyle.none
            bottomBorderLine.backgroundColor = bottomBorderColor
            bottomBorderLine.frame = CGRect(x: 0, y: self.frame.height - bottomBorderWidth * 15, width: self.frame.width, height: bottomBorderWidth)
            self.addSubview(bottomBorderLine)
        }
    }

    var errorText: String? = "" {
        didSet {
            if errorText != "" {
                errorFlag = true
                error.text = self.errorText
                error.font = errorFont
                
                error.textColor = UIColor.buttonColorRed
                error.tag = 99988
                bottomBorderLine.backgroundColor = UIColor.buttonColorRed
                
                self.superview?.addSubview(error)

                setErrorPosition()
                self.becomeFirstResponder()
            }
        }
    }
    
    var errorTextOutKeyboard: String? = "" {
        didSet {
            if errorTextOutKeyboard != "" {
                errorFlag = true
                error.text = self.errorTextOutKeyboard
                error.font = errorFont
                
                error.textColor = UIColor.buttonColorRed
                error.tag = 99988
                bottomBorderLine.backgroundColor = UIColor.buttonColorRed
                self.superview?.addSubview(error)
                
                setErrorPosition()
            }
        }
    }
    var pickerView : HBDefaultPickerView?
    
    public var inputPickerViewList = [String]() {
        didSet {
            pickerView = HBDefaultPickerView.init(self, inputData: inputPickerViewList)

            pickerView?.delegate  = self
            
            inputView = pickerView
        }
    }
    

    // MARK:- Init
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }

    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }

    @objc func textFieldChanged(_ textField: FloatLabelTextField) {
        if errorFlag {
            errorFlag = false
            error.text = ""
            bottomBorderLine.backgroundColor = activeBottomBorderColor

        }
    }

    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePosition()
        let txt = text

        if isFirstResponder {
            if (txt?.isEmpty)! {
                if title.textColor != titleActiveTextColor {
                    upAnimation()
                    setTitleActivePositionAndFont()
                    self.title.textColor = self.titleActiveTextColor
                    self.bottomBorderLine.backgroundColor = self.activeBottomBorderColor
                } else {
                    setTitleActivePositionAndFont()
                }
            } else {
                bottomBorderLine.backgroundColor = activeBottomBorderColor
                title.textColor = titleActiveTextColor
                setTitleActivePositionAndFont()
            }
        } else {
            if (txt?.isEmpty)! {
                title.textColor = titleTextColor
                bottomBorderLine.backgroundColor = bottomBorderColor
                title.font = titleFont
                title.sizeToFit()
                setTitlePosition()
            } else {
                title.textColor = titleTextColor
                bottomBorderLine.backgroundColor = activeBottomBorderColor
                setTitleActivePositionAndFont()
            }

        }
        if errorFlag {
            bottomBorderLine.backgroundColor = UIColor.buttonColorRed
        }
    }
    
    func addListTriangleImage() {
        triangleImageView.tintColor = .gray
        triangleImageView.frame.size.width = 20
        triangleImageView.frame.size.height = 20
        triangleImageView.frame.origin.x = 0
        triangleImageView.frame.origin.y = bottomBorderLine.frame.minY - triangleImageView.frame.height
        
        addSubview(triangleImageView)
    }
    
    func addBorderLayout() {
        borderStyle = UITextField.BorderStyle.none
        bottomBorderLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBorderLine.heightAnchor.constraint(equalToConstant: bottomBorderWidth),
            bottomBorderLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderLine.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func addListTriangleImageLayout(seprator: Bool) {
        triangleImageView.translatesAutoresizingMaskIntoConstraints = false
        triangleImageView.tintColor = .gray
        triangleImageView.frame.size.width = 20
        triangleImageView.frame.size.height = 20
        triangleImageView.frame.origin.x = 0
        triangleImageView.frame.origin.y = bottomBorderLine.frame.minY - triangleImageView.frame.height
        
        addSubview(triangleImageView)
        
        if seprator {
            borderStyle = UITextField.BorderStyle.none
            bottomBorderLine.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            triangleImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            triangleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            triangleImageView.widthAnchor.constraint(equalToConstant: 20),
            triangleImageView.heightAnchor.constraint(equalToConstant: 20),
            
            bottomBorderLine.heightAnchor.constraint(equalToConstant: bottomBorderWidth),
            bottomBorderLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderLine.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func addSepratorLayout() {
        borderStyle = UITextField.BorderStyle.none
        bottomBorderLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomBorderLine.heightAnchor.constraint(equalToConstant: bottomBorderWidth),
            bottomBorderLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderLine.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func addCalenderButton() {
        guard let superView = superview else { return }
        
        calenderButton.setTitle("\u{f073}", for: .normal)
        calenderButton.setTitleColor(.lightGray, for: .normal)
        calenderButton.titleLabel?.font = UIFont.xxLargLogo
        calenderButton.sizeToFit()
        calenderButton.frame.origin.x = self.frame.minX - calenderButton.frame.width - 5
        calenderButton.frame.origin.y = self.frame.minY + (self.frame.height - calenderButton.frame.height) / 2
        calenderButton.addTarget(self, action: #selector(becomeFirstResponder), for: .touchUpInside)
        
        superView.addSubview(calenderButton)
    }
    
    func addCalenderButtonLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        calenderButton.setTitle("\u{f073}", for: .normal)
        calenderButton.setTitleColor(.lightGray, for: .normal)
        calenderButton.titleLabel?.font = UIFont.xxLargLogo
        calenderButton.sizeToFit()
        calenderButton.frame.origin.x = self.frame.minX - calenderButton.frame.width - 5
        calenderButton.frame.origin.y = self.frame.minY + (self.frame.height - calenderButton.frame.height) / 2
        calenderButton.addTarget(self, action: #selector(becomeFirstResponder), for: .touchUpInside)
        
        addSubview(calenderButton)
        
        calenderButton.translatesAutoresizingMaskIntoConstraints = false
        borderStyle = UITextField.BorderStyle.none
        bottomBorderLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calenderButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            calenderButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            calenderButton.widthAnchor.constraint(equalToConstant: 20),
            calenderButton.heightAnchor.constraint(equalToConstant: 20),
            
            bottomBorderLine.heightAnchor.constraint(equalToConstant: bottomBorderWidth),
            bottomBorderLine.leadingAnchor.constraint(equalTo: calenderButton.trailingAnchor, constant: 5),
            bottomBorderLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderLine.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func addAccountSelectButton() {
        guard let superView = superview else { return }
        
        accountSelectButton.setTitle("\u{f142}", for: .normal)
//        accountSelectButton.setTitle("\u{f142}", for: .selected)
//        accountSelectButton.setTitle("\u{f142}", for: .highlighted)
        accountSelectButton.setTitleColor(.baseColorGray, for: .normal)
//        accountSelectButton.setTitleColor(.baseColorGray, for: .selected)
//        accountSelectButton.setTitleColor(.baseColorGray, for: .highlighted)
        accountSelectButton.titleLabel?.font    = UIFont.xxLargLogo
        accountSelectButton.sizeToFit()
        accountSelectButton.frame.origin.x      = self.frame.minX - accountSelectButton.frame.width - 5
        accountSelectButton.frame.origin.y      = self.frame.minY + (self.frame.height - accountSelectButton.frame.height) / 2
        
        superView.addSubview(accountSelectButton)
    }
    
    func addAccountSelectButtonLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        accountSelectButton.setTitle("\u{f142}", for: .normal)
        accountSelectButton.setTitleColor(.baseColorGray, for: .normal)
        accountSelectButton.titleLabel?.font    = UIFont.xxLargLogo
        accountSelectButton.sizeToFit()
        accountSelectButton.addTarget(self, action: #selector(becomeFirstResponder), for: .touchUpInside)
        addSubview(accountSelectButton)
        
        accountSelectButton.translatesAutoresizingMaskIntoConstraints = false
        borderStyle = UITextField.BorderStyle.none
        bottomBorderLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            accountSelectButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            accountSelectButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            accountSelectButton.widthAnchor.constraint(equalToConstant: 20),
            accountSelectButton.heightAnchor.constraint(equalToConstant: 20),
            
            bottomBorderLine.heightAnchor.constraint(equalToConstant: bottomBorderWidth),
            bottomBorderLine.leadingAnchor.constraint(equalTo: accountSelectButton.trailingAnchor, constant: 5),
            bottomBorderLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderLine.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func addTurnOverButton() {
        guard let superView = superview else { return }
        
        turnOverButton.setTitle("\u{f017}", for: .normal)
        turnOverButton.setTitleColor(.lightGray, for: .normal)
        turnOverButton.titleLabel?.font = UIFont.xxLargLogo
        turnOverButton.sizeToFit()
        turnOverButton.frame.origin.x = self.frame.minX - turnOverButton.frame.width - 5
        turnOverButton.frame.origin.y = self.frame.minY + (self.frame.height - turnOverButton.frame.height) / 2
        turnOverButton.addTarget(self, action: #selector(becomeFirstResponder), for: .touchUpInside)
        
        superView.addSubview(turnOverButton)
    }
    

    func addMobileFavoriteButton() {
        guard let superView = superview else { return }

        favoriteButton.addTarget(self, action: #selector(favoriteContactButtonPressed(_:)), for: .touchUpInside)
        favoriteButton.setTitle("\u{f142}", for: .normal)
        favoriteButton.setTitleColor(.baseColorGray, for: .normal)
        favoriteButton.titleLabel?.font     = UIFont.xxLargLogo
        favoriteButton.sizeToFit()
        favoriteButton.backgroundColor      = .clear
        favoriteButton.frame.origin.x       = self.frame.minX - favoriteButton.frame.width - 5
        favoriteButton.frame.origin.y       = self.frame.minY + (self.frame.height - favoriteButton.frame.height) / 2
        
        superView.addSubview(favoriteButton)
    }
    
    func addMobileContactButton() {
        guard let superView = superview else { return }
        guard #available(iOS 9.0, *)    else { return }
        
        contactButton.addTarget(self, action: #selector(click_Contact(sender:)), for: .touchUpInside)
        contactButton.setTitle("\u{f271}", for: .normal)
        contactButton.setTitleColor(.baseColorGray, for: .normal)
        contactButton.titleLabel?.font  = UIFont.xxxxLargLogo
        contactButton.sizeToFit()
        contactButton.backgroundColor   = .clear
        contactButton.frame.origin.x    = self.frame.maxX + 5
        contactButton.frame.origin.y    = self.frame.minY + (self.frame.height - contactButton.frame.height) / 2
        
        superView.addSubview(contactButton)
    }
    
    @objc private func favoriteContactButtonPressed(_ sender: UIButton) {
        self.resignFirstResponder()
        
        if let dataArray = SqlEnginge.instance.getAllFavorites() {
            var numbers = [String]()
            var names = [String]()
            for i in 0..<dataArray.count {
                if dataArray[i].type == RConstant.FAVORITE_MOBILENO_TYPE {
                    numbers.append(dataArray[i].number ?? "")
                    names.append(dataArray[i].ownerDescription ?? "")
                }
            }
            PopUpSmartTab().showContactListView(titles: numbers, descriptions: names, textField: self)
        }
    }
    
    @objc @available(iOS 9.0, *)
    func click_Contact(sender: UIButton) {
        guard let superView = sender.superview else { return }
        guard let superVC = superView.viewContainingController else { return }
        
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        
        superVC.present(cnPicker, animated: true, completion: nil)
    }
    
    @available(iOS 9.0, *)
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        if contact.phoneNumbers.count > 0 {
            var numbers = [String]()
            if contact.phoneNumbers.count > 0 {
                for i in 0..<contact.phoneNumbers.count {
                    if let thisNumber = contact.phoneNumbers[i].value.value(forKey: "digits") as? String {
                        numbers.append(thisNumber)
                    }
                }
            }
            if numbers.count > 1 {
                PopUpSmartTab().showContactNumbersList(titles: numbers, textField: self)
            }
            if let mobileNo = numbers.first?.formatPhoneNumber(), mobileNo.length <= 11 {
                self.text = mobileNo
            } else {
                self.text = ""
            }
        } else {
            self.text = ""
        }
    }
    
    @available(iOS 9.0, *)
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.removeTextFieldError()
        
        guard let text = textField.text else { return true }
        let newLength = (text + string).length
        
        switch style {
        case .mellat:
            if string != "" {
                let first = text.substring(to: range.location)
                let second = text.substring(from: range.location)
                let afterInsert = (first + string + second)
                if afterInsert.length <= 10 {
                    textField.text = afterInsert
                } else if afterInsert.length <= 23 {
                    textField.text = afterInsert.addDash
                }
                return false
            } else {
                let first = text.substring(to: range.location).removeAllSpace
                let index = text.index(text.startIndex, offsetBy: range.location)
                var second = String(text[index...]).removeAllSpace
                
                second = second.chopPrefix(range.length)
                let afterDelete = (first + second)
                if afterDelete.length <= 10 {
                    textField.text = afterDelete
                } else {
                    textField.text = afterDelete.addDash
                }
                return false
            }
        case .sheba:
            if text.length == 0 && string == "" { return false }
            if string != "" {
                let first = text.substring(to: range.location).removeAllDash
                let second = text.substring(from: range.location).removeAllDash
                let afterInsert = (first + string + second).addShebaDashWithoutIR
                if afterInsert.length <= 30 {
                    textField.text = afterInsert
                }
            } else {
                let first = text.substring(to: range.location)
                let index = text.index(text.startIndex, offsetBy: range.location)
                var second = String(text[index...])
                
                second = second.chopPrefix(range.length)
                let text  = ((first + second).removeAllDash).addShebaDashWithoutIR
                textField.text = text
            }
            return false
        case .amount:
            if textField.text?.length == 0 && string == "0" { return false }
            if string != "" {
                let first = text.substring(to: range.location).removeRialAndSeparator
                let second = text.substring(from: range.location).removeRialAndSeparator
                let afterInsert = (first + string + second as NSString).longLongValue.stringWithSeparator
                
                if afterInsert.length <= 19 {
                    textField.text = afterInsert
                }
            } else {
                let first = text.substring(to: range.location)
                let index = text.index(text.startIndex, offsetBy: range.location)
                var second = String(text[index...])
                
                second = second.chopPrefix(range.length)
                let text  = ((first + second).removeRialAndSeparator as NSString).longLongValue.stringWithSeparator
                textField.text = text
                if text == "0" {
                    textField.text = ""
                }
            }
            
            return false
        case .pan:
        if string != "" {
            let first = text.substring(to: range.location).addDash
            let second = text.substring(from: range.location + range.length).addDash
            let pureNumber = (first + string + second).components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let afterInsert = pureNumber.addDash
            if afterInsert.length <= 23 {
                textField.text = afterInsert
            }
        } else {
            let first = text.substring(to: range.location)
            let index = text.index(text.startIndex, offsetBy: range.location)
            var second = String(text[index...])
            second = second.chopPrefix(range.length)
            textField.text  = (first + second).addDash
        }
        return false
        case .payerID_30:
            let first = text.substring(to: range.location)
            let second = text.substring(from: range.location + range.length)
            let pureNumber = (first + string + second).components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if pureNumber.length <= 30 {
                textField.text = pureNumber
                return false
            } else { return false }
        case .payerId:
            let first = text.substring(to: range.location)
            let second = text.substring(from: range.location + range.length)
            let pureNumber = (first + string + second).components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if pureNumber.length <= 18 {
                textField.text = pureNumber
                return false
            } else { return false }
        case .sayadId:
            if string != "" {
                let first = text.substring(to: range.location)
                let second = text.substring(from: range.location)
                let afterInsert = (first + string + second)
                if afterInsert.length <= 19 {
                    textField.text = afterInsert.addPanSpace
                }
                return false
            } else {
                let first = text.substring(to: range.location).removeAllSpace
                let index = text.index(text.startIndex, offsetBy: range.location)
                var second = String(text[index...]).removeAllSpace
                
                second = second.chopPrefix(second.length)
                let afterDelete = (first + second)
                textField.text = afterDelete.addPanSpace
                return false
            }
        case .passport:
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                
                let passwordRegex = "^(?!^0+$)[a-zA-Z0-9]{0,30}$"
                return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: updatedText)
            }
            
            return false
            
//            let PASSPORT_REG_EX = "^(?!^0+$)[a-zA-Z0-9]"
//            let passport = NSPredicate(format:"SELF MATCHES %@", PASSPORT_REG_EX)
//            
//            return passport.evaluate(with: text)
        case .mobile            : return newLength <= 11
        case .cvv2              : return newLength <= 4
        case .pin               : return newLength <= 12
        case .payNo, .billNo    : return newLength <= 13
        case .account           : return newLength <= 10
        case .contract          : return newLength <= 18
        case .expireDate        : return newLength <= 5
        case .date              : return newLength <= 10
        case .recordCount       : return newLength <= 3
        case .chequeSerie       : return newLength <= 8
        case .chequeSerial      : return newLength <= 15
        case .chequeSerie_4     : return newLength <= 4
        case .chequeSerial_8    : return newLength <= 8
        case .secondPass        : return newLength <= 12
        case .disposablePass    : return newLength <= 6
        case .iranInsurancePayId: return newLength <= 17
        case .requestNo         : return newLength <= 12
        case .latinName         :
            let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let filtered = compSepByCharInSet.joined(separator: "")
            
            if string == "\n" { return true }
            
            if string == filtered {
                return newLength <= 15
            } else {
                self.superview?.endEditing(true)
                let error = SweetAlert().showAlert("تغییر زبان", subTitle: "لطفاً زبان صفحه کلید خود را به انگلیسی تغییر دهید.", style: .error, buttonTitle: "بستن", buttonColor: UIColor.buttonColorRed)
                error.animateAlert()
                return false
            }
        case .branchCode        : return newLength <= 7
        case .branchCode_4Digit : return newLength <= 4
        case .description_PersianEnglishDigits :
            if newLength > maxFieldLength ?? 0 {
                return false
            }
            let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789آأإابپتثجچحخدذرزژسشصضطظعغفقکگلمنوؤهیئء  ۰٠۱١۲٢۳٣۴٤۵٥۶٦۷٧۸٨۹٩ + - ( ) *\n").inverted

            let filtered = string.components(separatedBy: aSet).joined()
            
            if string != filtered {
                resignFirstResponder()
                let error = SweetAlert().showAlert("کارکتر غیرمجاز", subTitle: "کارکترهای مجاز حروف فارسی و انگلیسی، اعداد و نشانه‌های + - ( ) و * است.", style: .error, buttonTitle: "بستن", buttonColor: UIColor.buttonColorRed)
                error.animateAlert()
                return false
            }
            return true
        case .password:
            let aSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-=+:;'/?,.<>{}[]|~`\"\\ ").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let filtered = compSepByCharInSet.joined(separator: "")
            
            if string == "\n" { return true }
            
            if string == filtered {
                return newLength <= 20
            } else {
                let error = SweetAlert().showAlert("تغییر زبان", subTitle: "رمز ورود شامل کاراکتر‌های غیر مجازاست", style: .error, buttonTitle: "بستن", buttonColor: UIColor.buttonColorRed)
                error.animateAlert()
                resignFirstResponder()
                return false
            }
        default :
            if let customizedMaxLength = maxFieldLength {
                let locationIndex = text.index(text.startIndex, offsetBy: range.location)
                let lengthIndex = text.index(locationIndex, offsetBy: range.length)
                let prefix = text[..<locationIndex]
                let suffix = text[lengthIndex..<text.endIndex]
                
                let newText = String(prefix + string + suffix)
                let newLength = newText.count
                if newLength <= customizedMaxLength { return true } else {
                    textField.text = String(newText[..<newText.index(newText.startIndex, offsetBy: customizedMaxLength)])
                    return false
                }
            }
            return true
        }
    }
    
    @objc private func textFieldEditing(sender: UITextField) {
        
        
        let datePickerView:UIDatePicker = UIDatePicker()
        if #available(iOS 15.0, *) {
            datePickerView.preferredDatePickerStyle = .inline
        } else if #available(iOS 13.6, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        let persianFormatter            = DateFormatter()
        persianFormatter.calendar       = Calendar(identifier: .persian)
        persianFormatter.calendar.firstWeekday = 7
        persianFormatter.dateFormat = "yyyy/MM/dd"
        
        persianFormatter.locale          = Locale(identifier: "fa_IR")
        persianFormatter.calendar.locale = Locale(identifier: "fa_IR")
        if #available(iOS 15.0, *) {
            datePickerView.frame.size.height += defaults.loginVC?.view.safeAreaInsets.bottom ?? 25 //400
        }
        
        datePickerView.date             = Date()
        datePickerView.datePickerMode   = .date
        datePickerView.calendar         = Calendar(identifier: .persian) //persianFormatter.calendar //Calendar(identifier: .persian)
        datePickerView.locale           = Locale(identifier: "fa_IR") //persianFormatter.locale //Locale(identifier: "fa_IR")
        datePickerView.calendar.locale  = Locale(identifier: "fa_IR") //persianFormatter.calendar.locale
        datePickerView.setValue(UIColor.black, forKey: "textColor")
        datePickerView.setValue(UIColor.white, forKey: "backgroundColor")
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        if (sender.text ?? "") == "" {
            sender.text = GlobalFunctions.getPersianDate()
        }
        
        sender.inputView = datePickerView
        
        if let text = sender.text, text.count > 0 {
            if let date = persianFormatter.date(from: text) {
                datePickerView.date = date
                datePickerView.setDate(date, animated: true)
            }
        }
    }
    
    @objc func timeTextFieldEditing (sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        if #available(iOS 15.0, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else if #available(iOS 13.6, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        let persianFormatter            = DateFormatter()
        persianFormatter.calendar       = Calendar(identifier: .persian)
        persianFormatter.locale         = Locale(identifier: "fa_IR")
        persianFormatter.calendar.locale = Locale(identifier: "fa_IR")
        persianFormatter.timeStyle = .short
        persianFormatter.dateFormat = "HH:mm"
        if #available(iOS 15.0, *) {
            datePickerView.frame.size.height += defaults.loginVC?.view.safeAreaInsets.bottom ?? 25 //400
        }
        datePickerView.datePickerMode   = .time
        datePickerView.calendar         = persianFormatter.calendar //Calendar(identifier: .persian)
        datePickerView.locale           = persianFormatter.locale //Locale(identifier: "fa_IR")
        datePickerView.calendar.locale = Locale(identifier: "fa_IR")
        datePickerView.setValue(UIColor.black, forKey: "textColor")
        datePickerView.setValue(UIColor.white, forKey: "backgroundColor")
        datePickerView.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        if let currentText = sender.text, let date = persianFormatter.date(from: currentText) {
            datePickerView.date = date
        } else if let defaultDate = persianFormatter.date(from: "08:00") {
            datePickerView.date = defaultDate
        }
        sender.text = persianFormatter.string(from: datePickerView.date)
        sender.inputView = datePickerView
        
    }
    
    
    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        let formatter           = DateFormatter()
        formatter.calendar      = Calendar(identifier: .persian)
        formatter.dateFormat    = "yyyy/MM/dd"
                
        self.removeTextFieldError()
        self.text               = formatter.string(from: sender.date)
    }
    
    @objc private func timePickerValueChanged(sender: UIDatePicker) {
        
        let formatter           = DateFormatter()
        formatter.timeStyle     = .short
        formatter.dateFormat    = "HH:mm"
        
        self.removeTextFieldError()
        self.text               = formatter.string(from: sender.date)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (action == #selector(UIResponderStandardEditActions.paste(_:)) ){
            if self.style == .sheba { // check format Sheba for paste action
                if let pasteValue = UIPasteboard.general.string {
                    let justNumber = pasteValue.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
                    if  justNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil{
                        if justNumber.count <= 24 {
                            return true
                        }
                    }
                    return false
                }
            } else if self.style == .amount {
                return false
            } else if !(isPasteAllow) { // check whether if TextField allow paste actoin
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    //MARK: - Delegates
    //MARK: HBDefaultPicker
    
    func indexChanged(_ index: Int, for textField: FloatLabelTextField) {
//        print("\n\t> in FloatLabelTextField\n\t> indexChanged:\n\t> index: \(index)\ttextField: \(textField)")
    }
    
}

// MARK:- Public Methods
extension FloatLabelTextField {
    
    func addHamrahBankDefaultTextField(with title: String, to containerView: UIView, at minY: CGFloat? = nil) {
        let textFieldHeight                 = CGFloat(50)
        let textFieldWidth                  = ScreenSize.width / 4 * 3
        var lastTextField                   : FloatLabelTextField?
        
        for subview in containerView.subviews {
            if subview is FloatLabelTextField { lastTextField = subview as? FloatLabelTextField }
        }
        
        self.placeholder                    = title
        self.frame.size.width               = textFieldWidth
        self.frame.size.height              = textFieldHeight
        self.frame.origin.x                 = (ScreenSize.width - self.frame.width) / 2
        if let minY {
            self.frame.origin.y             = minY
        } else {
            self.frame.origin.y             = lastTextField != nil ? lastTextField!.frame.maxY + 15 : 10
        }
        self.bottomBorderColor              = UIColor.groupTableViewBackground
        self.activeBottomBorderColor        = UIColor.baseColorGray
        self.titleFont                      = UIFont.largFont
        self.titleActiveFont                = UIFont.mediumFont
        self.titleTextColor                 = UIColor.baseColorGray
        self.titleActiveTextColor           = UIColor.baseColorGray
        self.font                           = UIFont.largFont
        self.textAlignment                  = .center
        
        containerView.addSubview(self)
        containerView.frame.size.height     = self.frame.maxY
    }
    
    func addHamrahBankDefaultTextField(with title: String, withValue value: String?, to containerView: UIView ) {
        self.addHamrahBankDefaultTextField(with: title, to: containerView)
        self.text                           = value ?? ""
    }
    
    func removeTextFieldError() {
        if errorFlag {
            errorFlag = false
            errorText = ""
            bottomBorderLine.backgroundColor = bottomBorderColor
            error.removeFromSuperview()
        }
    }
    
    func addRialLabel() {
        let rialLabel = UILabel()
        rialLabel.text = "ریال"
        rialLabel.textColor = .black
        rialLabel.font = UIFont.mediumFont
        rialLabel.sizeToFit()
        rialLabel.frame.origin.x = 0
        rialLabel.frame.origin.y = self.bottomBorderLine.frame.minY - rialLabel.frame.height
        self.addSubview(rialLabel)
    }
    
    func addIRLabel() {
        
        for v in self.subviews {
            if v.tag == 5353 {
                v.removeFromSuperview()
            }
        }
        
        let IRLabel = UILabel()
        IRLabel.text = "IR"
        IRLabel.tag = 5353
        IRLabel.textColor = .black
        IRLabel.font = UIFont.mediumFont
        IRLabel.sizeToFit()
        IRLabel.frame.origin.x = 0
        IRLabel.frame.origin.y = self.bottomBorderLine.frame.minY - IRLabel.frame.height
        self.addSubview(IRLabel)

    }
    
    class func connectFields(fields: [FloatLabelTextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0..<fields.count-1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }

    // MARK:- Private Methods
    private func setup() {
        title.font = titleFont
        titleActiveTextColor = tintColor
        title.textColor = titleTextColor

        if let str = placeholder , !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        
        self.addSubview(title)
        self.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        self.delegate = self
    }

    private func setErrorPosition() {
        error.isEditable = false
        error.isSelectable = false
        error.isEditable = false
        error.isUserInteractionEnabled = false
        error.isScrollEnabled = false
        error.textAlignment = .right
        error.backgroundColor = .clear
        error.sizeToFit()
        
        if error.frame.width > self.frame.width - 5 {
            /*let rect = errorText?.boundingRect(with: CGSize(width: self.frame.width, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:error.font!], context: nil)
            let textViewHeight = ceil((rect?.size.height)!) + 5
            print(textViewHeight)*/
            //error.frame.size.height = error.intrinsicContentSize.height
            //error.sizeToFit()
            error.frame.size = error.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        }
        
        error.frame.size.width = self.frame.width
        error.frame.origin.x = self.frame.minX
        error.frame.origin.y = self.frame.maxY - 20
        
        if !self.translatesAutoresizingMaskIntoConstraints {
            error.translatesAutoresizingMaskIntoConstraints = false
            error.heightAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
            error.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            error.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            error.topAnchor.constraint(equalTo: self.bottomBorderLine.bottomAnchor, constant: -8).isActive = true
        }
    }
    
    private func setTitlePosition() {
        title.textAlignment = titleAlignment
        ///self.backgroundColor = .yellow
        title.sizeToFit()
        //title.frame.origin.x = self.frame.width - title.frame.width
        title.frame.origin.x = 0
        title.frame.origin.y = self.frame.height - bottomBorderWidth * 15 - title.frame.height
        title.frame.size.width = self.frame.width

    }

    private func setTitleActivePositionAndFont() {
        title.frame.origin.x = 0
        title.frame.origin.y = 0
        title.font = titleActiveFont
        title.sizeToFit()
        title.textAlignment = titleAlignment
        title.frame.size.width = self.frame.width

    }

    private func upAnimation() {
        UILabel.animate(withDuration: animationDuration, animations: {() -> Void in
            //self.title.frame.origin.y = 0
            self.setTitleActivePositionAndFont()
        })
    }
}

extension FloatLabelTextField {
    
    ///This method is write to use in XIB files
    func addHamrahBankDefaultTextField(with title: String) {
        
        self.placeholder                    = title
        /*self.frame.size.width               = textFieldWidth
        self.frame.size.height              = textFieldHeight
         let textFieldHeight                 = CGFloat(50)
         let textFieldWidth                  = ScreenSize.width / 4 * 3
          */
        self.bottomBorderColor              = UIColor.groupTableViewBackground
        bottomBorderLine.frame.size.width   = ScreenSize.width / 4 * 3
        self.activeBottomBorderColor        = UIColor.baseColorGray
        self.titleFont                      = UIFont.largFont
        self.titleActiveFont                = UIFont.mediumFont
        self.titleTextColor                 = UIColor.baseColorGray
        self.titleActiveTextColor           = UIColor.baseColorGray
        self.font                           = UIFont.largFont
        self.textAlignment                  = .center
        
    }
//    func addMobileContactButton() {
//        guard let superView = superview else { return }
//        guard #available(iOS 9.0, *)    else { return }
//        
//        contactButton.addTarget(self, action: #selector(click_Contact(sender:)), for: .touchUpInside)
//        contactButton.setTitle("\u{f271}", for: .normal)
//        contactButton.setTitleColor(.baseColorGray, for: .normal)
//        contactButton.titleLabel?.font  = UIFont.xxxxLargLogo
//        contactButton.sizeToFit()
//        contactButton.backgroundColor   = .clear
//        contactButton.frame.origin.x    = self.frame.maxX + 5
//        contactButton.frame.origin.y    = self.frame.minY + (self.frame.height - contactButton.frame.height) / 2
//        
//        superView.addSubview(contactButton)
//    }
}


//MARK: - Password Validation
extension FloatLabelTextField {
    func hasEnteredValidPassword() -> Bool {
        guard style == .password else { return false }
        
        let inputTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z])(?=.*\\d).{10,}$")
        if !inputTest.evaluate(with: self.text) {
            let alert = SweetAlert().showAlert("عملیات ناموفق", subTitle: "رمز ورود باید حداقل ده کاراکتر و شامل حروف و عدد باشد.", style: .error, buttonTitle: "بستن", buttonColor: UIColor.buttonColorRed)
            alert.animateAlert()
            return false
        } else {
            return true
        }
    }
}
