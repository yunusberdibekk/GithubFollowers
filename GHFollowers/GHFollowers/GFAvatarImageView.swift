//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 22.01.2024.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache // TODO: -Burada cache işlemini dışarı al. Download image işleminide image downloader adı altında dışarı al.
    let placeholderImage = UIImage(resource: .avatarPlaceholder)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}

extension GFAvatarImageView {
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
}
