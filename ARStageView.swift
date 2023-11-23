
import SwiftUI
import AVFoundation

struct ARStageView: View {
    @StateObject var cameraManager = CameraManager()
    @Binding var showAR:Bool
    @State var showTip = false
    @State var showTipBg = false
    var acupointList:[Acupoint]
    @ObservedObject var arView = ARViewController()
    var body: some View {
        
        ZStack
        {
            VStack
            {
                HStack
                {
                    VStack
                    {
                        HStack
                        {
                            Image(systemName: "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: screenWidth*0.04)
                                .foregroundColor(.red)
                            Text("There is no additional risk of massaging acupuncture points")
                                .font(.title2)
                        }
                        HStack
                        {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: screenWidth*0.04)
                                .foregroundColor(.orange)
                            Text("Try to keep your face calm in order to have a stable AR experienece")
                                .font(.title2)
                        }
                        .frame(width: screenWidth*0.37)
                    }
                    
                    
                    
                    VStack
                    {
                        Spacer()
                        HStack
                        {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            Spacer()
                            Text("The recommended acupunture points according to your symptom (click Try me for more informantion and start)")
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                        
                        Spacer()
                        HStack
                        {
                            Image(systemName: "arrow.down.left.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Spacer()
                            Text("The corresponding acupuncture point will appear on your face using AR after you try any of them")
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                        
                        
                        Spacer()
                        
                    }
                    .font(.title2)
                    .padding(.horizontal)
                    .frame(width: screenWidth*0.47,height:screenHeight*0.20)
                    .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.gray.opacity(0.3),lineWidth: 5))
                    .padding()
                    
                    
                    
                }
                HStack
                {
                    if cameraManager.permissionGranted 
                    {
                        
                        ARView(arView: arView)
                            .frame(width: screenWidth*0.37,height:screenHeight*0.57)
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(.red,lineWidth: 5).frame(width: screenWidth*0.37,height:screenHeight*0.57))
                            .padding()
                        
                    }
                    
                    
                    VStack
                    {

                        ScrollView(showsIndicators: true)
                        {
                            ForEach(rankAcupoint()) { acu in
                                AcuCard(arView:arView,name: acu.name, function: acu.function, tips: acu.tips,recomm: acu.recommendation, id: acu.id)
                            }
                        }
                        .padding(.horizontal)
                        .frame(width: screenWidth*0.47,height:screenHeight*0.50)
                        .overlay()
                        {
                            VStack
                            {
                                Spacer()
                                HStack
                                {
                                    Text("scroll for more")
                                    Image(systemName: "arrow.down")
                                    
                                }
                                .fontWeight(.bold)
                                .padding(10)
                                .padding(.horizontal)
                                .background(.ultraThinMaterial)
                                .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
                                .padding()
                            }
                        }
                        Button(action: {
                            AudioServicesPlaySystemSound(cancelSound)
                            withAnimation(){
                            showAR.toggle()
                            }
                        })
                        {
                            HStack
                            {
                                Image(systemName: "chevron.left")
                                Text("Back and re-select your symptom(s)")
                            }
                            .font(.title)
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.red).opacity(0.8))
                            
                        }
                    }
                }
            }
            if(!showTipBg) //massageTip
            {
                VStack
                {
                    
                }.frame(width: screenWidth,height: screenHeight)
                    .background(.ultraThinMaterial)
            }
            if(!showTip) // massageTip
            {
                
                VStack
                {
                    Image("MASSAGE")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth*0.38)
                        .cornerRadius(50)
                    Text("You can massage acupuncture points like this")
                        .font(.title)
                        .onReceive(cameraManager.$permissionGranted, perform: { _ in
                        })
                        .onAppear {
                            cameraManager.requestPermission() //ask for permission
                        }
                    
                    Button(action: {
                        withAnimation(.easeInOut)
                        {
                            showTipBg.toggle()
                        }
                        showTip.toggle() 
                    })
                    {
                        Text("I got it! ")
                            .font(.title)
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.blue).opacity(0.8))
                    }
                }
            }
        }
        
        
    }
    func rankAcupoint() -> [Acupoint] // rank acupuncture according to recommendation rating
    {
        var sortedAcupoint = acupointList
        sortedAcupoint.sort()
        {
            $0.recommendation > $1.recommendation
        }
        return sortedAcupoint
    }
}

