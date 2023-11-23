
import UIKit
import AVFoundation
import SwiftUI


struct WelcomeView: View
{
    
    @State var pageIndex = 0
    @State var showAR = false
    var body: some View
    {
        if(showAR==true)
        {
            ARStageView(showAR:$showAR,acupointList: fullacupoints)
        }else if(pageIndex == 0)
        {
            SwiftUIView(pageIndex: $pageIndex)
                
        }else if(pageIndex == 1)
        {
            WelcomeBackgroundPage(pageIndex: $pageIndex)
                .onAppear(perform: {
                    updateFrame()
                })
        }else if(pageIndex == 2)
        {
            WelcomeFuncPage(pageIndex: $pageIndex)
        }else if(pageIndex == 3)
        {
            WelcomeTechPage(pageIndex: $pageIndex)
        }else if(pageIndex == 4)
        {
            MainPageView(showAR: $showAR,pageIndex: $pageIndex)
        }
        
        
        
        
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct WelcomeBackgroundPage: View
{
    
    @Binding var pageIndex:Int
    var body: some View
    {
        VStack
        {
           
            Spacer()
            Text("__Backgrounds__")
                .font(.title)
                .padding()
            Spacer()
            Text("From time to time in life we encounter some inexplicable physical glitches, such as stuffy noses🤧, blinding😵‍💫, lack of power😑, dizziness😵‍💫 and headaches🤕, etc. When these symptoms are __not caused by specific disease__, there is often nothing we can do about them.\n\nBut the good news is that __Traditional Chinese Medicine(TCM) acupressure techniques__ can often be effective at this time to help you alleviate some of these problems. Acupuncture point techniques in Chinese medicine have undergone __3000 years of iterations__ and have been proven by modern science.")
                .font(.title)
                .frame(width: screenWidth*0.7)
            Spacer()
            HStack
            {
                Button(action: {pageDec()
                    AudioServicesPlaySystemSound(cancelSound)})
                {
                    HStack
                    {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.red))
                    .shadow(radius: 3)
                    
                }
                Button(action: {
                    pageInc()
                    AudioServicesPlaySystemSound(tapSound)
                    })
                {
                    HStack
                    {Text("Continue")
                        
                        Image(systemName: "chevron.right")
                    }
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.blue))
                    .shadow(radius: 3)
                    
                }
            }
            .padding()
        }
    }
    func pageDec()
    {
        withAnimation(.spring())
        {
            self.pageIndex = 0
        }
    }
    func pageInc()
    {
        withAnimation(.easeInOut)
        {
            self.pageIndex = 2
        }
        
    }
}
struct WelcomeFuncPage: View
{
    @Binding var pageIndex:Int
    var body: some View
    {
        VStack
        {
            Spacer()
            
            HStack
            {
                VStack
                {
                    Text("__Details of acupuncture system__")
                        .font(.title)
                        .padding(.horizontal)
                    HStack
                    {
                        Text("The acupuncture points are like __buttons__ on your body or face that are distributed in a certain pattern on your __face__ (like the diagram on the right shows) and that correspond to different organs and nerves of the person.\n")
                            .font(.title)
                            .frame(width: UIScreen.main.bounds.width*0.5)
                        Image("ACU")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.3)
                    }
                    
                    
                    Text("Somewhat troubling is how an ordinary person who knows nothing about TCM can know that he or she has to push those buttons (massage them) and find them to help ease certain discomforts? 🤯 Fortunately, this app is built to solve this problem, that is, to navigate you through Chinese medicine acupuncture points")
                        .font(.title)
                        .frame(width: UIScreen.main.bounds.width*0.8)
                }
            }
            Spacer()
            HStack
            {
                Button(action: {pageDec()
                    AudioServicesPlaySystemSound(cancelSound)} )
                {
                    HStack
                    {
                        
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.red))
                    .shadow(radius: 3)
                    
                }
                Button(action: {
                    pageInc()
                    AudioServicesPlaySystemSound(tapSound)})
                {
                    HStack
                    {Text("Continue")
                        
                        Image(systemName: "chevron.right")
                    }
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.blue))
                    .shadow(radius: 3)
                    
                }
            }
            .padding()
        }
    }
    func pageDec()
    {
        withAnimation(.spring())
        {
            self.pageIndex = 1
        }
    }
    func pageInc()
    {
        withAnimation(.easeInOut)
        {
            self.pageIndex = 3
        }
        
    }
}
struct WelcomeTechPage: View
{
    
    
    @Binding var pageIndex:Int
    var body: some View
    {
        VStack
        {
            
            Spacer()
            Text("__Anyone can benefit from TCM__ 👐")
                .font(.title)
                .padding()
            Text("You can simply tell the program your current symptoms and the algorithm will calculate the acupuncture points to adapt to your current situation\n\nAnd you don't have to worry about that you can't find them, I use __ARkit__ to present the points directly in an AR image of your face so you can try to massage them extremely visually!😉")
                .font(.title)
                .frame(width: UIScreen.main.bounds.width*0.7)
            Image("ILLUSTRATION")
                .resizable()
                .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width*0.7)
            Spacer()
            HStack
            {
                Button(action: {pageDec()
                    AudioServicesPlaySystemSound(cancelSound)})
                {
                    HStack
                    {
                        
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.red))
                    .shadow(radius: 3)
                    
                }
                Button(action: {
                    pageInc()
                    AudioServicesPlaySystemSound(tapSound)})
                {
                    HStack
                    {
                        Text("Let's jump in")
                        Image(systemName: "checkmark")
                    }
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.green))
                    .shadow(radius: 3)
                }
            }
            .padding()
            
        }
        
    }
    func pageDec()
    {
        withAnimation(.spring())
        {
            self.pageIndex = 2
        }
    }
    func pageInc()
    {
        withAnimation()
        {
            self.pageIndex = 4
        }
        
    }
}
