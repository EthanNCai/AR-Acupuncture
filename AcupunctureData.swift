
import Foundation
import SwiftUI
import ARKit
import SceneKit
let de = simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [0.14212328, -0.070205495, -0.11404109, 1.0]])
let dm = simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [0.08, 0.121575326, -0.17363015, 1.0]])
let dn = simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [0.073630154, 0.04143834, -0.15034248, 1.0]])
var recommendation:[Double] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

struct Symptoms:Identifiable
{
    var name:String
    var id:Int
    var recommend:[Int]
}

struct Acupoint:Identifiable
{
    var id: Int
    var name:String
    var function:String
    var tips:String
    var matrix:simd_float4x4
    var recommendation:Double
}

var fullacupoints:[Acupoint] =
[
    Acupoint(id: 1,
             name: "Ying-xiang",
             function: "I can help you dispersing wind heat🔥 and clearing the nose🤧 and orifices",
             tips: "I will try my best to ease your nose when you have a cold!",
             matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 2,
              name: "Di-cang",
              function: "I have nerve endings all over my bottom and I can help you with certain pain problems",
              tips: "When you have weird pain that you can't describe, I can save you",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 3,
              name: "Ren-zhong",
              function: "I have a calming and tranquilizing effect, awakening the mind and enlightening the body",
              tips: "In the past, I was often used to help people who were unconscious, so don't touch me easily!",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 4,
              name: "Cheng-jiang",
              function: "I can help you relieve some pain from inflammation of the face or mouth ",
              tips: "When you're suffering from a toothache, you'd better come to me!",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 5,
              name: "Dui-duan",
              function: "I can help you relieve the boredom and heat in your body",
              tips: "I can save your toothache from eating hot food or something",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 6,
              name: "Tong-zi-mu",
              function: "My duty is to help you relieve eye discomfort, or pseudo myopia",
              tips: "I'm a good point if you overuse your eyes",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 7,
              name: "Yin-tang",
              function: "I can solve your headache, dizziness, and accompanying insomnia",
              tips: "Whenever you can't sleep at night, remember me",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 8,
              name: "Jing-ming",
              function: "If your eyes are uncomfortable, massage me will be the most effective way to relieve",
              tips: "I am a must-massage object for traditional Chinese eye exercises",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 9,
              name: "Si-bai",
              function: "I'm a cure for facial spasms and pseudomyopia",
              tips: "After high-intensity eye use, if you want to reduce the chance of myopia, please come to me",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 10,
              name: "Jv-mu",
              function: "My indication is toothache rhinitis or trigeminal neuralgia",
              tips: "I've got nerve endings all over my underside, that's why I'm capable",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 11,
              name: "Can-zhu",
              function: "I can cure your dizziness, headache, even a sprained back",
              tips: "Don't be surprised why I can affect the waist, this is the magic of Chinese medicine",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 12,
              name: "Shang-yin-xiang",
              function: "I mainly use it to deal with all kinds of rhinitis",
              tips: "If you have rhinitis unfortunately, remember to come to me",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 13,
              name: "Si-zhu-kong",
              function: "I mostly use it for headaches and toothaches",
              tips: "I am a common acupuncture point for relieving unknown headaches in modern times",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 14,
              name: "Yu-yao",
              function: "I can calm the nerves and dredge the meridians",
              tips: "If you're feeling stuck in your head, try massaging me",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 15,
              name: "Yang-bai",
              function: "I mainly use it for facial neuralgia and facial spasms",
              tips: "I can also use it to treat eyelid twitching",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
    ,Acupoint(id: 16,
              name: "Su-miu",
              function: "I can use it very well to deal with nasal congestion, rhinitis and the like",
              tips: "If your nose is bleeding, massage me and I'll stop the bleeding",
              matrix: simd_float4x4([[3, 0, 0, 0], [0, 3, 0, 0], [0, 0, 3, 0], [0.08, 0.04, -0.16, 1.0]]),recommendation: 0)
]

func initAcus()
{
    fullacupoints[0].matrix = trans1(eye: de, mouth: dm, nose: dn)
    fullacupoints[1].matrix = trans2(eye: de, mouth: dm, nose: dn)
    fullacupoints[2].matrix = trans3(eye: de, mouth: dm, nose: dn)
    fullacupoints[3].matrix = trans4(eye: de, mouth: dm, nose: dn)
    fullacupoints[4].matrix = trans5(eye: de, mouth: dm, nose: dn)
    fullacupoints[5].matrix = trans6(eye: de, mouth: dm, nose: dn)
    fullacupoints[6].matrix = trans7(eye: de, mouth: dm, nose: dn)
    fullacupoints[7].matrix = trans8(eye: de, mouth: dm, nose: dn)
    fullacupoints[8].matrix = trans9(eye: de, mouth: dm, nose: dn)
    fullacupoints[9].matrix = trans10(eye: de, mouth: dm, nose: dn)
    fullacupoints[10].matrix = trans11(eye: de, mouth: dm, nose: dn)
    fullacupoints[11].matrix = trans12(eye: de, mouth: dm, nose: dn)
    fullacupoints[12].matrix = trans13(eye: de, mouth: dm, nose: dn)
    fullacupoints[13].matrix = trans14(eye: de, mouth: dm, nose: dn)
    fullacupoints[14].matrix = trans15(eye: de, mouth: dm, nose: dn)
    fullacupoints[15].matrix = trans15(eye: de, mouth: dm, nose: dn)
    
}

func trans1(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //迎香穴
    let x:Float = mouthMatrix[3][0]
    let y:Float = noseMatrix[3][1]
    let z:Float = mouthMatrix[3][2]+0.2*abs(mouthMatrix[3][2]-eyeMatrix[3][2])
    
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans2(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //地仓穴
    let x:Float = noseMatrix[3][0]+0.5*abs(noseMatrix[3][0]-eyeMatrix[3][0])
    let y:Float = mouthMatrix[3][1]
    let z:Float = noseMatrix[3][2] + abs(noseMatrix[3][2]-eyeMatrix[3][2])
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans3(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //人中穴
    let x:Float = 0
    let y:Float = noseMatrix[3][1] + 0.42*abs(noseMatrix[3][1]-mouthMatrix[3][1])
    let z:Float = mouthMatrix[3][2] - 0.3*abs(noseMatrix[3][1]-mouthMatrix[3][1])
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans4(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //人中穴
    let x:Float = 0
    let y:Float = mouthMatrix[3][1] + 0.85*abs(noseMatrix[3][1]-mouthMatrix[3][1])
    let z:Float = mouthMatrix[3][2]
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans5(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 0
    let y:Float = noseMatrix[3][1] + 0.65*abs(noseMatrix[3][1]-mouthMatrix[3][1])
    let z:Float = mouthMatrix[3][2]-0.3*abs((mouthMatrix[3][2] - eyeMatrix[3][2]))
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans6(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = eyeMatrix[3][0]
    let y:Float = eyeMatrix[3][1]
    let z:Float = eyeMatrix[3][2]
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans7(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 0
    let y:Float = eyeMatrix[3][1] - 0.5 * abs(noseMatrix[3][1] - mouthMatrix[3][1])
    let z:Float = mouthMatrix[3][2]
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans8(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 0.39 * eyeMatrix[3][0]
    let y:Float = eyeMatrix[3][1]
    let z:Float = eyeMatrix[3][2]
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans9(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = noseMatrix[3][0]+0.5*abs(noseMatrix[3][0]-eyeMatrix[3][0])
    let y:Float = eyeMatrix[3][1] + 0.5*abs(eyeMatrix[3][1] - noseMatrix[3][1])
    let z:Float = noseMatrix[3][2] + abs(noseMatrix[3][2]-eyeMatrix[3][2])
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans10(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = noseMatrix[3][0]+0.5*abs(noseMatrix[3][0]-eyeMatrix[3][0])
    let y:Float = noseMatrix[3][1]
    let z:Float = noseMatrix[3][2] + abs(noseMatrix[3][2]-eyeMatrix[3][2])
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans11(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 0.39 * eyeMatrix[3][0]
    let y:Float = 1.4 * (eyeMatrix[3][1] - 0.5*abs(noseMatrix[3][1]-mouthMatrix[3][1]))
    let z:Float = noseMatrix[3][2]
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans12(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 0.39 * eyeMatrix[3][0]
    let y:Float = eyeMatrix[3][1] + 0.5*abs(noseMatrix[3][1]-eyeMatrix[3][1])
    let z:Float = noseMatrix[3][2]
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans13(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 1.15 * eyeMatrix[3][0]
    let y:Float = eyeMatrix[3][1] - 0.5*abs(noseMatrix[3][1]-mouthMatrix[3][1])
    let z:Float = noseMatrix[3][2] + abs(0.7*(noseMatrix[3][1] - mouthMatrix[3][1]))
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans14(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = noseMatrix[3][0]+0.5*abs(noseMatrix[3][0]-eyeMatrix[3][0])
    let y:Float = 1.4 * (eyeMatrix[3][1] - 0.5*abs(noseMatrix[3][1]-mouthMatrix[3][1]))
    let z:Float = noseMatrix[3][2] + abs(0.7*(noseMatrix[3][1] - mouthMatrix[3][1]))
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans15(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = noseMatrix[3][0]+0.5*abs(noseMatrix[3][0]-eyeMatrix[3][0])
    let y:Float = 2 * (eyeMatrix[3][1] - 0.5*abs(noseMatrix[3][1]-mouthMatrix[3][1]))
    let z:Float = noseMatrix[3][2] + abs(0.7*(noseMatrix[3][1] - mouthMatrix[3][1]))
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}
func trans16(eye eyeMatrix:simd_float4x4,mouth mouthMatrix:simd_float4x4,nose noseMatrix:simd_float4x4) -> simd_float4x4
{
    //
    let x:Float = 0
    let y:Float = eyeMatrix[3][1] + 0.4*abs(eyeMatrix[3][1] - mouthMatrix[3][1])
    let z:Float = 1.1*(mouthMatrix[3][2]-0.3*abs((mouthMatrix[3][2] - eyeMatrix[3][2])))
    return simd_float4x4([[3.0, 0.0, 0.0, 0.0], [0.0, 3.0, 0.0, 0.0], [0.0, 0.0, 3.0, 0.0], [x, y, z, 1.0]])
}

