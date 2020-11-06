//
//  ViewController.swift
//  PoetryLab!
//
//  Created by Bernbel Aguilar on 25/09/20.
//

import UIKit
import SwiftUI
import AVFoundation

public var parrafos: [String] = [String]()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {



   @IBOutlet weak var leading: NSLayoutConstraint!
   @IBOutlet weak var trailing: NSLayoutConstraint!
   @IBOutlet weak var widthTable: NSLayoutConstraint!
   @IBOutlet weak var texto: UITextView!
   @IBOutlet weak var table: UITableView!
   @IBOutlet weak var view2: UIView!
      
   @IBOutlet weak var titulo: UITextView!
   @IBOutlet var v1: UIView!
   @IBOutlet var blurv1: UIVisualEffectView!
   @IBOutlet weak var sharebutton: UIBarButtonItem!
   
   
   @IBOutlet weak var picker: UIPickerView!
   @IBOutlet weak var seleccioneTipo: UILabel!
   
   @IBOutlet weak var lateralDerecho: UITextView!
   @IBOutlet weak var reglita: UIBarButtonItem!
   
   
   var menuOut = false
   
   
   let defaults = UserDefaults.standard
   var titulos = ["Poema 1"]
   //var images = ["pexels-pixabay-261763.jpg","pexels-pixabay-261763.jpg"]
   
   
   var selectedFont = "AmericanTypewriter"//"Baskerville"
   
   var indice = 0
   
   var pickerData: [String] = [String]()
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
      
      edgePan.edges = .left
      view.addGestureRecognizer(edgePan)
      
      let SwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(tableSwiped))
      
      let SwipeRight2 = UISwipeGestureRecognizer(target: self, action: #selector(tableSwiped2))
      
      SwipeRight.direction = .left
      SwipeRight2.direction = .left
      
      
      table.addGestureRecognizer(SwipeRight)
      view2.addGestureRecognizer(SwipeRight2)
      
      let screenSize: CGRect = UIScreen.main.bounds
      
      widthTable.constant = screenSize.width / 3
      
      //print(widthTable.constant)
      //texto.attributedText = addBoldText(fullString: "Escriba su título \n\nEscriba su poema", boldPartOfString: "Escriba su título", baseFont: UIFont(name: "Baskerville", size: 20)!, boldFont: UIFont(name: "Baskerville-Bold", size: 25)!)
      //texto.textAlignment = .center
      
      //self.table.register(UITableViewCell.self, forCellReuseIdentifier: "celda")
      
      
      
      
      //print(texto.text!)
      
      texto.delegate = self
      titulo.delegate = self
      lateralDerecho.delegate = self
      //textViewDidBeginEditing(texto)
      //textViewDidBeginEditing(titulo)
      //textViewDidEndEditing(texto)
      
      //printFonts()
      blurv1.bounds = self.view.bounds
      
      picker.delegate = self
      picker.dataSource = self
      
      pickerData = ["AmericanTypewriter", "AppleSDGothicNeo","AlNile","Arial","ArialHebrew","AvenirNext","AvenirNextCondensed","Baskerville","BodoniSvtyTwoITCTT","BodoniSvtyTwoOSITCTT","BradleyHandITCTT","Copperplate","ChalkboardSE","Charter","Cochin","Courier","CourierNewPS","Didot","DINAlternate","DINCondensed","DevanagariSangamMN","EuphemiaUCAS","Futura","Galvji","GeezaPro","Georgia","GillSans","Helvetica","HelveticaNeue","Kailasa","KohinoorGujarati","MalayalamSangamMN","Menlo","MyanmarSangamMN","Noteworthy","NotoNastaliqUrdu","NotoSansKannada","NotoSansMyanmar","Optima","Rockwell","SinhalaSangamMN","SnellRoundhand","TamilSangamMN","Thonburi","TimesNewRomanPS","TrebuchetMS","Verdana"]
      
      
      let maintxt = "main.txt"
      
      let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
      let url = NSURL(fileURLWithPath: path)
      if let pathComponet = url.appendingPathComponent(maintxt) {
         let filePath = pathComponet.path
         let fileManager = FileManager.default
         if fileManager.fileExists(atPath: filePath) {
            //savetxt(name:maintxt, text: "")
            //let defaults = UserDefaults.standard
            titulos = defaults.stringArray(forKey: "titulos") ?? titulos
            
            indice = defaults.integer(forKey: "indice")
            
            selectedFont = defaults.string(forKey: "selectedFont") ?? selectedFont
            
            let font1 = UIFont(name: selectedFont + "-Bold", size: 25)! // bold
            
            let quote1 = defaults.string(forKey: "titulo") ?? "Escriba su título"
            
            let attributes1 = [NSAttributedString.Key.font: font1]
            let attributedQuote1 = NSAttributedString(string: quote1,attributes: attributes1)
            titulo.attributedText = attributedQuote1
            titulo.textColor = UIColor.black
            titulo.textAlignment = .center
            
            let font2 = UIFont(name: selectedFont, size: 20)!
            
            let quote2 = defaults.string(forKey: "texto") ?? "Redacte sus versos"
            
            let attributes2 = [NSAttributedString.Key.font: font2]
            let attributedQuote2 = NSAttributedString(string: quote2,attributes: attributes2)
            texto.attributedText = attributedQuote2
            texto.textColor = UIColor.black
            texto.textAlignment = .center
            
            
            let attributedQuote3 = NSAttributedString(string: "",attributes: attributes2)
            lateralDerecho.textAlignment = .center
            lateralDerecho.attributedText = attributedQuote3
            
         } else { // Verificar si es lo más eficiente
            //titulos = ["Lizeth","Hernandez"]
            print("BIENVENIDO")
            savetxt(name:maintxt, text: "1")
            let font1 = UIFont(name: selectedFont + "-Bold", size: 25)! // bold
            
            let quote1 = "Escriba su título"
            
            let attributes1 = [NSAttributedString.Key.font: font1]
            let attributedQuote1 = NSAttributedString(string: quote1,attributes: attributes1)
            titulo.attributedText = attributedQuote1
            titulo.textColor = UIColor.lightGray
            titulo.textAlignment = .center
            
            let font2 = UIFont(name: selectedFont, size: 20)!
            
            let quote2 = "Redacte sus versos"
            
            let attributes2 = [NSAttributedString.Key.font: font2]
            let attributedQuote2 = NSAttributedString(string: quote2,attributes: attributes2)
            texto.attributedText = attributedQuote2
            texto.textColor = UIColor.lightGray
            texto.textAlignment = .center
            
            let attributedQuote3 = NSAttributedString(string: "",attributes: attributes2)
            lateralDerecho.textAlignment = .center
            lateralDerecho.attributedText = attributedQuote3
            
            
         }
      }
      
      //self.reglita.title = "􀟀"
      
      
      
      
   }
      
   override func viewWillAppear(_ animated: Bool) {
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      NotificationCenter.default.removeObserver(self)
   }
   
   
   @IBAction func typography(_ sender: Any) {
      //print("Lizzy")
      openView(v: self.blurv1)
      openView(v: self.v1)
      
      //printFonts()
      
      //let file = "prueba.rtf"
      //openFile(file: file, tV: self.texto)
      
      /*
      if let rtfPath = Bundle.main.url(forResource: "prueba", withExtension: "rtf") {
              do {
                  let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
               print(attributedStringWithRtf.string)
                  self.texto.attributedText = attributedStringWithRtf
              } catch let error {
                  print("Got an error \(error)")
              }
      } else {
         print("No hay")
      }
      */
   }
   
   @IBAction func share(_ sender: Any) {
      print("Iniciando")
      let txt = titulo.text + "\n\n" + texto.text
      let textShare = [txt]
      let activityViewController = UIActivityViewController(activityItems: textShare, applicationActivities: nil)
      activityViewController.popoverPresentationController?.sourceView = self.view
      activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.center.x*2 - 137, y: -30, width: 100, height: 100) //self.sharebutton.accessibilityFrame
      self.present(activityViewController, animated: true, completion: nil)
   }
   
   
   let poemas = ["Flor.txt","Viejas_Raices_Empolvadas.txt","haiku_Issa.txt","Entre_ir_y_quedarse.txt","Sonatina.txt"]
   let poemasTitulos = ["Flor (Griseida Álvarez)","Viejas Raíces Empolvadas (Guadalupe Amor)","Haiku (Issa Kobayashi)","Entre ir y quedarse (Octavio Paz)","Sonatina (Rubén Darío)"]
   
   @IBAction func randomPoem(_ sender: Any) {
      // Genera un poema aleatorio
      /*
      let url = URL(string: "https://raw.githubusercontent.com/Pherjev/PoetryLab/main/Flor.txt")
      FileDownloader.loadFileAsync(url: url!) { (path, error) in
         print("PDF File downloaded to : \(path!)")
         let tex = self.opentxt(name: "Flor.txt")
         print(tex)
         //self.texto.text = tex
      }*/
      
      let randomInt = Int.random(in: 0..<poemas.count)
      
      let poema = poemas[randomInt]
      let titlePoem = poemasTitulos[randomInt]
      
      defaults.setValue(texto.text, forKey: "texto")
      defaults.setValue(titulo.text, forKey: "titulo")
      
      /*
      let T = titulo.text
      print(indice)
      if titulos[indice] != T && T != "Escriba su título" {
         table.beginUpdates()
         titulos[indice] = T!
         defaults.setValue(titulos, forKey: "titulos")
         table.reloadData()
         table.endUpdates()
      }*/
      
      
      let file1 = String(indice) + ".rtf"
      saveFile(file: file1, tV: texto)
      let file2 = String(indice) + "T.rtf"
      saveFile(file: file2, tV: titulo)
      
      
      indice = titulos.count
      defaults.setValue(indice, forKey: "indice")
      titulos.append(titlePoem)
      table.beginUpdates()
      table.insertRows(at: [IndexPath(row:titulos.count-1,section: 0)], with: .automatic)
      defaults.setValue(titulos, forKey: "titulos")
      table.endUpdates()
      
      /*
      file1 = String(indice) + ".rtf"
      saveFile(file: file1, tV: texto)
      file2 = String(indice) + "T.rtf"
      saveFile(file: file2, tV: titulo)
    */
      table.selectRow(at: NSIndexPath(row: titulos.count-1, section: 0) as IndexPath, animated: false, scrollPosition: .middle)
      
      titulo.text = nil
      texto.text = nil
      
      var font1 = UIFont(name: selectedFont + "-Bold", size: 25)!
      
      if selectedFont == "CourierNewPS" || selectedFont == "TimesNewRomanPS" || selectedFont == "Arial" {
         font1 = UIFont(name: selectedFont + "-BoldMT", size: 25)! // bold
      }
      
      //let font1 = UIFont(name: selectedFont + "-Bold", size: 25)! // bold
      
      //let quote1 = "Escriba su título"
      
      let attributes1 = [NSAttributedString.Key.font: font1]
      let attributedQuote1 = NSAttributedString(string: titlePoem,attributes: attributes1)
      titulo.attributedText = attributedQuote1
      //titulo.textColor = UIColor.lightGray
      titulo.textAlignment = .center
      
      let font2 = UIFont(name: selectedFont, size: 20)!
      
      let quote2 = "Cargando..."
      
      let attributes2 = [NSAttributedString.Key.font: font2]
      let attributedQuote2 = NSAttributedString(string: quote2,attributes: attributes2)
      texto.attributedText = attributedQuote2
      //texto.textColor = UIColor.lightGray
      texto.textAlignment = .center
      
      var output = "¡Oh! ¡La regamos!. Pruebe apretando el botón después de esperar unos segundos. \n Envíe un correo con un screenshot al correo pherjev@gmail.com si el problema persiste para que podamos hacernos cargo"
      let url = URL(string:"https://raw.githubusercontent.com/Pherjev/PoetryLab/main/" + poema)!
      let task = URLSession.shared.dataTask(with:url) { (data, response, error) in
          if error != nil {
             print(error!)
          }
          else {
             if let textFile = String(data: data!, encoding: .utf8) {
               //print(textFile)
               output = textFile
               //print(output)
             }
             //print(output)
          }
         //print(output)
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:
                                       {
                                          //print("FINIS")
                                          self.texto.text = output
                                          //print(output)
                                       }
                                    )
      
      //'print(output)
      task.resume()
      
      //self.texto.text = output
      
   }
   
   let ABC = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","Y","Z","W"]
   
   @IBAction func rima(_ sender: Any) {
      let t = texto.text
      let newLineChars = NSMutableCharacterSet.newline()
      let lineArray = t?.components(separatedBy: newLineChars as CharacterSet)//.filter{!$0.isEmpty}
      //print(lineArray ?? "ERROR")
      var finales: [String] = [String]()
      var rhymeStruct = ""
      var diccionario: [String: Int] = [:]
      var c = 0
      for line in lineArray! {
         
         //print(line)
         if line == "" || line == "\n" || line == " " {
            //print("------")
            rhymeStruct += "\n"
         } else {
         
            let splited = line.components(separatedBy: [" ",",","!","?",".",":",";"])
            var final = splited[splited.count-1]
            if final == "" {
               final = splited[splited.count-2]
            }
            finales.append(final)
            //print(hyphenization(word: final))
            let ac = acento(word: final)
            let ter = final.substring(from:ac,to:final.count-1)
            //print(ter)
         
            if diccionario[ter] == nil {
               diccionario[ter] = c
               rhymeStruct += ABC[c % 26] + "\n"
               c += 1
            } else {
               rhymeStruct += ABC[(diccionario[ter] ?? c) % 26] + "\n"
            }
         }
      
      }
      
      let font2 = UIFont(name: selectedFont, size: 20)!
      
      let attributes2 = [NSAttributedString.Key.font: font2]
      let attributedQuote3 = NSAttributedString(string: rhymeStruct,attributes: attributes2)
      lateralDerecho.textAlignment = .center
      lateralDerecho.attributedText = attributedQuote3
      
      //self.lateralDerecho.text = rhymeStruct // REVISAR
      //print(rhymeStruct)
   }
   
   
   
   @IBAction func métrica(_ sender: Any) {
      var t = texto.text
      
      t = t?.replacingOccurrences(of: ",", with: "")
      t = t?.replacingOccurrences(of: ".", with: "")
      t = t?.replacingOccurrences(of: "–", with: "")
      t = t?.replacingOccurrences(of: ":", with: "")
      t = t?.replacingOccurrences(of: ";", with: "")
      t = t?.replacingOccurrences(of: "h", with: "")
      
      let newLineChars = NSMutableCharacterSet.newline()
      let lineArray = t?.components(separatedBy: newLineChars as CharacterSet)//.filter{!$0.isEmpty}
      //print(lineArray ?? "ERROR")
      var metric = ""
      //var diccionario: [String: Int] = [:]
      
      var A : [Int] = [Int]() // COTAS INFERIORES
      var B : [Int] = [Int]() // COTAS SUPERIORES
      
      
      for line in lineArray! {
         
         //print(line)
         if line == "" || line == "\n" || line == " " {
            print("Lizeth")
            
         } else {
               
            
            let splited = line.components(separatedBy: [" ",",","!","?",".",":",";"])
            
            var sum = 0
            var res = 0
            var sinalefa = 0 // contador de las vocales para Sinalefa
            var FDF = 0
            // REGLAS DE LA MÉTRICA
            
            // Primera: Sumar todas las sílabas
            
            for words in splited {
               //print(words)
               //print(hyphenization(word: words).count)
               if words != "" && words != " "  {
                  sum += hyphenization(word: words).count
               }
               // Segunda: Sinalefa
               // Excepciones: - F D F
               //              - Acentuación en alguna
               
               if sinalefa == 0 {
                  if vocalesAbiertas.contains(String(words.last ?? " ")) || semivocales.contains(String(words.last ?? " ")) || words == "y" {
                     sinalefa = 1
                     //print(words)
                     if vocalesAbiertas.contains(String(words.last ?? " ")) {
                        FDF = 1
                     }
                  }
                  
               } else if sinalefa == 1 {
                  if words == "a" || words == "e" || words == "o" {
                     sinalefa = 2
                  } else if words == "y" || words == "i" || words == "u" {
                     sinalefa = 2
                     FDF = 2
                  } else if vocalesAbiertas.contains(String(words.first ?? " ")) || semivocales.contains(String(words.first ?? " ")) {
                     sinalefa = 0
                     res += 1
                     if vocalesAbiertas.contains(String(words.last ?? " ")) || semivocales.contains(String(words.last ?? " ")) || words == "y" {
                        sinalefa = 1
                        //print(words)
                        if vocalesAbiertas.contains(String(words.last ?? " ")) {
                           FDF = 1
                        }
                     }
                     
                  } else {
                     //print(words)
                     sinalefa = 0
                     if vocalesAbiertas.contains(String(words.last ?? " ")) || semivocales.contains(String(words.last ?? " ")) || words == "y" {
                        sinalefa = 1
                        //print(words)
                        if vocalesAbiertas.contains(String(words.last ?? " ")) {
                           FDF = 1
                        }
                     }
                  }
               } else if sinalefa == 2 {
                  if vocalesAbiertas.contains(String(words.first ?? " ")) || semivocales.contains(String(words.first ?? " ")) {
                     
                     if FDF == 2 {
                        if vocalesAbiertas.contains(String(words.first ?? " ")) {
                           res += 1
                        } else {
                           res += 2
                        }
                        
                     } else {
                        res += 2
                     }
                     sinalefa = 0
                     
                     if vocalesAbiertas.contains(String(words.last ?? " ")) || semivocales.contains(String(words.last ?? " ")) || words == "y" {
                        sinalefa = 1
                        //print(words)
                        if vocalesAbiertas.contains(String(words.last ?? " ")) {
                           FDF = 1
                        }
                     }
                     
                  } else {
                     sinalefa = 0
                     res += 1
                     
                     if vocalesAbiertas.contains(String(words.last ?? " ")) || semivocales.contains(String(words.last ?? " ")) || words == "y" {
                        sinalefa = 1
                        //print(words)
                        if vocalesAbiertas.contains(String(words.last ?? " ")) {
                           FDF = 1
                        }
                     }
                  }
               }
               
               
            }
            
            
            
            
            // Tercera: Aguda suma, esdrújula resta
            
            var final = splited[splited.count-1]
            if final == "" {
               final = splited[splited.count-2]
            }
            
            var ac = tilde(word: final)
            
            if ac == -1 {
               ac = prosódico(word: final)
            }
            
            if ac == 1 {
               sum += 1
            } else if ac > 2 {
               sum -= 1
            }
            
            //finales.append(final)
            //print(hyphenization(word: final))
            //print(ter)
            print("----------")
            print("[" + String(sum-res) + "," + String(sum) + "]")
            A.append(sum-res)
            B.append(sum)
         }
         
         
      }
      
      
      let a = A.max()
      let b = B.min()
      
      if a ?? 0 < b ?? 0 {
         
         let m = Int((b!+a!)/2)
         
         for line in lineArray! {
            
            //print(line)
            if line == "" || line == "\n" || line == " " {
               //print("------")
               metric += "\n"
            } else {
               metric += String(m) + "\n"
            }
         }
      } else {
         
         var j = 0
         
         for line in lineArray! {
            
            //print(line)
            if line == "" || line == "\n" || line == " " {
               //print("------")
               metric += "\n"
            } else {
               //print(j)
               //print(line)
               metric += String(A[j]) + "\n"
               j += 1
            }
            
         }
      }
   
      
      let font2 = UIFont(name: selectedFont, size: 20)!
      
      let attributes2 = [NSAttributedString.Key.font: font2]
      let attributedQuote3 = NSAttributedString(string: metric,attributes: attributes2)
      lateralDerecho.textAlignment = .center
      lateralDerecho.attributedText = attributedQuote3
   }
   
   
   @IBAction func closeV1(_ sender: Any) {
      closeView(v: self.v1)
      closeView(v: self.blurv1)
   }
   
   @IBAction func menuMas(_ sender: Any) {
      
      if !menuOut {
         deslizar1()
         menuOut = true
         UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations:
                           {
                              self.view.layoutIfNeeded()
                           })
      } /*else {
         deslizar2()
         menuOut = false
      }*/
      
      defaults.setValue(texto.text, forKey: "texto")
      defaults.setValue(titulo.text, forKey: "titulo")
      
      let T = titulo.text
      print(indice)
      if titulos[indice] != T && T != "Escriba su título" {
         table.beginUpdates()
         titulos[indice] = T!
         defaults.setValue(titulos, forKey: "titulos")
         table.reloadData()
         table.endUpdates()
      }
      
      
      let file1 = String(indice) + ".rtf"
      saveFile(file: file1, tV: texto)
      let file2 = String(indice) + "T.rtf"
      saveFile(file: file2, tV: titulo)
      
      
      indice = titulos.count
      defaults.setValue(indice, forKey: "indice")
      titulos.append("Poema " + String(indice + 1))
      table.beginUpdates()
      table.insertRows(at: [IndexPath(row:titulos.count-1,section: 0)], with: .automatic)
      defaults.setValue(titulos, forKey: "titulos")
      table.endUpdates()
      
      /*
      file1 = String(indice) + ".rtf"
      saveFile(file: file1, tV: texto)
      file2 = String(indice) + "T.rtf"
      saveFile(file: file2, tV: titulo)
    */
      table.selectRow(at: NSIndexPath(row: titulos.count-1, section: 0) as IndexPath, animated: false, scrollPosition: .middle)
      
      titulo.text = nil
      texto.text = nil
      
      var font1 = UIFont(name: selectedFont + "-Bold", size: 25)!
      
      if selectedFont == "CourierNewPS" || selectedFont == "TimesNewRomanPS" || selectedFont == "Arial" {
         font1 = UIFont(name: selectedFont + "-BoldMT", size: 25)! // bold
      }
      
      //let font1 = UIFont(name: selectedFont + "-Bold", size: 25)! // bold
      
      let quote1 = "Escriba su título"
      
      let attributes1 = [NSAttributedString.Key.font: font1]
      let attributedQuote1 = NSAttributedString(string: quote1,attributes: attributes1)
      titulo.attributedText = attributedQuote1
      titulo.textColor = UIColor.lightGray
      titulo.textAlignment = .center
      
      let font2 = UIFont(name: selectedFont, size: 20)!
      
      let quote2 = "Redacte sus versos"
      
      let attributes2 = [NSAttributedString.Key.font: font2]
      let attributedQuote2 = NSAttributedString(string: quote2,attributes: attributes2)
      texto.attributedText = attributedQuote2
      texto.textColor = UIColor.lightGray
      texto.textAlignment = .center
      
      let attributedQuote3 = NSAttributedString(string: "",attributes: attributes2)
      lateralDerecho.textAlignment = .center
      lateralDerecho.attributedText = attributedQuote3
      
   }
   
   
   @IBAction func save(_ sender: Any) {
      guardar()
      
   }

   
   
   
   
   @IBAction func analitica(_ sender: Any) {
      parrafos = [String]()
      let t = texto.text
      let newLineChars = NSMutableCharacterSet.newline()
      let lineArray = t?.components(separatedBy: newLineChars as CharacterSet)//.filter{!$0.isEmpty}
      //print(lineArray ?? "ERROR")
      var finales: [String] = [String]()
      var rhymeStruct = ""
      var diccionario: [String: Int] = [:]
      var c = 0
      var parr = ""
      
      for line in lineArray! {
         
         //print(line)
         if line == "" || line == "\n" || line == " " {
            //print("Pisté")
            rhymeStruct += "\n"
            parrafos.append(parr)
            parr = ""
         } else {
            parr += line + "\n"
            let splited = line.components(separatedBy: [" ",",","!","?",".",":",";"])
            var final = splited[splited.count-1]
            if final == "" {
               final = splited[splited.count-2]
            }
            finales.append(final)
            //print(hyphenization(word: final))
            let ac = acento(word: final)
            let ter = final.substring(from:ac,to:final.count-1)
            //print(ter)
         
            if diccionario[ter] == nil {
               diccionario[ter] = c
               rhymeStruct += ABC[c % 26] + "\n"
               c += 1
            } else {
               rhymeStruct += ABC[(diccionario[ter] ?? c) % 26] + "\n"
            }
         }
      
      }
      print("Lizzyyy")
      //let storyBoard = UIStoryboard(name:"Main", bundle: nil)
      guard let newViewController = storyboard?.instantiateViewController(identifier: "analysis", creator: nil) else { return  }
      self.present(newViewController, animated: true, completion: nil)
      
   }
   
   
   @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
      if recognizer.state == .recognized {
         if !menuOut {
            deslizar1()
            menuOut = true
         }
      }
      UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations:
                        {
                           self.view.layoutIfNeeded()
                        })
   }
   
   @objc func tableSwiped(_ recognizer: UISwipeGestureRecognizer) {
      //print("Lizzy hot")
      if recognizer.state == .recognized {
         if menuOut {
            deslizar2()
            menuOut = false
         }
      }
      UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations:
                        {
                           self.view.layoutIfNeeded()
                        })
   }
   
   @objc func tableSwiped2(_ recognizer: UISwipeGestureRecognizer) {
      //print("Lizzy hot")
      if recognizer.state == .recognized {
         //print("Lizzy hot2")
         if menuOut {
            deslizar2()
            menuOut = false
         }
      }
      UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations:
                        {
                           self.view.layoutIfNeeded()
                        })
   }

   
   @objc func keyboardWillAppear(_ notification: NSNotification) {
      guard let userInfo = notification.userInfo else { return }
          var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
          keyboardFrame = self.view.convert(keyboardFrame, from: nil)

          var contentInset:UIEdgeInsets = self.texto.contentInset
          contentInset.bottom = keyboardFrame.size.height + 20
          texto.contentInset = contentInset
      
   }
   
   @objc func keyboardWillDisappear(_ notification: NSNotification) {
      let contentInset:UIEdgeInsets = UIEdgeInsets.zero
      self.texto.contentInset = contentInset
      
   }
   
   
   
   
   func deslizar1() {
      leading.constant = widthTable.constant + 10
      trailing.constant = -widthTable.constant - 10
   }
   
   func deslizar2() {
      leading.constant = 0
      trailing.constant = 0
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return titulos.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = table.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCell
      cell.label1Cell.text = titulos[indexPath.row]
      cell.imageCell.image = UIImage(named: "pexels-pixabay-261763.jpg")
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //print(indexPath.row)
      
      //guardar() IMPLEMENTAR CON CUIDADO
      
      indice = indexPath.row
      defaults.setValue(indice, forKey: "indice")
      let file1 = String(indice) + ".rtf"
      
      let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
      let url = NSURL(fileURLWithPath: path)
      if let pathComponet = url.appendingPathComponent(file1) {
         let filePath = pathComponet.path
         let fileManager = FileManager.default
         if fileManager.fileExists(atPath: filePath) {
            openFile(file: file1, tV: texto)
            let file2 = String(indice) + "T.rtf"
            openFile(file: file2, tV: titulo)
            
            // Problema: Las fuentes almacenadas deberían establecerse
            
            let font2 = UIFont(name: selectedFont, size: 20)!
            let attributes = [NSAttributedString.Key.font: font2]
            
            let attributedQuote3 = NSAttributedString(string: "",attributes: attributes)
            lateralDerecho.textAlignment = .center
            lateralDerecho.attributedText = attributedQuote3
            
         } else {
            titulo.text = nil
            texto.text = nil
            
            var font1 = UIFont(name: selectedFont + "-Bold", size: 25)! // bold
            
            if selectedFont == "CourierNewPS" || selectedFont == "TimesNewRomanPS" || selectedFont == "Arial" {
               font1 = UIFont(name: selectedFont + "-BoldMT", size: 25)! // bold
            }
            
            let quote1 = "Escriba su título"
            
            let attributes1 = [NSAttributedString.Key.font: font1]
            let attributedQuote1 = NSAttributedString(string: quote1,attributes: attributes1)
            titulo.attributedText = attributedQuote1
            titulo.textColor = UIColor.lightGray
            titulo.textAlignment = .center
            
            let font2 = UIFont(name: selectedFont, size: 20)!
            
            let quote2 = "Redacte sus versos"
            
            let attributes2 = [NSAttributedString.Key.font: font2]
            let attributedQuote2 = NSAttributedString(string: quote2,attributes: attributes2)
            texto.attributedText = attributedQuote2
            texto.textColor = UIColor.lightGray
            texto.textAlignment = .center
            
            let attributedQuote3 = NSAttributedString(string: "",attributes: attributes2)
            lateralDerecho.textAlignment = .center
            lateralDerecho.attributedText = attributedQuote3
         }
      }
   
      defaults.setValue(texto.text, forKey: "texto")
      defaults.setValue(titulo.text, forKey: "titulo")
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         print("Deleted")
         
         let file1 = String(indexPath.row) + ".rtf"
         let file2 = String(indexPath.row) + "T.rtf"
         let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
         let url = NSURL(fileURLWithPath: path)
         if let pathComponet = url.appendingPathComponent(file1) {
            let filePath = pathComponet.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
               // Si el archivo existe
               do {
                  try fileManager.removeItem(at: pathComponet)
                  if let pathComponet2 = url.appendingPathComponent(file2) {
                     try fileManager.removeItem(at: pathComponet2)
                  }
               } catch let error as NSError {
                  print("Error:")
                  print(error)
               }
            }
         }
         
         // Ahora renombramos
         
         for i in 0...titulos.count-1 {
            //print("Piciosa")
            if i > indexPath.row {
               do {
                  let file11 = String(i) + ".rtf"
                  let file21 = String(i) + "T.rtf"
                  let file12 = String(i-1) + ".rtf"
                  let file22 = String(i-1) + "T.rtf"
                  
                  //print(file11)
                  //print(file12)
                  
                  let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0]
                  let documentDirectory = URL(fileURLWithPath: path)
                  let original = documentDirectory.appendingPathComponent(file11)
                  let destination = documentDirectory.appendingPathComponent(file12)
                  //print(original)
                  //print(destination)
                  try FileManager.default.moveItem(at: original, to: destination)
                  let original2 = documentDirectory.appendingPathComponent(file21)
                  let destination2 = documentDirectory.appendingPathComponent(file22)
                  try FileManager.default.moveItem(at: original2, to: destination2)
               } catch{
                  print("Error")
               }
            }
         }
         
         self.titulos.remove(at: indexPath.row)
         self.table.deleteRows(at: [indexPath], with: .automatic)
         defaults.setValue(titulos, forKey: "titulos")
         
         if indexPath.row < indice {
            indice -= 1
         }
         
      }
      
      
      
   }
   
   // No útil
   func addBoldText(fullString: String, boldPartOfString: String, baseFont: UIFont, boldFont: UIFont) -> NSAttributedString {

       //1
       let baseFontAttribute = [NSAttributedString.Key.font : baseFont]
       let boldFontAttribute = [NSAttributedString.Key.font : boldFont]

       //2
       let attributedString = NSMutableAttributedString(string: fullString, attributes: baseFontAttribute)

       //3. Note if 'boldPartOfString' is not a substring of 'fullString', enitre 'fullString' will be formatted with 'boldFont'
       attributedString.addAttributes(boldFontAttribute, range: NSRange(fullString.range(of: boldPartOfString) ?? fullString.startIndex..<fullString.endIndex, in: fullString))

       //4
       return attributedString
   }
   
   func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.textColor == UIColor.lightGray {
         textView.text = nil
         textView.textColor = UIColor.black
      }
   }
   
   
   
   func textViewDidEndEditing(_ textView: UITextView) {
      
      
      guardar()
      
      if textView.text.isEmpty {
         if textView == texto {
            let font2 = UIFont(name: selectedFont, size: 20)!
            
            let quote2 = "Redacte sus versos"
            
            let attributes2 = [NSAttributedString.Key.font: font2]
            let attributedQuote2 = NSAttributedString(string: quote2,attributes: attributes2)
            textView.attributedText = attributedQuote2
            textView.textColor = UIColor.lightGray
            textView.textAlignment = .center
            
            
         } else if textView == titulo {
            var font1 = UIFont(name: selectedFont + "-Bold", size: 25)! // bold
            
            if selectedFont == "CourierNewPS" || selectedFont == "TimesNewRomanPS" || selectedFont == "Arial" {
               font1 = UIFont(name: selectedFont + "-BoldMT", size: 25)! // bold
            }
            
            let quote1 = "Escriba su título"
            
            let attributes1 = [NSAttributedString.Key.font: font1]
            let attributedQuote1 = NSAttributedString(string: quote1,attributes: attributes1)
            titulo.attributedText = attributedQuote1
            titulo.textColor = UIColor.lightGray
            titulo.textAlignment = .center
         }
         
      }
   }
   
   func textViewDidChange(_ textView: UITextView) {
      playSound(sonido: "typewriter")
   }
   
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return pickerData.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return pickerData[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      print(row)
      self.seleccioneTipo.font = UIFont(name: pickerData[row], size: 17)
      //closeView(v: v1)
      //closeView(v: blurv1)
      
      selectedFont = pickerData[row]
      defaults.setValue(selectedFont, forKey: "selectedFont")
      
      self.texto.font = UIFont(name: pickerData[row], size: 20)
      
      
      if pickerData[row] == "CourierNewPS" || pickerData[row] == "TimesNewRomanPS" || pickerData[row] == "Arial" {
         self.titulo.font = UIFont(name: pickerData[row] + "-BoldMT", size: 25)
      } else {
         self.titulo.font = UIFont(name: pickerData[row] + "-Bold", size: 25)
      }
      
   }
   
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if scrollView == texto {
         lateralDerecho.contentOffset = texto.contentOffset
      } else {
         texto.contentOffset = lateralDerecho.contentOffset
      }
   }
   
   var player: AVAudioPlayer?
   
   func playSound(sonido: String) {
       guard let url = Bundle.main.url(forResource: sonido, withExtension: "mp3") else { return }

       do {
           try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
           try AVAudioSession.sharedInstance().setActive(true)

           /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
           player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

           /* iOS 10 and earlier require the following line:
           player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

           guard let player = player else { return }

           player.play()

       } catch let error {
           print(error.localizedDescription)
       }
   }
   
   func guardar() {
      let T = titulo.text
      print(indice)
      if titulos[indice] != T && T != "Escriba su título" {
         table.beginUpdates()
         titulos[indice] = T!
         defaults.setValue(titulos, forKey: "titulos")
         table.reloadData()
         table.endUpdates()
      }
      
      defaults.setValue(texto.text, forKey: "texto")
      defaults.setValue(titulo.text, forKey: "titulo")
      
      //var main = opentxt(name: "main.txt")
      //main = main + T! + "\n"
      //savetxt(name: "main.txt", text: main)
      
      let file1 = String(indice) + ".rtf"
      saveFile(file: file1, tV: texto)
      let file2 = String(indice) + "T.rtf"
      saveFile(file: file2, tV: titulo)
      
      //let file = "prueba.rtf"
      //saveFile(file: file, tV: texto)
   }
   
   func printFonts() {
      for familyName in UIFont.familyNames {
         print("\n-- \(familyName) \n")
         for fontName in UIFont.fontNames(forFamilyName: familyName) {
            print(fontName)
         }
      }
   }
   
   func saveFile(file: String, tV: UITextView) { //attributedText:NSMutableAttributedString
      
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         let path = dir.appendingPathComponent(file)
         print(path)
         do {
            let data = try! tV.attributedText.data(from: NSMakeRange(0, tV.attributedText.length), documentAttributes: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.rtf])
            try data.write(to: path)
         } catch  {
            print("Error")
         }
      }
   }
      
   func openFile(file: String, tV: UITextView) {
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         let path = dir.appendingPathComponent(file)
         print(path)
         do {
             let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: path, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
          print(attributedStringWithRtf.string)
             //self.texto.attributedText = attributedStringWithRtf
            tV.attributedText = attributedStringWithRtf
         } catch let error {
             print("Got an error \(error)")
         }
      }
   }
      /*
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         
         var fileURL = dir.appendingPathComponent(file)
         do {
            let guardar = try texto.attributedText.fileWrapper(from: NSRange(0..<texto.attributedText.length), documentAttributes:[NSAttributedString.DocumentAttributeKey.documentType:NSAttributedString.DocumentType.rtf])
            try  guardar.write(to:fileURL, options:  FileWrapper.WritingOptions.atomic, originalContentsURL: nil)
               
         } catch {
            print("Error")
         }*/
         
   
   func savetxt(name: String, text: String) {
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         
         let url = dir.appendingPathComponent(name)
         
         do {
            try Data(text.utf8).write(to: url)
         } catch {
            print("ERROR")
         }
         
      }
   }
   
   
   func opentxt(name: String) -> String {
      var text = "Error: el programador hizo mal su trabajo. Mande screenshot a pherjev@gmail.com"
      
      if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         
         let url = dir.appendingPathComponent(name)
         
         do {
            text = try String(contentsOf: url,encoding: .utf8)
         } catch {
            print("ERROR")
         }
      }
      
      return text
   }
   
   func openView(v: UIView) {
      self.view.addSubview(v)
      v.center = self.view.center
      v.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
      v.alpha = 0
      UIView.animate(withDuration: 0.4) {
          v.alpha = 1
          v.transform = CGAffineTransform.identity
      }
   }
   
   //self.visualEffectView.effect =
   
