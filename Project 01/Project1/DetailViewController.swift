//
//  DetailViewController.swift
//  Project1
//
//  Created by Roberts Kursitis on 20/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?
    let imageTitle = String()
    var totalPictures = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(selectedImage != nil, "no selected image")

        title = "Picture \(imageTitle)"
        navigationItem.largeTitleDisplayMode = .never

		if let imageToLoad = selectedImage {
			imageView.image  = UIImage(named: imageToLoad)
		}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
