import UIKit
import SnapKit
import Then
class ImagesTableViewCell: UITableViewCell, loadAllDelegate {
    let vc = ViewController()
    
    static let identifier = "ImageTableViewCell"
    
    private let url = URLStore.share
    
    var index = 0
    
    let downLoadImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
        $0.sizeToFit()
    }
    
    private let progressBarLine = UIProgressView().then {
        $0.progress = 0.5
        $0.progressTintColor = .blue
        $0.trackTintColor = .lightGray
    }
    
    lazy var loadButton = UIButton().then {
        $0.addTarget(self, action: #selector(loadButtonDidTap(_:)), for: .touchUpInside)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .blue
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Load", for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addView()
        setLayout()
        vc.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func loadButtonDidTap(_ sender: UIButton) {
        var urlString = ""
        
        print("index = \(index)")
        switch index {
        case 0:
            urlString = url.firstURL
        case 1:
            urlString = url.secondURL
        case 2:
            urlString = url.thirdURL
        case 3:
            urlString = url.fourthURL
        case 4:
            urlString = url.fifthURL
        default:
            print("default")
        }
        self.downLoadImageView.image = UIImage(systemName: "photo")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.downLoadImageView.load(url: URL(string: urlString)!)
        }
    }
    
    func loadAllButtonDidTap() {
        print("asdf")
        downLoadImageView.load(url: URL(string: "https://digitalauto.hyundaicapital.com//assets/images/potal/mainCarImg/IGJS.png")!)
    }
    
    private func addView() {
        contentView.addSubviews(downLoadImageView, progressBarLine, loadButton)
    }
    
    private func setLayout() {
        downLoadImageView.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.top.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(3)
        }
        
        progressBarLine.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(downLoadImageView.snp.trailing).offset(5)
            $0.trailing.equalTo(loadButton.snp.leading)
        }
        
        loadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(70)
            $0.height.equalTo(35)
        }
    }
}
