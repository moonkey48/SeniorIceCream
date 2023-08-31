# SeniorIceCream
![Free_Iphone_14_Pro_Mockup_5](https://github.com/moonkey48/SeniorIceCream/assets/105622985/d40a4a3b-fd65-4dda-9677-4942028e5b69)
<div align="center">
  <img width="150" alt="Group 2790" src="https://github.com/moonkey48/SeniorIceCream/assets/105622985/ebaf6fcc-68ee-460d-b4be-af2acb9ec361">
  
  [TestFlight에서 SeniorBuyIceCream을 체험해보세요😁](https://testflight.apple.com/join/yFxblWKm)
  
</div>

## 나이 != 나이
> 🍦SeniorIceCream🍦은 아이스크림 내기 앱입니다.<br/> 영어 이름을 입력하시고 가장 연장자가 아이스크림을 시원하게 사주세요🤩🍨🤩 
<br/>

### 기능

✅ 영어 이름 입력시 Agify API를 통해 해당 이름의 평균 나이를 가져옵니다. <br/>
✅ 만약 한글이나 적절하지 않은 이름 입력시 수정 요청을 보여드립니다. <br/>
<br/>

### 기술 스택

✅ SwiftUI<br/>
✅ Combine<br/>
✅ Agify API<br/>

## 문제 상황 및 극복

#### 👾 문제 👾
> 비교를 위해 먼저 `Combine`을 사용하지 않고 Agify를 사용해서 기능을 구현하였다. 하지만 `Combine`을 통해 구현할 때 `sink`를 통해 데이터를 받지 못하고 있는 문제가 있었다.

<br/>

#### 😇 해결 😇
> 문제는 Cancelable에 대한 이해 부족이었다. Subscription은 Cancellable 프로토콜을 준수하는데 모든 Cancellable은 저장되지 않을 경우 즉시 구독이 취소된다. 따라서 `private var canclablle = Set<AnyCancellable>()`과 `.store(in: &canclablle)`를 통해 `Cancellable`을 저장해줌으로 문제를 해결할 수 있었다.

<br/>

#### 💬 회고 💬
> 기본 지식이 부족한 상태로 기술을 사용하는 것은 눈을 반쯤 가리고 운전하는 것 같았다. 기본 지식에 대한 분명한 이해를 하고, 문제를 해결하고 나서도 잘 정리를 해서 같은 문제가 발생하지 않게 정리를 해두어야겠다. `Cancellable`에 대한 분명한 이해를 가지고 다른 프로젝트에 적용해야 할 것 같다. 
