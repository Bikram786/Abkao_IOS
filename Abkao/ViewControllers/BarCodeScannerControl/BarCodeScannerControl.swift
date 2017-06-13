//
//  BarCodeScannerControl.swift
//  Abkao
//
//  Created by CSPC162 on 09/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import AVFoundation

class BarCodeScannerControl: AbstractControl, AVCaptureMetadataOutputObjectsDelegate {

//    var videoCaptureDevice: AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//    var device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//    var output = AVCaptureMetadataOutput()
//    var previewLayer: AVCaptureVideoPreviewLayer?
//    
//    var captureSession = AVCaptureSession()
//    var code: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //self.view.backgroundColor = UIColor.clear
        //self.setupCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //self.performSegue(withIdentifier: "goto_productdetailsvc", sender: nil)
    }
    
    // MARK: - Super Class Method
    
    override var showRight: Bool{
        return false
    }

    
//    private func setupCamera() {
//        
//        let input = try? AVCaptureDeviceInput(device: videoCaptureDevice)
//        
//        if self.captureSession.canAddInput(input) {
//            self.captureSession.addInput(input)
//        }
//        
//        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        
//        if let videoPreviewLayer = self.previewLayer {
//            videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//            videoPreviewLayer.frame = self.view.bounds
//            view.layer.addSublayer(videoPreviewLayer)
//        }
//        
//        let metadataOutput = AVCaptureMetadataOutput()
//        if self.captureSession.canAddOutput(metadataOutput) {
//            self.captureSession.addOutput(metadataOutput)
//            
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode]
//        } else {
//            print("Could not add metadata output")
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if (captureSession.isRunning == false) {
//            captureSession.startRunning();
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (captureSession.isRunning == true) {
//            captureSession.stopRunning();
//        }
//    }
//    
//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
//        // This is the delegate'smethod that is called when a code is readed
//        for metadata in metadataObjects {
//            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
//            let code = readableObject.stringValue
//            
//            
//            self.dismiss(animated: true, completion: nil)
//            //self.delegate?.barcodeReaded(barcode: code!)
//            print(code!)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
}

