//
//  EmployeeInfoCell.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation
import UIKit

class EmployeeInfoCell: UITableViewCell {
    
    
    // - MARK: Constants
    
    
    static let identifier = "EmployeeInfoCellReuseIdentifier"
    let horizontalPadding: CGFloat = 10.0
    let verticalPadding: CGFloat = 4.0
    
    
    // - MARK: Properties
    
    
    var biographyTextView: UITextView!
    var emailAddressLabel: UILabel!
    var loadingIndicator: UIActivityIndicatorView!
    var nameLabel: UILabel!
    var phoneNumberLabel: UILabel!
    var photoView: UIImageView!
    var teamLabel: UILabel!
    var typeLabel: UILabel!
    var employeeInfo: EmployeeInfo? {
        didSet {
            self.setNeedsLayout()
            PhotoDataProvider.shared
                .fetchPhoto(for: employeeInfo,
                            with: .large) { image in
                                DispatchQueue.main.async { [weak self] in
                                    self?.photoView.image = image
                                    self?.loadingIndicator.stopAnimating()
                                    self?.setNeedsDisplay()
                                }
            }
        }
    }
    
    
    // - MARK: Init
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        photoView = UIImageView()
        nameLabel = UILabel()
        teamLabel = UILabel()
        emailAddressLabel = UILabel()
        typeLabel = UILabel()
        phoneNumberLabel = UILabel()
        biographyTextView = UITextView()
        loadingIndicator = UIActivityIndicatorView()
        backgroundView = UIView(frame: .zero)
        addSubViews()
        setupLoadingIndicator()
        setupBiographyTextView()
        setupBackgroundView()
        photoView.contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // - MARK: Fileprivate Methods
    
    
    fileprivate func addSubViews() {
        addSubview(photoView)
        addSubview(nameLabel)
        addSubview(teamLabel)
        addSubview(emailAddressLabel)
        addSubview(typeLabel)
        addSubview(biographyTextView)
        addSubview(phoneNumberLabel)
        addSubview(loadingIndicator)
    }
    
    
    fileprivate func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .whiteLarge
        loadingIndicator.startAnimating()
    }
    
    
    fileprivate func setupBackgroundView() {
        backgroundColor = .black
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        backgroundView?.addSubview(blurEffectView)
    }
    
    
    fileprivate func setupBiographyTextView() {
        biographyTextView.isScrollEnabled = false
        biographyTextView.backgroundColor = UIColor.clear
        biographyTextView.isUserInteractionEnabled = false
        biographyTextView.textContainerInset = .zero
        biographyTextView.textContainer.lineFragmentPadding = 0;
    }
    
    
    // - MARK: Overrided Methods
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoView.image = nil
    }
    
    
    override func layoutSubviews() {
        let size = bounds.size
        
        loadingIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        photoView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height * ( 2.0 / 3.0))
        photoView.clipsToBounds = true

        nameLabel.attributedText = NSAttributedString.attributedString(title: employeeInfo?.fullName)
        emailAddressLabel.attributedText = NSAttributedString.attributedString(description: employeeInfo?.emailAddress)
        teamLabel.attributedText = NSAttributedString.attributedString(description: employeeInfo?.team)
        typeLabel.attributedText = NSAttributedString.attributedString(description: employeeInfo?.employeeType?.readableText)
        biographyTextView.attributedText = NSAttributedString.attributedString(description: employeeInfo?.biography)
        phoneNumberLabel.attributedText = NSAttributedString.attributedString(description: employeeInfo?.phoneNumber)
        
        nameLabel.sizeToFit()
        let nameLabelSize = nameLabel.bounds.size
        nameLabel.frame = CGRect(x: horizontalPadding,
                                 y: size.height * (2.0 / 3.0) - nameLabelSize.height,
                                 width: nameLabelSize.width,
                                 height: nameLabelSize.height)
        
        teamLabel.sizeToFit()
        teamLabel.frame = CGRect(x: horizontalPadding,
                                 y: nameLabel.frame.origin.y + nameLabel.frame.size.height + verticalPadding,
                                 width: teamLabel.bounds.width,
                                 height: teamLabel.bounds.height)
        
        typeLabel.sizeToFit()
        typeLabel.frame = CGRect(x: horizontalPadding,
                                 y: teamLabel.frame.origin.y + teamLabel.frame.size.height + verticalPadding,
                                 width: typeLabel.bounds.width,
                                 height: typeLabel.bounds.height)
        phoneNumberLabel.sizeToFit()
        phoneNumberLabel.frame = CGRect(x: horizontalPadding,
                                 y: typeLabel.frame.origin.y + typeLabel.frame.size.height + verticalPadding,
                                 width: phoneNumberLabel.bounds.width,
                                 height: phoneNumberLabel.bounds.height)
        
        emailAddressLabel.sizeToFit()
        emailAddressLabel.frame = CGRect(x: horizontalPadding,
                                         y: phoneNumberLabel.frame.origin.y + phoneNumberLabel.frame.size.height + verticalPadding,
                                         width: emailAddressLabel.bounds.width,
                                         height: emailAddressLabel.bounds.height)
        
        biographyTextView.frame = CGRect(x: horizontalPadding,
                                         y: emailAddressLabel.frame.origin.y + emailAddressLabel.frame.size.height + verticalPadding,
                                         width: size.width - 16,
                                         height: size.height * ( 1.0 / 3.0))
         backgroundView?.frame = bounds
         loadingIndicator.center = center
    }
    
   
}
