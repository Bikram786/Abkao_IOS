//
//  BarCodeScannerControl.swift
//  Abkao
//
//  Created by CSPC162 on 09/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD
//import MTBBarcodeScanner
import ScanditBarcodeScanner

extension BarCodeScannerControl: SBSScanDelegate {
    // This delegate method of the SBSScanDelegate protocol needs to be implemented by
    // every app that uses the Scandit Barcode Scanner and this is where the custom application logic
    // goes. In the example below, we are just showing an alert view with the result.
    func barcodePicker(_ picker: SBSBarcodePicker, didScan session: SBSScanSession) {
        // Call pauseScanning on the session (and on the session queue) to immediately pause scanning
        // and close the camera. This is the preferred way to pause scanning barcodes from the
        // SBSScanDelegate as it is made sure that no new codes are scanned.
        // When calling pauseScanning on the picker, another code may be scanned before pauseScanning
        // has completely paused the scanning process.
        session.pauseScanning()
        
        let code = session.newlyRecognizedCodes[0]
        // The barcodePicker(_:didScan:) delegate method is invoked from a picker-internal queue. To
        // display the results in the UI, you need to dispatch to the main queue. Note that it's not
        // allowed to use SBSScanSession in the dispatched block as it's only allowed to access the
        // SBSScanSession inside the barcodePicker(_:didScan:) callback. It is however safe to
        // use results returned by session.newlyRecognizedCodes etc.
        DispatchQueue.main.async {
            
            self.callBarcodeAPI(barcodeValue: code.data!)
            
        }
    }
}



class BarCodeScannerControl: AbstractControl {
    
    var barcodePicker: SBSBarcodePicker?
    let settings = SBSScanSettings.default()
    
    @IBOutlet weak var btnFlip: UIButton!
    /*
    @IBOutlet var previewView: UIView!
    var scanner: MTBBarcodeScanner?
    
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    let supportedCodeTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode]
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupScanner()
        //scanner = MTBBarcodeScanner(previewView: previewView)

        scanner?.allowTapToFocus = true
        

        
        //self.view.backgroundColor = UIColor.clear
        //setCamera()
       //setOrintation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setScanner()
        

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       // self.scanner?.stopScanning()
        
//        if (captureSession?.isRunning == true) {
//            captureSession?.stopRunning();
//        }
    }
    
    
    @IBAction func btn_FlipCameraAction(_ sender: UIButton) {
     
         barcodePicker?.switchCameraFacing()
    }
    
    /*
    func setFrontCamera()
    {
        if(self.scanner?.camera == MTBCamera.back)
        {
            self.scanner?.flipCamera()
        }
    }
    
    // MARK: - Super Class Method
    
    override var showRight: Bool{
        return false
    }
    
    
    
    func setScanner(){
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                
                                self.scanner?.stopScanning()
                                let stringValue = code.stringValue!
                                print("Found code: \(stringValue)")
                                self.callBarcodeAPI(barcodeValue: stringValue)
                            }
                        }
                    })
                    self.perform(#selector(self.setFrontCamera), with: nil, afterDelay: 0.4)
                    
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
    }
    
    func setCamera(){
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
        
        layer.videoOrientation = orientation
        videoPreviewLayer?.frame = self.view.bounds
        
    }
    
    func setOrintation(){
        
        if let connection =  self.videoPreviewLayer?.connection  {
            
            let currentDevice: UIDevice = UIDevice.current
            
            let orientation: UIDeviceOrientation = currentDevice.orientation
            
            let previewLayerConnection : AVCaptureConnection = connection
            
            if previewLayerConnection.isVideoOrientationSupported {
                
                switch (orientation) {
                case .portrait: updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                
                    break
                    
                case .landscapeRight: updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                
                    break
                    
                case .landscapeLeft: updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                
                    break
                    
                case .portraitUpsideDown: updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                
                    break
                    
                default: updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                
                    break
                }
            }
        }
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No QR/barcode is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                // messageLabel.text = metadataObj.stringValue
                
                if (captureSession?.isRunning == true) {
                    captureSession?.stopRunning();
                }
                
                callBarcodeAPI(barcodeValue: metadataObj.stringValue)
                
                
                
            }
        }
    }
    */
    
    func callBarcodeAPI(barcodeValue: String) {

        
        SVProgressHUD.show(withStatus: "Loading.......")
        
        var barcodDict  = [String : Any]()
        barcodDict["account_number"] = (ModelManager.sharedInstance.profileManager.userObj?.accountNo)
        barcodDict["barcode_no"] = barcodeValue
        
        ModelManager.sharedInstance.barcodeManager.scanBarcode(barcodeDict: barcodDict) { (barCodeObj, isSuccess, strMessage) in
            
            SVProgressHUD.dismiss()
            
            if(isSuccess)
            {
                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsControl") as! ProductDetailsControl
                myVC.productBarCode = barcodeValue
                myVC.getPreviousProducts = barCodeObj!
                self.navigationController?.pushViewController(myVC, animated: true)
            }else{
                
                self.barcodePicker?.resumeScanning()
                
                SVProgressHUD.showError(withStatus: strMessage)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupScanner() {
        // Scandit Barcode Scanner Integration
        // The following method calls illustrate how the Scandit Barcode Scanner can be integrated
        // into your app.
        
        // Create the scan settings and enabling some symbologies
        
        settings.cameraFacingPreference = .front
        settings.areaSettingsLandscape = SBSScanAreaSettings.defaultLandscape()
        
        let symbologies: Set<SBSSymbology> = [.ean8, .ean13, .qr]
        for symbology in symbologies {
            settings.setSymbology(symbology, enabled: true)
        }
        
        // Create the barcode picker with the settings just created
        barcodePicker = SBSBarcodePicker(settings:settings)
        barcodePicker?.overlayController.beepEnabled()
        barcodePicker?.overlayController.setCameraSwitchVisibility(.always)
        // Add the barcode picker as a child view controller
        
        addChildViewController(barcodePicker!)
        view.addSubview((barcodePicker?.view)!)
        

        self.view.addSubview(btnFlip)
        
        
        
        barcodePicker?.didMove(toParentViewController: self)
        
        // Set the allowed interface orientations. The value UIInterfaceOrientationMaskAll is the
        // default and is only shown here for completeness.
        barcodePicker?.allowedInterfaceOrientations = .all
        // Set the delegate to receive scan event callbacks
        barcodePicker?.scanDelegate = self
        barcodePicker?.startScanning()
    }
    

}

