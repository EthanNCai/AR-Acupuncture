
import SwiftUI
import AVFoundation
struct SwiftUIView: View {
    @Binding var pageIndex:Int
    var body: some View {
        VStack
        {
            Spacer()
            HStack
            {
                Image(systemName: "arkit")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Text("Acupuncture map🗺️ APP")
                    .font(.largeTitle)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 30, style:.continuous).stroke(Color.gray.opacity(0.7),lineWidth: 4))
            Spacer()
            HStack
            {
                Image(systemName: "arrowshape.left.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth*0.1)
                    .foregroundColor(.blue)
                //.frame(width: screenWidth*0.3)
                Text("Place the iPad __horizontally__ and place the __front camera__ facing this way")
                    .frame(width: screenWidth*0.5)
                    .font(.largeTitle)
                    .padding()
            }
            Spacer()
            Button(action: {
                AudioServicesPlaySystemSound(tapNextStage)
                withAnimation( .easeOut(duration: 0.5))
                {
                    self.pageIndex = 1
                }
            }, label: {
                HStack
                {
                    Text("Explore your personal acupuncture map🗺️！")
                }
                .font(.title)
                .padding()
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.blue))
                .shadow(radius: 3)
                .padding()
            })
            Spacer()
        }
    }
}