struct ARStageView_Previews: PreviewProvider {
    static var previews: some View {
        ARStageView(showAR: .constant(true),acupointList: fullacupoints)
    }
}


struct AcuCard:View
{
    var arView:ARViewController
    @Namespace var namespace
    var name:String
    var function:String
    var tips:String
    var recomm:Double = 0
    var id:Int
    
    @State var showDetails = false
    var body: some View {
        
        if(!showDetails)
        {
            HStack
            {
                Spacer()
                Image(systemName: String(id) + ".circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "acuId", in: namespace)
                    .frame(height:screenHeight*0.06)
                    .foregroundColor(.green)
                    .fontWeight(.heavy)
                VStack
                {
                    
                    Text(name)
                        .matchedGeometryEffect(id: "acuName", in: namespace)
                        .font(.title)
                    
                        
                    
                        .font(.title)
                    HStack
                    {
                        Text("Recommendation")
                        
                            .font(.body)
                            .fontWeight(.light)
                        if(recomm>0.75)
                        {
                            Gauge(value: recomm * 100-1, in: 0...100) {}
                                .tint(.green)
                                .frame(width: screenWidth*0.04)
                        }else if(recomm > 0.6)
                        {
                            Gauge(value: recomm * 100-1, in: 0...100) {}
                                .tint(.orange)
                                .frame(width: screenWidth*0.04)
                        }else
                        {
                            Gauge(value: recomm * 100-1, in: 0...100) {}
                                .tint(.red)
                                .frame(width: screenWidth*0.04)
                        }
                    }
                }
                .frame(width: screenWidth*0.21)
                
                Button(action: {
                    AudioServicesPlaySystemSound(swipeSound)
                    withAnimation(.spring()){showDetails.toggle()}
                    arView.add_acupoint(on: id)
                })
                {
                    Text("Try me!👈")
                        .font(.title)
                        .padding()
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 20,style:.continuous).fill(.blue).opacity(0.6).matchedGeometryEffect(id: "tryBtn", in: namespace))
                        .shadow(radius: 3)
                }
            }
            .frame(width: screenWidth*0.45,height:screenHeight*0.09)
            .padding(.horizontal)
        }
        else
        {
            VStack
            {
                HStack
                {
                    Spacer()
                    Image(systemName: String(id) + ".circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "acuId", in: namespace)
                        .frame(height:screenHeight*0.06)
                        .foregroundColor(.green)
                        .fontWeight(.heavy)
                    Spacer()
                    VStack
                    {
                        Text(name)
                            .matchedGeometryEffect(id: "acuName", in: namespace)
                            .font(.title)
                    }
                    .frame(width: screenWidth*0.21)
                    Button(action: { 
                        AudioServicesPlaySystemSound(swipeSound)
                        withAnimation(.spring()){
                        showDetails.toggle()}
                        arView.remove_acupoint(on: id)
                    })
                    {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding()
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.red).opacity(0.6).matchedGeometryEffect(id: "tryBtn", in: namespace))
                            .shadow(radius: 3)
                    }
                }
                .frame(width: screenWidth*0.45,height:screenHeight*0.09)
                .padding(.horizontal)
                VStack
                {
                    HStack
                    {
                        Text("My ability💪")
                            .shadow(radius: 2)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.blue).opacity(0.5))
                            .padding(.leading,10)
                        Spacer()
                        Text(function)
                            .padding(.trailing)
                            .frame(width: screenWidth*0.30)
                    }
                    HStack
                    {
                        Text("Tips")
                            .shadow(radius: 2)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.blue).opacity(0.5))
                            .padding(.leading,10)
                        Spacer()
                        Text(tips)
                            .padding(.trailing)
                            .frame(width: screenWidth*0.30)
                    }
                }
                .padding()
                .frame(width: screenWidth*0.45)
                .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(Color.gray.opacity(0.7),lineWidth: 4))
            }
        }
    }
}
class CameraManager : ObservableObject  //cameraManager
{
    @Published var permissionGranted = false
    func requestPermission() 
    {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            DispatchQueue.main.async 
            {
                self.permissionGranted = accessGranted
            }
        })
    }
}
