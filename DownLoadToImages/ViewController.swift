import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    private let imageTableView = UITableView().then {
        $0.rowHeight = 70
        $0.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.identifier)
    }
    
    private let loadAllButton = UIButton().then {
        $0.layer.cornerRadius = 7
        $0.backgroundColor = .blue
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Load All Images", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageTableView.dataSource = self
        
        addView()
        setLayout()
    }

    func addView() {
        view.addSubviews(imageTableView, loadAllButton)
    }
    
    func setLayout() {
        imageTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(loadAllButton.snp.top).inset(10)
        }
        
        loadAllButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(350)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImagesTableViewCell.identifier, for: indexPath) as? ImagesTableViewCell else { return UITableViewCell() }
        
        cell.index = indexPath.row
        return cell
    }

}
