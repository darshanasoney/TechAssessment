//
//  ViewController.swift
//  TechAssessment
//
//  Created by Darshana  on 14/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageURLs : [UserPhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setData()
        self.RenderImages()
    }
    
    func setData() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func RenderImages() {
        
        self.getData { images,error  in
            if images.count > 0 {
                self.imageURLs = images
                self.collectionView.reloadData()
            } else {
                let vc = UIAlertController(title: "App", message: error?.localizedDescription, preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                    
                }))
                self.present(vc, animated: true)
            }
        }
    }
    
    func getData(completionHandler : @escaping (([UserPhoto], Error?) -> Void)) {
            
        guard let url = URL(string: apiURL) else {
            return
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler([], error)
                }
                return
            }
            guard data != nil else {
                let error = NSError(domain: "No Record Found", code: 200, userInfo: nil)
                DispatchQueue.main.async {
                    completionHandler([], error)
                }
                return
            }
            do {
                if let decodedData = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [NSDictionary] {
                    
                    let imageURLs = decodedData.map { obj in
                        return UserPhoto(profileDict: obj)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(imageURLs, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([], error)
                }
            }
        }.resume()
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell {
            
            cell.populate(user: imageURLs[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width / 2) - 10
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
