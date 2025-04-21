import SwiftUI
import AVFoundation
import Vision
import CoreML

// MARK: — Modelo de información para cada detección
struct ObjetoInfo {
    let nombre: String
    let informacion: String
}

enum ScanningMode {
    case objectDetection
    case qrCode
    case imageClassification   
}

struct Escanner: View {
    @StateObject private var cameraManager = YOLOCameraManager()
    @State private var mostrarDetalle = false
    @State private var objetoSeleccionado: ObjetoInfo?

    var body: some View {
        ZStack {
            CameraPreview(session: cameraManager.session)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Etiquetas detectadas
                if !cameraManager.detectedLabels.isEmpty {
                    VStack(spacing: 10) {
                        ForEach(cameraManager.detectedLabels, id: \.self) { etiqueta in
                            Text(etiqueta)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.purple.opacity(0.75))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 80)
                    .onTapGesture {
                        if let info = cameraManager.infoForLastDetection {
                            objetoSeleccionado = info
                            mostrarDetalle = true
                        }
                    }
                } else {
                    Text("Analizando escena...")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.gray.opacity(0.7))
                        .cornerRadius(8)
                        .padding(.bottom, 80)
                }

                // Botón para alternar modos
                Button(action: {
                    cameraManager.toggleScanningMode()
                }) {
                    Text(cameraManager.scanningMode == .objectDetection ? "Cambiar a QR" :
                         cameraManager.scanningMode == .qrCode       ? "Cambiar a Clasificar" :
                                                                         "Cambiar a Detección")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $mostrarDetalle) {
            if let info = objetoSeleccionado {
                ObjetoDetalleView(info: info)
            }
        }
        .onAppear { cameraManager.setupSession() }
        .onDisappear { cameraManager.stopSession() }
    }
}

