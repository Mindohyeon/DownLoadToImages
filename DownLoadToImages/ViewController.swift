import UIKit
import SnapKit
import Then

protocol loadAllDelegate: AnyObject {
    func loadAllButtonDidTap()
}

class ViewController: UIViewController {
    weak var delegate: loadAllDelegate?
    
    var imageUrl: [String] {
        return [
            "https://digitalauto.hyundaicapital.com//assets/images/potal/mainCarImg/IGJS.png",
            "http://www.dailyenews.co.kr/news/photo/202105/22354_19656_1216.jpg",
            "https://www.hyundai.com/contents/repn-car/side-45/avante-22my-45side.png",
            "https://blog.kakaocdn.net/dn/wH7Q6/btrh2ipZouW/siYgr5GUAHpr4NV3ib4Gyk/img.jpg",
            "https://digitalauto.hyundaicapital.com//assets/images/potal/mainCarImg/IGJS.png"
        ]
    }
    private let imageTableView = UITableView().then {
        $0.rowHeight = 70
        $0.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.identifier)
    }
    
    private lazy var loadAllButton = UIButton().then {
        $0.addTarget(self, action: #selector(loadAllButtonDidTap(_:)), for: .touchUpInside)
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
    
    @objc private func loadAllButtonDidTap(_ sender: UIButton) {
        for i in 0..<5 {
            DispatchQueue.main.async {
                if let cell = self.imageTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? ImagesTableViewCell {
                    cell.downLoadImageView.image = UIImage(systemName: "photo")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                        cell.downLoadImageView.load(url: URL(string: self.imageUrl[i])!)
                    }
                }
            }
        }
        
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
