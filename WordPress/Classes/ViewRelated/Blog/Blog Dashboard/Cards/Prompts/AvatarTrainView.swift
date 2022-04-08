import UIKit

/// A view that shows a train of faces.
///
final class AvatarTrainView: UIView {

    // MARK: Private Properties

    private var avatarURLs: [URL?]

    private lazy var avatarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Constants.spacing

        return stackView
    }()

    /// The border layer "cuts" into the image height, reducing the displayable area.
    /// Therefore, we need to account for the border width (on both sides) to keep the image displayed in the intended size.
    var imageHeight: CGFloat {
        Constants.avatarDiameter + (2 * Constants.borderWidth)
    }

    // MARK: Public Methods

    init(avatarURLs: [URL?]) {
        self.avatarURLs = avatarURLs
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // redraw border when user interface style changes.
        if let previousTraitCollection = previousTraitCollection,
            previousTraitCollection.userInterfaceStyle != traitCollection.userInterfaceStyle {
            avatarStackView.subviews.forEach { configureBorder(for: $0) }
        }
    }

}

// MARK: Private Helpers

private extension AvatarTrainView {

    func setupViews() {
        addSubview(avatarStackView)
        pinSubviewToAllEdges(avatarStackView)
        avatarStackView.addArrangedSubviews(avatarURLs.map { makeAvatarImageView(with: $0) })
    }

    func makeAvatarImageView(with avatarURL: URL? = nil) -> UIImageView {
        let imageView = CircularImageView(image: Constants.placeholderImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        configureBorder(for: imageView)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])

        if let avatarURL = avatarURL {
            imageView.downloadImage(from: avatarURL, placeholderImage: Constants.placeholderImage)
        }

        return imageView
    }

    func configureBorder(for view: UIView) {
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = UIColor.listForeground.cgColor
    }

    // MARK: Constants

    struct Constants {
        static let spacing: CGFloat = -4
        static let avatarDiameter: CGFloat = 20
        static let borderWidth: CGFloat = 2
        static let placeholderImage: UIImage = .gravatarPlaceholderImage
    }

}