struct ObjetoDetalleView: View {
    let info: ObjetoInfo
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(info.nombre)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(info.informacion)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("Detalles")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") { dismiss() }
                }
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class YOLOCameraManager: NSObject,
                         ObservableObject,
                         AVCaptureVideoDataOutputSampleBufferDelegate,
                         AVCaptureMetadataOutputObjectsDelegate {
    @Published var detectedLabels: [String] = []
    @Published var infoForLastDetection: ObjetoInfo?
    @Published var scanningMode: ScanningMode = .objectDetection

    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.miApp.cameraQueue")
    private var videoOutput: AVCaptureVideoDataOutput?
    private var metadataOutput: AVCaptureMetadataOutput?
    

    private var yoloModel: VNCoreMLModel?
  
    lazy var classificationRequest: VNCoreMLRequest? = {
        do {
            let config = MLModelConfiguration()
            let mlModel = try MuseoImagenesML(configuration: config)
            let visionModel = try VNCoreMLModel(for: mlModel.model)
            let request = VNCoreMLRequest(model: visionModel) { [weak self] req, err in
                self?.procesarClasificacion(request: req, error: err)
            }
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            print("Error creando VNCoreMLRequest: \(error)")
            return nil
        }
    }()

   
    private let datosDeObjeto: [String: ObjetoInfo] = [
        "Caldera":      ObjetoInfo(nombre: "HORNO3",         informacion: "El corazón de Monterrey"),
        "Estufa":       ObjetoInfo(nombre: "Planeta Niños",   informacion: "Lugar donde los niños..."),
        "Planeta Niños":ObjetoInfo(nombre: "Válvulas de Gas", informacion: "Por aquí corre el gas"),
    ]

    override init() {
        super.init()
        // Carga del modelo YOLOv3
        do {
            let config = MLModelConfiguration()
            let yolo = try MuseoImagenesML(configuration: config)
            yoloModel = try VNCoreMLModel(for: yolo.model)
        } catch {
            print("Error cargando YOLOv3: \(error)")
        }
    }
    
    // MARK: – Configurar y controlar la sesión
    func setupSession() {
        sessionQueue.async {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for: .video,
                                                       position: .back),
                  let input  = try? AVCaptureDeviceInput(device: device),
                  self.session.canAddInput(input)
            else { return }
            self.session.addInput(input)
            self.updateOutputs()
            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }
    func stopSession() {
        session.stopRunning()
        DispatchQueue.main.async {
            self.detectedLabels.removeAll()
        }
    }
    func toggleScanningMode() {
        sessionQueue.async {
            self.session.beginConfiguration()
            self.session.outputs.forEach { self.session.removeOutput($0) }
            self.scanningMode = (self.scanningMode == .objectDetection
                                 ? .qrCode
                                 : self.scanningMode == .qrCode
                                   ? .imageClassification
                                   : .objectDetection)
            DispatchQueue.main.async {
                self.detectedLabels.removeAll()
                self.infoForLastDetection = nil
            }
            self.updateOutputs()
            self.session.commitConfiguration()
        }
    }
    private func updateOutputs() {
        if scanningMode == .objectDetection {
            let out = AVCaptureVideoDataOutput()
            out.setSampleBufferDelegate(self, queue: DispatchQueue(label: "objectQueue"))
            if session.canAddOutput(out) {
                session.addOutput(out)
                out.connection(with: .video)?.videoOrientation = .portrait
                videoOutput = out
            }
        }
        else if scanningMode == .qrCode {
            let meta = AVCaptureMetadataOutput()
            meta.setMetadataObjectsDelegate(self, queue: DispatchQueue(label: "metaQueue"))
            meta.metadataObjectTypes = [.qr]
            if session.canAddOutput(meta) {
                session.addOutput(meta)
                metadataOutput = meta
            }
        }
        else if scanningMode == .imageClassification {
            let out = AVCaptureVideoDataOutput()
            out.setSampleBufferDelegate(self, queue: DispatchQueue(label: "classifyQueue"))
            if session.canAddOutput(out) {
                session.addOutput(out)
                out.connection(with: .video)?.videoOrientation = .portrait
                videoOutput = out
            }
        }
    }
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        switch scanningMode {
        case .objectDetection:
            guard let model = yoloModel else { return }
            let req = VNCoreMLRequest(model: model) { [weak self] request, _ in
                self?.procesarDetecciones(request: request)
            }
            req.imageCropAndScaleOption = .scaleFill
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                       options: [:]).perform([req])

        case .imageClassification:
            guard let req = classificationRequest else { return }
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                       options: [:]).perform([req])

        default: break
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        for obj in metadataObjects {
            guard let qr = obj as? AVMetadataMachineReadableCodeObject,
                  qr.type == .qr,
                  let value = qr.stringValue
            else { continue }
            DispatchQueue.main.async {
                let etiqueta = "QR: \(value)"
                self.detectedLabels = [etiqueta]
                self.infoForLastDetection = ObjetoInfo(nombre: "Código QR",
                                                       informacion: value)
            }
            break
        }
    }

    //procesar resultados de detección
    private func procesarDetecciones(request: VNRequest) {
        guard let obs = request.results as? [VNRecognizedObjectObservation] else { return }
        var etiquetas: [String] = []
        for o in obs {
            if let l = o.labels.first, l.confidence > 0.5 {
                let clase = l.identifier
                etiquetas.append("\(clase) \(Int(l.confidence*100))%")
                let info = datosDeObjeto[clase]
                           ?? ObjetoInfo(nombre: clase.capitalized,
                                         informacion: "No hay información disponible.")
                DispatchQueue.main.async { self.infoForLastDetection = info }
            }
        }
        DispatchQueue.main.async { self.detectedLabels = etiquetas }
    }

    //Procesar resultados de clasificación
    private func procesarClasificacion(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation],
              let top = results.first
        else { return }
        let etiqueta = "\(top.identifier) \(Int(top.confidence*100))%"
        let info = datosDeObjeto[top.identifier]
                   ?? ObjetoInfo(nombre: top.identifier.capitalized,
                                 informacion: "No hay información disponible.")
        DispatchQueue.main.async {
            self.detectedLabels = [etiqueta]
            self.infoForLastDetection = info
        }
    }
}