func openViewBlur(v: UIView) {
   self.view.addSubview(v)
   v.center = self.view.center
   v.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
   v.alpha = 0
   
   UIView.animate(withDuration: 0.4) {
       v.alpha = 1
       v.transform = CGAffineTransform.identity
   }
}

   
   
   
   func closeView(v: UIView) {
      UIView.animate(withDuration: 0.3, animations: {
          v.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
          v.alpha = 0
      }) { (success:Bool) in
          v.removeFromSuperview()
      }
   }

   // FUNCIONES TEXTUALES
   
   let consonantes: Set = ["b","c","d","f","g","h","j","k","l","m","n","ñ","p","q","r","s","t","v","w","x","y","z","B","C","D","F","G","H","J","K","L","M","N","Ñ","P","Q","R","S","T","V","W","X","Y","Z"]
   let vocalesAbiertas: Set = ["a","e","o","A","E","O"]
   let vocalesAbiertasAcento: Set = ["á","é","ó","Á","É","Ó"]
   let semivocales: Set = ["i","u","I","U"]
   let semivocalesAcento: Set = ["í","ú","Í","Ú"]
   
   var vocales: Set = ["a","e","o","A","E","O","á","é","ó","Á","É","Ó","i","u","I","U","í","ú","Í","Ú"]
   
   
   func hyphenization(word: String) -> [String] {
      let palabra = Array(word)
      var silabario: [String] = [String]()
      var silaba : String = ""
      var detectedVowel = false
      if palabra.count > 1 {
         
      
      for i in 0...palabra.count-1 {
         let letra = palabra[i]
         silaba += String(letra)
         
         
         // CONDICIONES DE TÉRMINO
         
         var terminated = false
         
         if detectedVowel {
            let anterior = palabra[i-1] // Existencia de palabra[i-1] garantizada porque ya se detectó una letra
            
            // Primera: Si ya se detectó una vocal anteriormente y se detecta CV o Cy, cortar (CVCV) y dejar CV en la nueva sílaba
            
            // Excepción no importante: Patyocsi -> Pa-tyoc-si?
            // Patricia -> Pat-ri-cia
            
            if consonantes.contains(String(anterior)) {
               if vocales.contains(String(letra)) || String(letra) == "y" {
                  silaba = silaba.substring(from: 0, to: silaba.count-3)
                  silabario.append(silaba)
                  silaba = String(anterior) + String(letra)
                  detectedVowel = false
                  terminated = true
               }
            }
            
            // HIATOS
            
            // Segunda: Semivocal tónica + Abierta
            
            if semivocalesAcento.contains(String(anterior)) && !terminated {
               if vocalesAbiertas.contains(String(letra)) {
                  silaba = silaba.substring(from: 0, to: silaba.count-2)
                  silabario.append(silaba)
                  silaba = String(letra)
                  detectedVowel = false
                  terminated = true
               }
            }
            
            // Tercera: Abierta + Semivocal tónica
            
            if vocalesAbiertas.contains(String(anterior)) && !terminated {
               if semivocalesAcento.contains(String(letra)) {
                  silaba = silaba.substring(from: 0, to: silaba.count-2)
                  silabario.append(silaba)
                  silaba = String(letra)
                  detectedVowel = false
                  terminated = true
               }
            }
            
            // Cuarta: Dos vocales abiertas
            
            if vocalesAbiertas.contains(String(anterior)) && !terminated {
               if vocalesAbiertas.contains(String(letra)) {
                  silaba = silaba.substring(from: 0, to: silaba.count-2)
                  silabario.append(silaba)
                  silaba = String(letra)
                  detectedVowel = false
                  terminated = true
               }
            }
            
            // Quinta: Dos vocales iguales
            
            if vocales.contains(String(anterior)) && !terminated {
               if vocales.contains(String(letra)) {
                  if anterior == letra {
                     silaba = silaba.substring(from: 0, to: silaba.count-2)
                     silabario.append(silaba)
                     silaba = String(letra)
                     detectedVowel = false
                     terminated = true
                  }
               }
            }
            
            
         }
         
         
         // Primera regla: Toda las sílabas contienen una palabra: V || CV || CCV
         if vocales.contains(String(letra)) {
            detectedVowel = true
         }
         
         /*
         if detectedVowel {
            silabario.append(silaba)
            silaba = ""
            detectedVowel = false
         }*/
      }
      
      silabario.append(silaba)
      } else {
         silabario = [String(palabra)]
      }
      return silabario
      
   }
   
   // Calcular la posición (silábica) del acento prosódico en palabras sin acento gráfico
   // Basta con ver si termina con -mente o n,s, V
   func prosódico(word: String) -> Int {
      var position = 0
      
      if word.count > 5 {
         // terminadas en -mente se discuten según la primera parte
         if word.substring(from: word.count-5, to: word.count-1) == "mente" {
            position = prosódico(word: word.substring(from: 0, to: word.count-6)) + 2
         } else {
            let finalWord = Array(word).last
            if String(finalWord ?? " ") == "n" || String(finalWord ?? " ") == "s" || vocales.contains(String(finalWord ?? " ")) {
               // Si termina en n,s o vocal y no tiene tilde es grave
               position = 2
            } else{
               position = 1
            }
         }
      } else {
         let finalWord = Array(word).last
         if String(finalWord ?? " ") == "n" || String(finalWord ?? " ") == "s" || vocales.contains(String(finalWord ?? " ")) {
            // Si termina en n,s o vocal y no tiene tilde es grave
            position = 2
         } else{
            position = 1
         }
      }
      
      //let silabario = hyphenization(word: word)
      return position
   }
   
   // ACENTO: Calcula la posición del acento
   
   func acento(word: String) -> Int {
      let palabra = Array(word)
      var posicion = 0
      var tilde = false
      if palabra.count > 1 {
      
         // Buscar un acento gráfico
         for i in 0...palabra.count-1 {
            let letra = palabra[i]
            if vocalesAbiertasAcento.contains(String(letra)) || semivocalesAcento.contains(String(letra)) {
               posicion = i
               tilde = true
            }
         }
         
         // Si nunca hay tilde: acento prosódico
         if !tilde {
            let p = prosódico(word: word)
            //print(p)
            let hyp = hyphenization(word: word)
            //print(hyp)
            var sum = 0
            var abierta = false
            for i in 0...hyp.count-1 {
               if i < hyp.count - p {
                  sum += hyp[i].count
               } else {
                  let sil = hyp[i]
                  let silA = Array(sil)
                  var debil = 0
                  for j in 0...sil.count-1 {
                     if vocalesAbiertas.contains(String(silA[j])) {
                        sum += j
                        abierta = true
                        //break
                     }
                     if semivocales.contains(String(silA[j])) {
                        debil = j
                     }
                     
                  }
                  // Si no hay abierta, tomamos la última débil
                  if !abierta {
                     //print("Lizeth")
                     sum += debil
                  }
                  break
               }
            }
            posicion = sum
         }
         
      }
      
      return posicion
   }
   
   func tilde(word: String) -> Int {
      // TILDE: Ubica la posición de la tilde. Devuelve -1 si no hay tilde
      var ac = -1
      let hyp = hyphenization(word: word)
      
      var c = 0
      
      for sil in hyp {
         c += 1
         for car in sil {
            if vocalesAbiertasAcento.contains(String(car)) || semivocalesAcento.contains(String(car)) {
               ac = c
            }
         }
      }
      
      if ac >= 0 {
         ac = hyp.count - ac + 1
      }
      
      return ac
   }
   
}

extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }

        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }

        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }

        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }

        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }

        return String(self[startIndex ..< endIndex])
    }

    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }

    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }

    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }

        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }

        return self.substring(from: from, to: end)
    }

    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }

        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }

        return self.substring(from: start, to: to)
    }
}
