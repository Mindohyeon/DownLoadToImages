import UIKit
import SnapKit
import Then
class ImagesTableViewCell: UITableViewCell {
    static let identifier = "ImageTableViewCell"
    
    var index = 0
    
    private let downLoadImageView = UIImageView().then {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func loadButtonDidTap(_ sender: UIButton) {
        
        print(index)
        var url = ""
        switch index {
        case 0:
            url = "https://digitalauto.hyundaicapital.com//assets/images/potal/mainCarImg/IGJS.png"
        case 1:
            url = "http://www.dailyenews.co.kr/news/photo/202105/22354_19656_1216.jpg"
        case 2:
            url = "https://www.hyundai.com/contents/repn-car/side-45/avante-22my-45side.png"
        case 3:
            url = "https://blog.kakaocdn.net/dn/wH7Q6/btrh2ipZouW/siYgr5GUAHpr4NV3ib4Gyk/img.jpg"
        default:
            print("default")
        }
        
        downLoadImageView.load(url: URL(string: url)!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.downLoadImageView.image = UIImage(systemName: "photo")
        }
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
