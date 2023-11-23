
import AVFoundation
import SwiftUI

struct CapsuleView: View {
    @State var selected:Bool = false
    @Binding var showAlert:Bool 
    @Binding var selected_symptoms:[Symptoms]
    var symptom:Symptoms 
    var isRed:Bool = true
    var body: some View {
        
            Text(symptom.name)
            .fontWeight(.bold)
            .font(.system(.body))
            .padding(13)
            .foregroundColor(selected ? .white : .black)
            .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(Color.red.opacity(0.7),lineWidth: 4))
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous).fill(.red).opacity(selected ? 0.9 : 0))
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous).fill(.white).opacity(selected ? 0 : 0.9))
            .onTapGesture {
                
                if(!selected)
                {
                    if(selected_symptoms.count>=5)
                    {
                        showAlert = true
                    }else
                    {
                        AudioServicesPlaySystemSound(tapCapsuleSound)
                        withAnimation(.easeInOut)
                        {
                            selected_symptoms.append(symptom)
                        }
                        withAnimation()
                        {
                            self.selected.toggle()
                            
                        }
                        
                    }
                    
                    
                    
                }else
                {
                    AudioServicesPlaySystemSound(cancelSound)
                    for (index,item) in selected_symptoms.enumerated()
                    {
                        if(item.id == symptom.id)
                        {
                            
                                selected_symptoms.remove(at: index)
                        
                            break
                        }
                    }
                    withAnimation()
                    {
                        self.selected.toggle()
                        
                    }
                    
                }
                
            }
        
    }
}
struct FrozeCapsuleView: View {
    
    var symptom:Symptoms = Symptoms(name: "666", id: 2,recommend: [])
    var body: some View {

        Text(symptom.name)
            .fontWeight(.bold)
            
            .font(.system(.body))
            .padding(13)
            .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.green.opacity(0.7),lineWidth: 4))
        
    }
    
}



