
import AVFoundation
import SwiftUI

struct MainPageView: View 
{
    @State var showAlert:Bool = false
    @Binding var showAR:Bool
    @State var showMinAlert:Bool = false
    @State var selected_symptoms:[Symptoms] = []
    @Binding var pageIndex:Int
    func pageDec()
    {
        withAnimation(.spring())
        {
            self.pageIndex = 3 
        }
    }
    var body: some View {
        VStack
        {
            
            HStack
            {
                Image(systemName: "hands.clap")
                
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:screenWidth*0.08)
                    .foregroundColor(.green)
                
                VStack
                {
                    Text("Let me know what's wrong ")
                        
                        .font(.system(.largeTitle))
                        .fontWeight(.heavy)
                    HStack
                    {
                        Text("I'll try to help you")
                        Text("ACUPUNCTURE")
                            .foregroundColor(.green)
                            .fontWeight(.heavy)
                            .padding(.horizontal,10)
                            .background(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        Text("it out")
                    }
                }
            }
            HStack
            {
                
                
                
                VStack(alignment: .trailing)
                {
                    Text("There are some common symptoms🤧 in the right, if you feel that you meet __one or more__ of them, feel free to choose them. Remember This app is only suitable for __non-serious and annoying__ problems, if your problem is serious, please go to the __hospital__ as soon as possible ")
                        .font(.title3)
                        .padding()
                    HStack
                    {
                        Text("Click to select & unselect\n __1 to 5__ symptoms")
                        //.fontWeight(.heavy)
                            .font(.title)
                            
                        //.padding(.horizontal,40)
                            .foregroundColor(.red)
                        Image(systemName: "arrow.up.right.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.heavy)
                            .frame(width: screenWidth*0.06)
                            .padding(.trailing,40)
                            .foregroundColor(.red)
                    }
                    
                    
                    
                }
                .frame(width: screenWidth*0.36,height: screenHeight*0.50)
                BlockView1(frameColor:.red)
                    .overlay()
                {
                    VStack
                    {
                        Text("Facial symptons you can choose")
                            .foregroundColor(.red)
                            .font(.title)
                            .fontWeight(.bold)
                            
                            .padding()
                        Spacer()
                        HStack{
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Dizzy", id: 1,recommend: [1,7,4,1,1,6,4,6,1,1,1,4,1,3,1,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Drowsiness", id: 2,recommend: [1,2,1,1,1,1,4,1,1,1,1,4,1,3,1,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Stuffy nose🤧", id: 3,recommend: [8,2,1,1,1,1,1,1,1,1,9,1,6,1,1,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Toothache", id: 4,recommend: [1,5,1,7,8,3,1,3,1,8,1,1,1,1,1,1]))
                            
                        }
                        HStack{
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Stressed out🤯", id: 5,recommend: [4,7,1,1,1,1,4,1,1,1,4,1,1,1,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Insomnia", id: 6,recommend: [1,2,1,1,1,1,8,1,1,1,1,1,1,7,3,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Headaches", id: 7,recommend: [1,7,3,1,2,7,9,4,1,8,1,1,1,1,6,1]))
                            
                        }
                        HStack{
                            
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Temporary Nearsightedness", id: 8,recommend: [1,2,1,1,6,1,9,8,1,8,4,1,1,1,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Nervous", id: 9,recommend: [1,1,2,5,1,1,6,1,1,1,1,4,1,1,4,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Eyelid fluttering", id: 10,recommend: [1,5,1,1,1,6,4,1,1,6,1,4,3,1,4]))
                            
                        }
                        HStack{
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Panic attack", id: 11,recommend: [1,1,6,7,6,1,4,1,1,6,1,1,1,1,1,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Nose bleeding", id: 12,recommend: [1,1,1,1,2,1,1,1,1,4,1,1,1,1,1,9,]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Runny nose", id: 13,recommend: [9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]))
                            
                            
                        }
                        HStack{
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "Eye strain", id: 14,recommend: [1,1,1,1,1,6,1,9,8,1,1,1,4,1,4,1]))
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "No energy", id: 15,recommend: [3,1,1,1,1,1,1,1,4,1,1,1,1,1,1,1]))
                        }
                        HStack
                        {
                            CapsuleView(showAlert:$showAlert,selected_symptoms:$selected_symptoms,symptom: Symptoms(name: "A pain that I don't know how to describe (facial)", id: 16,recommend: [1,7,3,5,5,1,4,1,1,8,1,7,6,1,8,1]))
                            
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            HStack
            {
                
                
                BlockView2(frameColor: .green)
                    .overlay()
                {
                    VStack
                    {
                        Text("Your symptons")
                            .foregroundColor(.green)
                            .font(.title)
                            .fontWeight(.bold)
                            
                            .padding()
                        Spacer()
                        HStack
                        {
                            ForEach(selected_symptoms) { selected_symptom in
                                
                                FrozeCapsuleView(symptom: Symptoms(name: selected_symptom.name, id: selected_symptom.id,recommend: []))
                            }
                            
                            
                        }
                        .padding()
                        Spacer()
                    }
                    
                }
                
                VStack
                {
                    
                    HStack
                    {
                        Text("Then, click the __Continue__ button, the __coreML__ model will calculate the acupuncture points suitable for you and hand it over to __AR__ stage")
                    }
                    .font(.title3)
                    .padding()
                    HStack
                    { Button(action: {withAnimation()
                        {
                            AudioServicesPlaySystemSound(cancelSound)
                            pageDec()
                        }
                    })
                        {
                            
                            HStack
                            {
                                
                                Text("Back")
                                //.fontWeight(.heavy)
                                
                                
                            }
                            .font(.title)
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.red))
                            .shadow(radius: 3)
                        }
                        Button(action: {withAnimation()
                            {
                                if(selected_symptoms.count == 0)
                                {
                                    AudioServicesPlaySystemSound(cancelSound)
                                    showMinAlert.toggle()
                                }else
                                {
                                    AudioServicesPlaySystemSound(tapSound)
                                    initAcus()
                                    generate_recommendation()
                                    modify_recommodation()
                                    self.showAR.toggle()
                                    
                                }
                                
                            }
                        })
                        {
                            
                            HStack
                            {
                                Image(systemName: "arkit")
                                Text("Continue")
                                //.fontWeight(.heavy)
                                
                                
                            }
                            .font(.title)
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.blue))
                            .shadow(radius: 3)
                        }
                    }
                   
                    
                    //Spacer()
                }
                .frame(width: screenWidth*0.36,height: screenHeight*0.23)
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you serious?"), message: Text("If you really have so many symptoms, please go to the hospital as soon as possible, I'm not joking"), dismissButton: .default(Text("Got it!")))
            }
            
            
            
        }
        
        .alert(isPresented: $showMinAlert) {
            Alert(title: Text("You need to select at least one symptom to continue"), message: Text("If you are not experiencing any discomfort, you may also choose to learn about some of the symptoms you are interested in"), dismissButton: .default(Text("Got it!")))
        }
    }
    func generate_recommendation()
    {
        var raw_array:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        for selected_symptom in selected_symptoms {
            for (index,item) in selected_symptom.recommend.enumerated()
            {
                raw_array[index] = raw_array[index] + item
            }
        }
        //print(raw_array)
        let max = raw_array.max()!
        for (index,item) in raw_array.enumerated()
        {
            recommendation[index] = Double(item) / Double(max)
            
        }
        print(recommendation)
    }
    func modify_recommodation()
    {
        for (index,_) in fullacupoints.enumerated()
        {
            fullacupoints[index].recommendation = recommendation[index]
        }
    }
}

struct BlockView1: View
{
    var frameColor:Color = .green
    var body: some View
    {
        HStack
        {
            
        }
        .frame(width: screenWidth*0.55,height: screenHeight*0.50)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(frameColor.opacity(0.3),lineWidth: 4))
    }
}
struct BlockView2: View
{

    var frameColor:Color = .green
    var body: some View
    {
        HStack
        {
            
        }
        .frame(width: screenWidth*0.55,height: screenHeight*0.23)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(frameColor.opacity(0.3),lineWidth: 4))
    }
}



