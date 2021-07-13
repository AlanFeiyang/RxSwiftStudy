//
//  STHotNewsListTableViewCell.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/2/5.
//

import UIKit
import RxSwift
import Then
import SnapKit
import SDWebImage

let STHotNewsListImageViewTag = 66666

class STHotNewsListTableViewCell: UITableViewCell {
    //标题
    lazy var title = UILabel().then {
        $0.numberOfLines = 2
        $0.textColor = .TextMainColor
        $0.font = .mainFont
    }
    //来源
    lazy var source = UILabel().then {
        $0.textColor = .TextSubColor
        $0.textAlignment = .left
        $0.font = .listFont
    }
    //时间
    lazy var date = UILabel().then {
        $0.textColor = .TextSubColor
        $0.textAlignment = .left
        $0.font = .listFont
    }
    //浏览
    lazy var browse = UILabel().then {
        $0.textColor = .TextSubColor
        $0.textAlignment = .left
        $0.font = .listFont
    }
    //推荐
    lazy var recommend = UILabel().then {
        $0.textColor = .TextSubColor
        $0.textAlignment = .left
        $0.font = .listFont
    }
    //单图右侧图
    lazy var rightImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    //三图模式容器view
    lazy var imageBgView = UIView().then {
        $0.isHidden = true
    }
    

    var model:STHomeNewsListModel?{
        didSet{
            setupModel()
        }
    }
    
    func setupModel() {
        guard let model = model else{return}
        setupAutoLayout(model.title_page_pic_type, imageSize: model.imageSize)
        title.attributedText = model.title.makeMutableAttributed()
        date.text = model.publish_time.dateToShow()
        source.text = model.source.isEmpty ? model.account_nick_name : model.source
        browse.text = model.view_total.makeNumberToShow("浏览")
        recommend.text = model.prise_count.makeNumberToShow("推荐")
        
        
        for (i,item) in model.title_page_pic_files.enumerated(){
            let url = URL(string: item)
            if i == 0 {
                rightImageView.sd_setImage(with: url, placeholderImage: nil)
            }
            for subView in imageBgView.subviews{
                if let image = subView as? UIImageView, image.tag == STHotNewsListImageViewTag + i{
                    image.sd_setImage(with: url, placeholderImage: nil)
                }
            }
        }
    }
    
    
    
    func setupAutoLayout(_ type:Int,imageSize:CGSize) {
        contentView.subviews.forEach {
            $0.snp.removeConstraints()
        }
        
        var rightImageViewSzie = CGSize.zero
        var imageBgViewH:CGFloat = 0
        var imageBgViewT:CGFloat = 0
        var imageBgViewTopView:UIView = title
        switch type {
        case 0,1://单图
            rightImageViewSzie = imageSize
            rightImageView.isHidden = false
            imageBgView.isHidden = true
            imageBgViewTopView = rightImageView
        case 2://三图
            rightImageView.isHidden = true
            imageBgView.isHidden = false
            imageBgViewT = Space
            imageBgViewH = imageSize.height
        case 3://无图
            rightImageView.isHidden = true
            imageBgView.isHidden = true
        default:
            break
        }
        
        rightImageView.snp.remakeConstraints {
            $0.top.equalTo(Space)
            $0.right.equalTo(rightImageView.isHidden ? 0 : -Space)
            $0.width.equalTo(rightImageViewSzie.width)
            $0.height.equalTo(rightImageViewSzie.height)
        }
        
        title.snp.remakeConstraints {
            $0.left.top.equalTo(Space)
            $0.right.equalTo(rightImageView.snp.left).offset(-Space)
        }
        
        imageBgView.snp.remakeConstraints {
            $0.top.equalTo(imageBgViewTopView.snp.bottom).offset(imageBgViewT)
            $0.left.right.equalTo(0)
            $0.height.equalTo(imageBgViewH)
        }
        
        imageBgView.subviews.forEach { (subView) in
            let i = subView.tag - STHotNewsListImageViewTag
            let x = CGFloat(i) * (imageSize.width) + CGFloat(i + 1) * (Space)
//            subView.snp.remakeConstraints {
//                $0.left.equalTo(x)
//                $0.top.equalTo(0)
//                $0.width.equalTo(imageSize.width)
//                $0.height.equalTo(imageSize.height)
//            }
            subView.frame = CGRect(x: x, y: 0, width: imageSize.width, height: imageSize.height)
        }
        
        source.snp.remakeConstraints {
            $0.left.equalTo(Space)
            $0.top.equalTo(imageBgView.snp.bottom).offset(Space)
        }
        
        date.snp.remakeConstraints {
            $0.top.equalTo(source)
            $0.left.equalTo(source.snp.right).offset(Space)
        }
            
        recommend.snp.remakeConstraints {
            $0.top.equalTo(source)
            $0.right.equalTo(-Space)
        }
        
        browse.snp.remakeConstraints {
            $0.top.equalTo(source)
            $0.left.greaterThanOrEqualTo(date.snp.right).offset(Space)
            $0.right.equalTo(recommend.snp.left).offset(-Space)
//            $0.height.equalTo(17)
            $0.bottom.equalTo(-Space)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
        

    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(source)
        contentView.addSubview(date)
        contentView.addSubview(browse)
        contentView.addSubview(recommend)
        
        contentView.addSubview(rightImageView)
        contentView.addSubview(imageBgView)
        
        for i in 0...2{
            let imageView = UIImageView()
            imageView.tag = STHotNewsListImageViewTag + i
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 4
            imageView.layer.masksToBounds = true
            imageBgView.addSubview(imageView)
        }
        
        source.setContentCompressionResistancePriority(.init(740), for: .horizontal)
    }
}
