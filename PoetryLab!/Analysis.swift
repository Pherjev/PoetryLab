//
//  Analysis.swift
//  PoetryLab!
//
//  Created by Bernbel Aguilar on 16/10/20.
//

import UIKit

class Analysis: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
   
    var control = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
      //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
      //layout.minimumLineSpacing = 0
      //layout.minimumInteritemSpacing = 0
        print("_________________")
        print(parrafos)
    }
    
   override func viewWillDisappear(_ animated: Bool) {
     // parrafos = [String]()
   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Analysis: UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("Selected:" + String(indexPath.row))
   }
   
}

extension Analysis: UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return parrafos.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //print(indexPath.row)
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath)
      if cell.isHidden {
         for subview in cell.contentView.subviews {
            if subview.isKind(of: UILabel.self) {
               subview.removeFromSuperview()
               break
            }
         }
      }
      
      let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width - 200, height: 300))
      //(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
      titleLabel.clearsContextBeforeDrawing = true
      titleLabel.text = ""
      //print(parrafos.count)
      titleLabel.text = parrafos[indexPath.row]
      //print(parrafos[indexPath.row])
      titleLabel.textAlignment = .center
      titleLabel.numberOfLines = 10
      
      cell.contentView.addSubview(titleLabel)
      /*
      titleLabel.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
      titleLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
      titleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
      titleLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
      */
      let rimaL = UILabel(frame: CGRect(x: cell.bounds.width - 300, y: 0, width: 10, height: 300))
      rimaL.backgroundColor = .blue
      //cell.contentView.addSubview(rimaL)
      
      //rimaL.translatesAutoresizingMaskIntoConstraints = false
      //titleLabel.translatesAutoresizingMaskIntoConstraints = false
      
      
      
      //let horizontalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
      //let verticalConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
      //let widthConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0)
      //let heightConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0)
      //NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
          
      //cell.backgroundColor = UIColor(white: 1, alpha: 0)
      return cell
   }
   
}

extension Analysis: UICollectionViewDelegateFlowLayout {
   
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      
      return CGSize(width: UIScreen.main.bounds.width-200, height: 300)
   }

   
   
}
