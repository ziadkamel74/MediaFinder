//
//  MoviesCell.swift
//  RegistrationApp
//
//  Created by Ziad on 2/26/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit
import SDWebImage

class MediaCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var trackOrArtistNameLabel: UILabel!
    @IBOutlet weak var descriptionOrArtistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    @IBAction func ShakeButtonPressed(_ sender: UIButton) {
        mediaImageView.shake(0.05)
    }
    
    func configurecell(receivedMedia: ReceivedMedia) {
        mediaImageView.sd_setImage(with: URL(string: receivedMedia.imageURL))
        let kind = receivedMedia.getKind()
        if kind == Kind.tvShow.rawValue {
            trackOrArtistNameLabel.text = receivedMedia.artistName
        } else {
            trackOrArtistNameLabel.text = receivedMedia.trackName
        }
        if kind == Kind.music.rawValue {
            descriptionOrArtistNameLabel.text = receivedMedia.artistName
        } else {
            descriptionOrArtistNameLabel.text = receivedMedia.longDescription
        }
        
    }
    
    
}
