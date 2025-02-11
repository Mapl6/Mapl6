import UIKit
class SatnaDetailViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    private var mainView = UIView()
    private let tableView = UITableView()
   
    private let serviceTitleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "گزارش حواله ساتنا"
        titleLabel.frame.size.height    = 30.0
        titleLabel.font                 = .boldFontXLarg
        titleLabel.textColor            = .componentColorTangerineYellow
        titleLabel.textAlignment        = .center
        titleLabel.backgroundColor      = .baseColorGray
        return titleLabel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setUpView() {
        mainView
            .add(base: view)
            .top(to: view.topAnchor, constant: 0)
            .horizantal(to: view)
            .setBackground(color: .white)
            .closed()
        
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SatnaReportTableViewCell.self, forCellReuseIdentifier: "SatnaReportTableViewCell")
        mainView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        serviceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(serviceTitleLabel)
        NSLayoutConstraint.activate([
        serviceTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        serviceTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
          
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height - navBarHeight - tabBarHeight)
//            tableView.height(constant: view.frame.height - navBarHeight - tabBarHeight)
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
//            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -16)
        ])
    }
    // MARK: - UITableViewDataSource Methods

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SatnaReportTableViewCell", for: indexPath) as! SatnaReportTableViewCell
    
         
         cell.banktextField.text = "6037485721"
         cell.statustextField.text = "1"
         cell.shebatextField.text = "IR711254950637836904"
         
    

        
//       cell.contentView.addSubview(textField)
//
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            textField.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
//            textField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
//            textField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
//            textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
//        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = SatnaReciveViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
