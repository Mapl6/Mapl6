import UIKit

class SatnaReceiptViewController: UIViewController {

    // MARK: - Properties
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1) // Fallback for .systemBackground
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 5
        view.semanticContentAttribute = .forceRightToLeft // Ensure RTL support
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var shareButton: UIButton = {
        return makeButton(title: "اشتراک گذاری", backgroundColor: .gray)
    }()

    private lazy var pdfButton: UIButton = {
        return makeButton(title: "pdf", backgroundColor: .red)
    }()

    // Placeholder properties
    var draftId: Int? = 12345
    var draftAmount: Int? = 1000000
    var incomeAmount: Int? = 50000
    var beneficiaryInfo: String? = "اتوسا"
    var beneficiarySheba: String? = "IR123456789678901234"
    var beneficiaryBankName: String? = "بانک ملت"
    var issueDate: String? = "2024-07-15"
    var status: String? = "Pending"
    var statusDate: String? = "2024-07-15"
    var draftershaba: Int? = 2123123123213
    var payerid: Int? = 123456
    var dec: Int? = 9
    var envcode: Int? = 4

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1) // Fallback for .systemBackground

        // Add scrollView to the view
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)

        // Setup scrollView constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Setup containerView constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Get header view and rows detail
        let (headerView, rowsDetail) = getDetailRows()

        // Add header view
        containerView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            // Make the header taller
            headerView.heightAnchor.constraint(equalToConstant: 100) // Adjust height as needed
        ])

        // Add rows detail
        var previousView: UIView = headerView
        for row in rowsDetail {
            let rowView = createRowView(title: row.title, value: row.value)
            containerView.addSubview(rowView)
            rowView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                rowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
                rowView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 10),
                rowView.heightAnchor.constraint(equalToConstant: 40)
            ])
            previousView = rowView
        }

        // Add buttonStackView to containerView
        let buttonStackView = UIStackView(arrangedSubviews: [shareButton, pdfButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        containerView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            buttonStackView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Helper Methods

    private func makeButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.semanticContentAttribute = .forceRightToLeft // Ensure RTL support
        return button
    }

    private func createRowView(title: String, value: String) -> UIView {
        let rowView = UIView()
        rowView.layer.borderWidth = 1
        rowView.layer.borderColor = UIColor.lightGray.cgColor
        rowView.layer.cornerRadius = 5
        rowView.semanticContentAttribute = .forceRightToLeft // Ensure RTL support

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .right
        titleLabel.font = .systemFont(ofSize: 16)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textAlignment = .right
        valueLabel.font = .systemFont(ofSize: 16)

        rowView.addSubview(titleLabel)
        rowView.addSubview(valueLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: rowView.trailingAnchor, constant: -10),
            valueLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor)
        ])

        return rowView
    }

    // MARK: - Data Fetching Method

    func getDetailRows() -> (headerView: UIView, rowsDetail: [(title: String, value: String)]) {
        var rows = [(title: String, value: String)]()
        rows.append((title: "شماره حواله", value: "\(draftId ?? 0)"))
        rows.append((title: "شماره حساب مبدا", value: "\(draftershaba ?? 0)"))
        rows.append((title: "مبلغ حواله", value: "\(draftAmount ?? 0)"))
        rows.append((title: "مبلغ کارمزد", value: "\(incomeAmount ?? 0)"))
        rows.append((title: "نام ذینفع حواله", value: beneficiaryInfo ?? ""))
        rows.append((title: "شماره شبای مقصد", value: beneficiarySheba ?? ""))
        rows.append((title: "شناسه واریز", value: "\(payerid ?? 0)"))
        rows.append((title: "شرح مقصد", value: "\(dec ?? 0)"))
        rows.append((title: "نام بانک", value: beneficiaryBankName ?? ""))
        rows.append((title: "درگاه ثبت حواله", value: "\(envcode ?? 0)"))
        rows.append((title: "تاریخ صدور", value: issueDate ?? ""))
        rows.append((title: "وضعیت", value: status ?? ""))
        rows.append((title: "تاریخ وضعیت", value: statusDate ?? ""))

        return (headerView: createArchiveHeader(title: "", state: "SUCCESS", isTransaction: false, for: "CMD_REQUEST_SATNA_REPORT"), rowsDetail: rows)
    }

    // MARK: - Header Creation

    func createArchiveHeader(title: String, state: String, isTransaction: Bool, for command: String) -> UIView {
        let headerView = UIView()
        // Set background color for the header
        headerView.backgroundColor = .systemGray
        let titleLabel = UILabel()
        titleLabel.text = "گزارش پیش نویس حواله ساتنا"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 24) // Adjust font size as needed
        titleLabel.textColor = .orange
        headerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            // Add top and bottom margin to titleLabel
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 50), // Adjust the constant value as needed
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20) // Adjust the constant value as needed
        ])
        return headerView
    }
}
