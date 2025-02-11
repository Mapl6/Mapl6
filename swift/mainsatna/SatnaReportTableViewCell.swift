import UIKit

class SatnaReportTableViewCell: UITableViewCell {
    let banktextField: FloatLabelTextField = {
        let textField = FloatLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleTextColor = .black
        textField.titleActiveTextColor = .black
        textField.activeBottomBorderColor = UIColor.componentColorSilver
        textField.bottomBorderColor = UIColor.componentColorSilver
        textField.titleFont = UIFont.mediumFont
        textField.titleActiveFont = UIFont.mediumFont
        textField.font = UIFont.mediumFont
        textField.textColor = .black
        textField.textAlignment = .center
        textField.keyboardType = .default
        textField.addBorderLayout()
        return textField
    }()
    let statustextField: FloatLabelTextField = {
        let textField = FloatLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleTextColor = .black
        textField.titleActiveTextColor = .black
        textField.activeBottomBorderColor = UIColor.componentColorSilver
        textField.bottomBorderColor = UIColor.componentColorSilver
        textField.titleFont = UIFont.mediumFont
        textField.titleActiveFont = UIFont.mediumFont
        textField.font = UIFont.mediumFont
        textField.textColor = .black
        textField.textAlignment = .center
        textField.keyboardType = .default
        textField.addBorderLayout()
        return textField
    }()
    let shebatextField: FloatLabelTextField = {
        let textField = FloatLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleTextColor = .black
        textField.titleActiveTextColor = .black
        textField.activeBottomBorderColor = UIColor.componentColorSilver
        textField.bottomBorderColor = UIColor.componentColorSilver
        textField.titleFont = UIFont.mediumFont
        textField.titleActiveFont = UIFont.mediumFont
        textField.font = UIFont.mediumFont
        textField.textColor = .black
        textField.textAlignment = .center
        textField.keyboardType = .default
        textField.addBorderLayout()
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        setupTextField()
    }

    private func setUpView() {
        contentView.addSubview(banktextField)
        contentView.addSubview(statustextField)
        contentView.addSubview(shebatextField)

        // Set up constraints
        NSLayoutConstraint.activate([
            banktextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            banktextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            banktextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            statustextField.topAnchor.constraint(equalTo: banktextField.bottomAnchor, constant: 8),
            statustextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statustextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            shebatextField.topAnchor.constraint(equalTo: statustextField.bottomAnchor, constant: 8),
            shebatextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shebatextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shebatextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func setupTextField() {
        banktextField.placeholder = "شماره حواله"
        statustextField.placeholder = "وضعیت حواله"
        shebatextField.placeholder = "شماره شبای مقصد"
    }
}
