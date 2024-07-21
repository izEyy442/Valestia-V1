var ye=Object.defineProperty;var Re=(t,n,S)=>n in t?ye(t,n,{enumerable:!0,configurable:!0,writable:!0,value:S}):t[n]=S;var Z=(t,n,S)=>(Re(t,typeof n!="symbol"?n+"":n,S),S);import{r as m,j as e,F as ie,a as o}from"./jsx-runtime-f40812bf.js";import{f as L,b as k,u as ee,U as be,H as me,I as _e,L as r,n as j,V as Ve,p as $e,W as Ce,X as de,k as re,Y as Te,C as F,h as te,Z as Fe,_ as Ge,a0 as Ae,d as q,v as H,G as Ye,a1 as ge,a2 as je,c as B,a3 as He,a4 as Ne,K as xe,M as Xe,J as le,a5 as ce,i as qe,t as Be,a6 as We,y as Qe,z as ze,a7 as Ke,x as Oe,m as K,a8 as Je,s as we,a9 as Ze,aa as et,ab as tt}from"./Phone-4e9b2e8a.js";import{r as ve,f as Me}from"./number-28525126.js";const pe=(t,n=25,S=7,b=360,h=120)=>new Promise((a,l)=>{let c=document.createElement("canvas");c.width=b,c.height=h;let u=c.getContext("2d");u.fillStyle="#000";let d=new AudioContext;t.arrayBuffer().then(i=>d.decodeAudioData(i)).then(i=>{let A=(c.width-(n-1)*S)/n,C=c.height/2,V=Math.floor(i.length/n),f=i.getChannelData(0);for(let G=0;G<n;G++){let I=1,R=.1;for(let O=0;O<V;O++){let p=f[G*V+O];p<I&&(I=p),p>R&&(R=p)}let _=(1+I)*C,$=(R-I)*C;u.beginPath(),u.moveTo(G*(A+S),_),u.lineTo(G*(A+S),_+$),u.lineTo(G*(A+S)+A,_+$),u.lineTo(G*(A+S)+A,_),u.closePath(),u.fill()}c.toBlob(G=>a({blob:G,base64:c.toDataURL()}))})});class st{constructor(){Z(this,"recorder");Z(this,"chunks");Z(this,"stream");Z(this,"mute",()=>{this.recorder&&this.recorder.stream.getTracks().forEach(n=>n.enabled=!1)});Z(this,"unmute",()=>{this.recorder&&this.recorder.stream.getTracks().forEach(n=>n.enabled=!0)});this.recorder=null,this.chunks=[]}start(n){this.stream=n,this.recorder=new MediaRecorder(n),this.recorder.ondataavailable=S=>this.chunks.push(S.data),this.chunks=[],this.recorder.start(),L("isTalking").then(S=>{S?this.unmute():this.mute()})}stop(){const{recorder:n,chunks:S}=this;return new Promise(b=>{n.onstop=()=>{const h=new Blob(S,{type:n.mimeType}),a=new Audio;a.src=URL.createObjectURL(h),this.stream&&this.stream.getTracks().forEach(c=>c.stop());let l={blob:h};pe(h).then(c=>{pe(h,60,7,960,200).then(u=>{l.waveform={message:c.blob,placeholder:u.base64},a.duration===1/0?(a.currentTime=Number.MAX_SAFE_INTEGER,a.ontimeupdate=()=>b({...l,duration:Math.floor(a.duration+.5)})):b({...l,duration:Math.floor(a.duration+.5)})})})},n.stop()})}}function at(){const{User:t,View:n,UnreadMessages:S}=m.useContext(se),b=k(B.Settings),h=k(B.PhoneNumber),[a,l]=t,[c,u]=n,[d,i]=S,A=k(F.Emoji),[C,V]=m.useState(!1),[f,G]=m.useState(null),[I,R]=m.useState(!1),[_,$]=m.useState(!1),[O,p]=m.useState(0),[J,X]=m.useState(0),[P,w]=m.useState(!1),[y,M]=m.useState(!1),[N,v]=m.useState([]),[g,D]=m.useState(null),ae=m.useRef(null),ue=m.useRef(0),[Y,ne]=m.useState({content:"",attachments:[]}),x=k(te);m.useEffect(()=>{L("Messages",{action:"getMessages",page:0,id:a.id}).then(s=>{s&&s.length>0?v([...s.reverse()]):w(!0)})},[]);const oe=m.useRef(!1),Se=()=>{if(Y.content.length>0||Y.attachments.length>0||g){let s={sender:h,timestamp:Date.now(),id:a.id,content:Y.content,attachments:Y.attachments};if(b.airplaneMode)return v(E=>[...E,{...s,delivered:!1}]);if(g){if(oe.current)return;oe.current=!0,Ae("Image",g.waves.message).then(E=>{Ae("Audio",g.blob).then(T=>{s.content=`<!AUDIO-MESSAGE-IMAGE="${E}"-AUDIO="${T}"-DURATION="${g.duration}"!>`,L("Messages",{action:"sendMessage",number:a.number,content:s.content,id:a.id}).then(U=>{v(U?z=>[...z,s]:z=>[...z,{...s,delivered:!1}]),oe.current=!1,D(null)})})});return}if(g)return;L("Messages",{action:"sendMessage",number:a.number,content:Y.content,attachments:Y.attachments,id:a.id}).then(E=>{E?(v(T=>[...T,s]),D(null)):v(T=>[...T,{...s,delivered:!1}]),ne({content:"",attachments:[]}),ae.current&&(ae.current.value=""),q("info","Updating recent message cache state"),H.APPS.MESSAGES.messages.set(H.APPS.MESSAGES.messages.value.map(T=>T.id===a.id?{...T,timestamp:new Date().getTime(),lastMessage:s.content,unread:!1}:T))})}},Ee=s=>{if(x.EnableMessagePay&&!(!s&&s<=0)){if(s>((x==null?void 0:x.MaxTransferAmount)??Number.MAX_SAFE_INTEGER))return q("error","Amount is too high");F.PopUp.set({title:r("APPS.MESSAGES.PAY.SEND_TITLE").format({amount:x.CurrencyFormat.replace("%s",s.toString())}),description:r("APPS.MESSAGES.PAY.SEND_DESCRIPTION").format({amount:x.CurrencyFormat.replace("%s",s.toString()),name:a.name??j(a.number)}),buttons:[{title:r("APPS.MESSAGES.PAY.SEND_BUTTON_CANCEL")},{title:r("APPS.MESSAGES.PAY.SEND_BUTTON_SEND"),cb:()=>{L("Wallet",{action:"sendPayment",number:a.number,amount:s}).then(E=>{if(!E.success){q("error","Failed to send payment "+JSON.stringify(E)),setTimeout(()=>{F.PopUp.set({title:r("APPS.MESSAGES.PAYMENT_FAILED_POPUP.TITLE"),description:r("APPS.MESSAGES.PAYMENT_FAILED_POPUP.DESCRIPTION").format({error:E.reason}),buttons:[{title:r("APPS.MESSAGES.PAYMENT_FAILED_POPUP.CLOSE")}]})},500);return}let T={id:a.id,sender:h,content:`<!SENT-PAYMENT-${s}!>`,attachments:[],timestamp:Date.now()};v(U=>[...U,T])})}}]})}},Ie=s=>{if(!x.EnableMessagePay||!s&&s<=0)return;let E={sender:h,content:`<!REQUESTED-PAYMENT-${s}!>`,attachments:[],timestamp:Date.now()};L("Messages",{action:"sendMessage",number:a.number,content:E.content,attachments:[]}).then(T=>{v(T?U=>[...U,E]:U=>[...U,{...E,delivered:!1}])})},he=()=>{F.PopUp.set({title:r("APPS.MESSAGES.SEND_LOCATION_POPUP.TITLE"),description:r("APPS.MESSAGES.SEND_LOCATION_POPUP.TEXT"),buttons:[{title:r("APPS.MESSAGES.SEND_LOCATION_POPUP.CANCEL")},{title:r("APPS.MESSAGES.SEND_LOCATION_POPUP.SEND"),cb:()=>{L("Maps",{action:"getCurrentLocation"}).then(s=>{if(!s)return;let E={id:a.id,sender:h,content:`<!SENT-LOCATION-X=${ve(s.x,2)}Y=${ve(s.y,2)}!>`,attachments:[],timestamp:Date.now()};L("Messages",{action:"sendMessage",number:a.number,content:E.content,attachments:E.attachments,id:E.id}).then(T=>{v(T?U=>[...U,E]:U=>[...U,{...E,delivered:!1}])})})}}]})},De=()=>{if(P||y)return;let s=document.querySelector("#last");if(!s)return;!Ye(s)&&(M(!0),L("Messages",{action:"getMessages",page:J+1,id:a.id}).then(T=>{if(T&&T.length>0){let U=document.querySelector(".message-container");ue.current=U.scrollHeight,v([...T.reverse(),...N]),M(!1)}else w(!0)}),X(T=>T+1))};m.useEffect(()=>{let s=document.querySelector(".message-container");const E=s.scrollHeight;s.scrollTop+=E-ue.current,s.scroll},[N]),ee("messages:newMessage",s=>{a.id===s.id&&(b.airplaneMode||v(E=>[...E,{...s,timestamp:Date.now()}]))}),ee("messages:renameGroup",s=>{a.id===s.channelId&&(b.airplaneMode||l(E=>({...E,name:s.name})))}),ee("messages:messageDeleted",s=>{s&&(b.airplaneMode||v(N.filter(E=>E.id!==s)))}),ee("messages:removeMember",s=>{a.id===s.channelId&&(b.airplaneMode||s.number===h&&(u("userlist"),l(null)))});const Ue=be(s=>{let E=s.target;for(;!E.classList.contains("message");)E=E.parentElement;let T=E.getAttribute("data-id");if(!T)return;let U=N.find(z=>z.id===T);U&&U.sender===h&&(fe(U.content)||Le(U.content)||Pe(U.content)||F.ContextMenu.set({buttons:[{title:r("APPS.MESSAGES.DELETE"),color:"red",cb:()=>{L("Messages",{action:"deleteMessage",id:T}).then(z=>{})}}]}))}),Le=s=>!s||!x.EnableMessagePay?!1:/<!SENT-PAYMENT-(\d*)!>/.test(s)?!0:!!/<!REQUESTED-PAYMENT-(\d*)!>/.test(s),fe=s=>{if(s)return/<!SENT-LOCATION-X=(-?\d*\.?\d*)Y=(-?\d*\.?\d*)!>/.test(s)},Pe=s=>{if(s)return s==="<!CALL-NO-ANSWER!>"},ke=s=>{if(s)return/<!AUDIO-MESSAGE-IMAGE="(.*)"-AUDIO="(.*)"-DURATION="(.*)"!>/.test(s)};return e(ie,{children:o("div",{className:"animation-slide left",children:[o(me,{children:[C&&e(ot,{setShow:V,setShowUserInfo:G,sendLocation:he,setData:l,data:a}),f&&e(ct,{setShow:G,user:a!=null&&a.isGroup?f:a})]}),o("div",{className:"message-header",children:[o("div",{className:"back",onClick:()=>{u("userlist"),l(null),a.unread&&(L("Messages",{action:"markRead",id:a.id}),i(s=>s-1))},children:[e(_e,{}),d>0&&e("span",{className:"back-title",children:d})]}),o("div",{className:"user",onClick:()=>{a.isGroup?V(!0):G(!0)},children:[a.isGroup?e("div",{className:"group-avatar",children:a.members.sort((s,E)=>s.avatar?1:-1).map((s,E)=>e("img",{src:s.avatar??"./assets/img/no-pfp.png",alt:""},E)).slice(0,5)}):e("img",{src:a.avatar??"./assets/img/no-pfp.png",className:"avatar"}),e("div",{className:"name",children:a.isGroup?a.name??`${a.members.length} ${r("APPS.MESSAGES.PEOPLE")}`:a.name??j(a.number)})]}),e(Ve,{className:`facetime ${a.isGroup?"hidden":""}`,onClick:()=>{a.isGroup||$e({number:a.number,videoCall:!0})}})]}),e("div",{className:"message-container",onScroll:De,style:_||I?{height:"48%"}:{},children:e("div",{className:"message-body",children:N.map((s,E)=>e(nt,{index:E,messages:N,message:s,longPressEvent:Ue,func:{isMissed:Pe,isLocation:fe,isVoiceMessage:ke,pay:Ee}}))})}),e("div",{className:"attachments",children:Y.attachments.map((s,E)=>o("div",{className:"attachment",children:[Ce(s)?e("video",{src:s,muted:!0,controls:!1,loop:!0,autoPlay:!0}):e("img",{src:s}),e(de,{onClick:()=>{ne({...Y,attachments:Y.attachments.filter((T,U)=>U!==E)})}})]},E))}),o("div",{className:"message-bottom",style:_||I?{height:"18%"}:{},children:[e("div",{className:"upper",children:o("div",{className:"input","data-border":!g,children:[g?o("div",{className:"audio-message",children:[e(de,{onClick:()=>D(null)}),e("div",{className:"audio-waves",children:e("img",{src:g.waves.placeholder})})]}):e(re,{placeholder:r("APPS.MESSAGES.PLACEHOLDER"),ref:ae,value:Y.content,onChange:s=>{ne({content:s.target.value,attachments:Y.attachments})},onKeyDown:s=>{s.key=="Enter"&&Se()}}),(Y.content.length>0||Y.attachments.length>0||g)&&e("div",{className:"send",onClick:()=>Se(),children:e(Te,{})})]})}),e("div",{className:"actions-wrapper",children:o("div",{className:"actions",children:[e("div",{className:"action",onClick:()=>{if(A)return F.Emoji.reset();F.Emoji.set({onSelect:s=>ne(E=>({content:`${E.content}${s.emoji}`,attachments:E.attachments}))})},children:e("img",{src:"./assets/img/icons/messages/emoji.png"})}),e("div",{className:"action",onClick:()=>{var s,E,T;Y.attachments.length<3&&F.Gallery.set({includeVideos:!0,allowExternal:(T=(E=(s=te)==null?void 0:s.value)==null?void 0:E.AllowExternal)==null?void 0:T.Messages,onSelect:U=>ne({...Y,attachments:[...Y.attachments,U.src]})})},children:e("img",{src:"./assets/img/icons/messages/gallery.png"})}),(x==null?void 0:x.EnableMessagePay)&&!a.isGroup&&e("div",{className:"action black",onClick:()=>{R(!1),$(s=>!s)},children:"$"}),e("div",{className:"action",onClick:()=>he(),children:e(Fe,{})}),(x==null?void 0:x.EnableVoiceMessages)&&e("div",{className:"action blue",onClick:()=>{$(!1),R(s=>!s)},children:e(Ge,{})})]})}),_&&e(it,{paymentAmount:O,setPaymentAmount:p,pay:Ee,request:Ie}),I&&e(rt,{onEnd:s=>{s&&(D({src:URL.createObjectURL(s.blob),blob:s.blob,waves:s.waveform,duration:s.duration}),R(!1))}})]})]})})}const nt=({messages:t,message:n,index:S,longPressEvent:b,func:h})=>{var _,$;const{User:a}=m.useContext(se),l=k(B.PhoneNumber),[c]=a,u=k(te);let d,i,A,C,V,f,G=S===0?"last":"",I=n.sender===l?"self":"other",R=((_=t[S+1])==null?void 0:_.sender)===l?"self":"other";if(t[S+1]?A=Math.abs(n.timestamp-t[S+1].timestamp)/36e5:R=void 0,c.isGroup)d=($=c.members.find(O=>O.number===n.sender))==null?void 0:$.name,i=!t[S-1]||t[S-1].sender!==n.sender;else if(n.content)if(h.isMissed(n.content))if(I==="other")n.content=r("APPS.MESSAGES.MISSED_CALL").format({number:n.sender});else return null;else/<!SENT-PAYMENT-(\d*)!>/.test(n.content)?C={amount:n.content.match(/\d/g).join(""),request:!1}:/<!REQUESTED-PAYMENT-(\d*)!>/.test(n.content)&&(C={amount:n.content.match(/\d/g).join(""),request:!0});if(h.isLocation(n.content)){let O=n.content.match(/X=(-?\d*\.?\d*)Y/)[1],p=n.content.match(/Y=(-?\d*\.?\d*)!>/)[1];V={x:O,y:p}}return h.isVoiceMessage(n.content)&&(f={wave:n.content.match(/AUDIO-MESSAGE-IMAGE="([^"]+)"/)[1],src:n.content.match(/AUDIO="([^"]+)"/)[1],duration:n.content.match(/DURATION="([^"]+)"/)[1]}),o("div",{className:`message ${I}`,id:G,"data-id":n.id,...b,children:[i&&I=="other"&&e("div",{className:"user",children:d??j(n.sender)}),n.delivered===!1?o("div",{className:"content-wrapper",children:[C&&e("div",{className:"payment",children:u.CurrencyFormat.replace("%s",C.amount)}),e("div",{className:"content",children:ge(n.content)}),e(je,{})]}):C||V||f?o(ie,{children:[V&&o("div",{className:"location",onClick:()=>{B.App.set({name:"Maps",data:{location:[V.y,V.x],name:`${d??j(n.sender)}'s location`,icon:c.avatar}})},children:[e("div",{className:"img",style:{backgroundImage:'url("https://img.gta5-mods.com/q95/images/mirror-park-garden/2b72f9-20160428154103_1.jpg")'}}),I==="other"&&o("div",{className:"sender",children:[d??j(n.sender)," ",r("APPS.MESSAGES.SENT_LOCATION")]})]}),C&&e("div",{className:"payment",children:C.request?o("div",{className:`request ${I}`,children:[o("div",{className:"title",children:[u.CurrencyFormat.replace("%s",Me(C.amount)),r("APPS.MESSAGES.PAY.REQUESTED")]}),I==="other"&&e("div",{className:"button",onClick:()=>h.pay(C.amount),children:r("APPS.MESSAGES.PAY.PAY")})]}):e("div",{className:"sent",children:u.CurrencyFormat.replace("%s",Me(C.amount))})}),f&&e(lt,{data:f,sender:I})]}):n.content&&e("div",{className:"content",children:ge(n.content)}),n.attachments&&n.attachments.length>0&&e("div",{className:"attatchments",children:n.attachments.map((O,p)=>Ce(O)?e("video",{src:O,controls:!1,loop:!0,autoPlay:!0,muted:!0,onClick:J=>{F.FullscreenImage.set({display:!0,image:O})}},p):e(He,{src:O,onClick:()=>{F.FullscreenImage.set({display:!0,image:O})}},p))}),n.delivered===!1?e("div",{className:"status",children:r("APPS.MESSAGES.NOT_DELIVERED")}):t[S+1]&&A>6?e("div",{className:"date",children:Ne(n.timestamp)}):I!==R&&e("div",{className:"date",children:Ne(n.timestamp)})]},S)},rt=({onEnd:t})=>{const n=k(te),[S,b]=m.useState(!1),h=m.useRef(null);return n.EnableVoiceMessages?(m.useEffect(()=>{h.current=new st},[]),ee("camera:toggleMicrophone",a=>{h!=null&&h.current&&(a?h.current.unmute():h.current.mute())}),e("div",{className:"audioMessage-container",children:e("div",{className:"audioMessage-button","data-recording":S,onClick:()=>{var l;if(!((l=navigator.mediaDevices)!=null&&l.getUserMedia)||!(h!=null&&h.current))return q("error","No media devices found!");let a=h.current;S?a.stop().then(c=>{t(c),b(u=>!u)}):navigator.mediaDevices.getUserMedia({audio:!0}).then(c=>{a.start(c),b(u=>!u)})},children:S?e(de,{}):e(Ge,{})})})):null},it=({paymentAmount:t,setPaymentAmount:n,request:S,pay:b})=>{const h=k(te),[a,l]=m.useState(0),[c,u]=m.useState(4);let d={0:3,11:2.75,14:2.2};return m.useEffect(()=>{a===0&&u(d[0]);let i=0;for(let A=0;A<Object.keys(d).length;A++)a>=parseInt(Object.keys(d)[A])&&(i=d[Object.keys(d)[A]]);u(i)},[a]),m.useEffect(()=>{n(a)},[a]),o("div",{className:"payment-container",children:[o("div",{className:"payment-wrapper",children:[e("div",{className:"button",onClick:()=>t>0&&l(i=>i-1),children:"-"}),e("div",{className:"amount",children:e(re,{type:"number",value:t,style:{fontSize:`${c}rem`},onChange:i=>{if(i.target.value.match(/^[0-9]+$/)&&parseFloat(i.target.value)>0&&parseFloat(i.target.value)<(h.MaxTransferAmount??Number.MAX_SAFE_INTEGER))l(parseFloat(i.target.value));else return i.preventDefault()}})}),e("div",{className:"button",onClick:()=>l(i=>i+1),children:"+"})]}),o("div",{className:"payment-buttons",children:[e("div",{className:"button",onClick:()=>S(t),children:r("APPS.MESSAGES.PAY.REQUEST")}),e("div",{className:"button",onClick:()=>b(t),children:r("APPS.MESSAGES.PAY.SEND")})]})]})},lt=({data:t,sender:n})=>{var u;const[S,b]=m.useState(!1),[h,a]=m.useState(0),l=m.useRef(null);m.useEffect(()=>{l.current&&(l.current.onended=()=>{b(!1)})},[l]);const c=d=>{d=Math.floor(d);const i=Math.floor(d/60),A=d-i*60;return`${i<10?"0"+i:i}:${A<10?"0"+A:A}`};return o("div",{className:`voice-message ${n}`,children:[e("a",{onClick:()=>{l.current&&(S?(l.current.pause(),l.current.currentTime=0):l.current.play(),b(d=>!d))},children:S?e(xe,{}):e(Xe,{})}),o("div",{className:"wave",children:[e("div",{className:"overlay",style:{width:`${(t.duration-h)/t.duration*100}%`}}),e("img",{src:t.wave,alt:"wave"})]}),e("div",{className:"duration",children:c(S&&Math.floor(((u=l.current)==null?void 0:u.currentTime)+.5)!==0?l.current.currentTime:t.duration)}),e("audio",{ref:l,onTimeUpdate:d=>a(d.currentTarget.currentTime),children:e("source",{src:t.src,type:"audio/mpeg"})})]})},ct=({user:t,setShow:n})=>o(le.div,{...ce,className:"info-panel",children:[e("div",{className:"info-panel-header",children:e("div",{className:"done",onClick:()=>n(!1),children:r("APPS.MESSAGES.DONE")})}),o("div",{className:"info-panel-body",children:[o("div",{className:"info-panel-top",children:[t.avatar?e("div",{className:"profile-image bigger",style:{backgroundImage:`url(${t.avatar})`}}):t.name?e("div",{className:"profile-image bigger",children:qe(t.name)}):e("img",{src:t.avatar??"./assets/img/no-pfp.png",className:"avatar"}),e("div",{className:"name",children:t.name??j(t.number)})]}),e("div",{className:"items",children:!t.company&&o(ie,{children:[t.name&&e("div",{className:"info-section",children:e("div",{className:"item blue",onClick:()=>Be(t.number),children:j(t.number)})}),e("div",{className:"info-section",children:t.name?e("div",{className:"item blue",onClick:()=>{F.Share.set({type:"contact",data:{firstname:t.firstname,lastname:t.lastname,number:t.number,avatar:t.avatar}})},children:r("APPS.PHONE.CONTACTS.SHARE_CONTACT")}):e("div",{className:"item blue",onClick:()=>{B.App.set({name:"Phone",view:"newContact",data:t.number})},children:r("APPS.PHONE.CONTACTS.ADD_CONTACT")})})]})})]})]}),ot=t=>{const{View:n}=m.useContext(se),[S,b]=n,[h,a]=m.useState(!1),[l,c]=m.useState(null);let u=t.data,d=!u.members.find(i=>i.isOwner);return o(ie,{children:[e(me,{children:h&&e(dt,{setShow:a,members:u.members,id:u.id})}),o(le.div,{...ce,className:"info-panel",children:[e("div",{className:"info-panel-header",children:e("div",{className:"done",onClick:()=>{l&&l!==""&&l!==u.name?L("Messages",{action:"renameGroup",id:u.id,name:l}).then(i=>{t.setShow(!1)}):t.setShow(!1)},children:r("APPS.MESSAGES.DONE")})}),o("div",{className:"info-panel-body",children:[o("div",{className:"info-panel-top",children:[e("div",{className:"group-avatar",children:u.members.sort((i,A)=>i.avatar?1:-1).slice(0,10).map((i,A)=>e("img",{src:i.avatar??"./assets/img/no-pfp.png",alt:""},A))}),o("div",{className:"members",children:[u.members.length," ",r("APPS.MESSAGES.MEMBERS")]})]}),o("div",{className:"items",children:[e("div",{className:"info-section",children:o("div",{className:"item blue",children:[e(We,{className:"add"}),e(re,{defaultValue:u.name??"Group Name",onChange:i=>c(i.target.value)})]})}),o("div",{className:"info-section",children:[u.members.sort((i,A)=>i.name&&!A.name?-1:!i.name&&A.name?1:i.name<A.name?-1:i.name>A.name?1:0).map((i,A)=>o("div",{className:"item",children:[d&&e(Qe,{className:"remove",onClick:()=>{F.PopUp.set({title:r("APPS.MESSAGES.REMOVE_POPUP.TITLE"),description:r("APPS.MESSAGES.REMOVE_POPUP.TEXT").format({name:i.name??j(i.number)}),buttons:[{title:r("APPS.MESSAGES.CANCEL")},{title:r("APPS.MESSAGES.REMOVE_POPUP.REMOVE"),color:"red",cb:()=>{L("Messages",{action:"removeMember",number:i.number,id:u.id}).then(C=>{C&&(t.setData(V=>{let f=V;return f.members=f.members.filter(G=>G.number!==i.number),f}),t.setShow(!1))})}}]})}}),e("img",{src:i.avatar??"./assets/img/no-pfp.png",alt:""}),e("div",{className:"name",children:i.name??j(i.number)}),e(ze,{className:"info",onClick:()=>{t.setShowUserInfo({...i})}})]},A)),o("div",{className:"item blue",onClick:()=>a(!0),children:[e(Ke,{className:"add"}),r("APPS.MESSAGES.ADD_MEMBER")]})]}),e("div",{className:"info-section",children:e("div",{className:"item blue",onClick:()=>t.sendLocation(),children:r("APPS.MESSAGES.SHARE_LOCATION")})}),e("div",{className:"info-section",onClick:()=>{F.PopUp.set({title:r("APPS.MESSAGES.LEAVE_POPUP.TITLE"),description:r("APPS.MESSAGES.LEAVE_POPUP.TEXT"),buttons:[{title:r("APPS.MESSAGES.CANCEL")},{title:r("APPS.MESSAGES.LEAVE_POPUP.LEAVE"),color:"red",cb:()=>{L("Messages",{action:"leaveGroup",id:u.id}).then(i=>{if(!i)return q("info","Failed to leave group, server didnt callback request");b("userlist"),t.setShow(!1)})}}]})},children:e("div",{className:"item red",children:r("APPS.MESSAGES.LEAVE_GROUP")})})]})]})]})]})},dt=t=>{const n=k(B.PhoneNumber),[S,b]=m.useState(""),h=k(H.APPS.PHONE.contacts);let a=t.members;return o(le.div,{...ce,className:"add-member-container",children:[o("div",{className:"add-member-header",children:[o("div",{className:"top",children:[e("span",{}),e("div",{className:"title",children:r("APPS.MESSAGES.ADD_MEMBER")}),e("div",{className:"button",onClick:()=>t.setShow(!1),children:r("APPS.MESSAGES.CANCEL")})]}),e(Oe,{placeholder:r("APPS.MESSAGES.SEARCH"),onChange:l=>b(l.target.value)})]}),e("div",{className:"contacts",children:h.filter(l=>!l.company).sort((l,c)=>l.firstname&&!c.firstname?-1:!l.firstname&&c.firstname?1:l.firstname<c.firstname?-1:l.firstname>c.firstname?1:0).filter(l=>!a.find(c=>c.number===l.number)||l.number===n).filter(l=>{var c,u;return l.firstname.toLowerCase().includes(S.toLowerCase())||((u=(c=l==null?void 0:l.lastname)==null?void 0:c.toLowerCase())==null?void 0:u.includes(S.toLowerCase()))}).map((l,c)=>{let u=K(l.firstname,l.lastname);return o("div",{className:"contact",onClick:()=>{F.PopUp.set({title:r("APPS.MESSAGES.ADD_POPUP.TITLE"),description:r("APPS.MESSAGES.ADD_POPUP.TEXT").format({name:u}),buttons:[{title:r("APPS.MESSAGES.CANCEL")},{title:r("APPS.MESSAGES.ADD_POPUP.ADD"),cb:()=>{L("Messages",{action:"addMember",number:l.number,id:t.id}).then(d=>{d&&t.setShow(!1)})}}]})},children:[e("img",{src:l.avatar??"./assets/img/no-pfp.png"}),o("div",{className:"user",children:[e("div",{className:"name",children:u}),e("div",{className:"number",children:j(l.number)})]})]},c)})})]})};function mt(){const{User:t,View:n,Newmessage:S,ImportedUser:b}=m.useContext(se),[h,a]=t,[l,c]=n,[u,d]=b,i=k(B.PhoneNumber),[A,C]=S,V=k(H.APPS.PHONE.contacts),[f,G]=m.useState([]),I=m.useRef(null),[R,_]=m.useState(""),[$,O]=m.useState([]),[p,J]=m.useState({content:"",attachments:[]});m.useEffect(()=>{u&&(G([u]),d(null))},[u]);const X=()=>{(p.content.length>0||p.attachments.length>0)&&(f.length>1?L("Messages",{action:"createGroup",members:f,content:p.content,attachments:p.attachments}).then(P=>{P&&(a({isGroup:!0,members:f.map(w=>{let y=K(w.firstname,w.lastname);return{...w,name:y}}),lastMessage:p.content,timestamp:Date.now(),id:P}),c("messages"),C(!1))}):L("Messages",{action:"sendMessage",number:f[0].number,content:p.content,attachments:p.attachments}).then(P=>{var w,y,M,N;if(P){let v;f[0].name?v=f[0].name:(w=f[0])!=null&&w.firstname&&(v=K((y=f[0])==null?void 0:y.firstname,(M=f[0])==null?void 0:M.lastname));let g={number:f[0].number,name:v,avatar:(N=f[0])==null?void 0:N.avatar};a({...g,lastMessage:p.content,timestamp:Date.now(),id:P}),c("messages"),C(!1)}}))};return m.useEffect(()=>{if(R.length>0){if(V){const P=V.filter(w=>{let y=K(w.firstname,w.lastname);return y&&y.toLowerCase().includes(R.toLowerCase())&&!w.company});O(P)}}else O([])},[R]),o(le.div,{...ce,className:"new-message-container",children:[o("div",{className:"new-message-header",children:[e("span",{}),e("div",{className:"title",children:r("APPS.MESSAGES.NEW_MESSAGE")}),e("div",{className:"button",onClick:()=>{f.length>0&&(p.content.length>0||p.attachments.length>0)?X():C(!1)},children:f.length>0&&(p.content.length>0||p.attachments.length>0)?r("APPS.MESSAGES.SEND"):r("APPS.MESSAGES.CANCEL")})]}),o("div",{className:"new-message-body",children:[o("div",{className:"new-message-search",children:[o("div",{className:"to",children:[r("APPS.MESSAGES.TO"),":"]}),e("div",{className:"contacts",children:f.map((P,w)=>{let y=K(P.firstname,P.lastname),M=y!=="Unknown";return e("div",{className:`contact ${M?"green":"blue"}`,onClick:()=>{F.PopUp.set({title:r("APPS.MESSAGES.REMOVE_POPUP.TITLE"),description:r("APPS.MESSAGES.REMOVE_POPUP.TEXT").format({NAME:y??j(P.number)}),buttons:[{title:r("APPS.MESSAGES.CANCEL")},{title:r("APPS.MESSAGES.REMOVE_POPUP.REMOVE"),color:"red",cb:()=>{let N=f.filter(v=>v.number!==P.number);G(N)}}]})},children:M?y:j(P.number)},w)})}),e(re,{type:"text",ref:I,onChange:P=>{if(_(P.target.value),P.target.value.length==i.length&&/^\d+$/g.test(P.target.value)){if(P.target.value===i||f.find(y=>y.number==P.target.value))return;G([...f,{number:P.target.value}]),I.current.value="",_("")}},onKeyDown:P=>{var w;P.key=="Backspace"&&R.length==0?((w=f[f.length-1])==null?void 0:w.name)===void 0?(I.current.value=f[f.length-1].number,G(f.slice(0,f.length-1))):G(f.slice(0,-1)):P.key=="Tab"&&(P.preventDefault(),$.length==1&&(G([...f,$[0]]),I.current.value="",_("")))}})]}),e("div",{className:"search-results",children:$&&$.filter(P=>!f.find(w=>w.number==P.number)).map((P,w)=>{let y=K(P.firstname,P.lastname);return o("div",{className:"contact",onClick:()=>{f.find(N=>N.number==P.number)||(G([...f,P]),I.current.value="",_(""))},children:[e("img",{src:P.avatar??"./assets/img/no-pfp.png"}),o("div",{className:"user",children:[e("div",{className:"name",children:y}),e("div",{className:"number",children:j(P.number)})]})]},w)})})]}),f.length>0&&$.length===0&&e("div",{className:"message-bottom absolute",children:e("div",{className:"upper",children:o("div",{className:"input",children:[e(re,{placeholder:r("APPS.MESSAGES.PLACEHOLDER"),value:p.content,onChange:P=>{J({content:P.target.value??"",attachments:p.attachments})},onKeyDown:P=>{P.key=="Enter"&&X()}}),(p.content.length>0||p.attachments.length>0)&&e("div",{className:"send",onClick:()=>X(),children:e(Te,{})})]})})})]})}const Q=we([]),W=we([]);function ut(){const{User:t,View:n,Newmessage:S,UnreadMessages:b,ImportedUser:h}=m.useContext(se),a=k(B.PhoneNumber),l=k(B.Settings),c=k(B.App),[u,d]=t,[i,A]=n,[C,V]=h,[f,G]=S,[I,R]=b,_=k(H.APPS.PHONE.contacts),$=k(H.APPS.MESSAGES.messages),O=k(Q),[p,J]=m.useState(""),[X,P]=m.useState(!1),w=k(W);m.useEffect(()=>{$?(q("info","Using cache for recent messages"),Q.set($),R(O.filter(M=>M.unread).length)):L("Messages",{action:"getRecentMessages"}).then(M=>{let N=M.map(v=>{if(v.isGroup)return v.members=v.members.filter(g=>g.number!==a).map(g=>{let D=_.find(ae=>ae.number===g.number);return{name:D&&D.firstname?K(D==null?void 0:D.firstname,D==null?void 0:D.lastname):void 0,avatar:D==null?void 0:D.avatar,blocked:D==null?void 0:D.blocked,favourite:D==null?void 0:D.favourite,number:g.number,isOwner:g.isOwner}}),v;{let g=_.find(D=>D.number===v.number);return v.name=g!=null&&g.lastname?`${g.firstname} ${g.lastname}`:g==null?void 0:g.firstname,v.avatar=g==null?void 0:g.avatar,v}});R(N.filter(v=>v.unread).length),Q.set(N),q("info","setting cache"),H.APPS.MESSAGES.messages.set(N)})},[$]);let y=m.useRef(!1);return m.useEffect(()=>{if(!y.current&&c!=null&&c.data&&(y.current=!0,c!=null&&c.data&&c.view=="messages")){let M=O.find(N=>N.number===c.data.number);M?(d(M),A("messages")):(G(!0),V({number:c.data.number,name:c.data.name,avatar:c.data.avatar})),B.App.set({name:c.name})}},[c==null?void 0:c.data,O]),ee("messages:newMessage",M=>{let N=JSON.parse(JSON.stringify(O)),v=N.findIndex(g=>g.id===M.id);l.airplaneMode||(v!==-1&&N.unshift(N.splice(v,1)[0]),N[0].lastMessage=M.content,N[0].timestamp=new Date,Q.set(N))}),o(ie,{children:[e(me,{children:f&&e(mt,{})}),o("div",{className:`animation-slide ${O.length>0?"right":""}`,children:[o("div",{className:"messages-header",children:[o("div",{className:"buttons",children:[e("div",{className:"edit",onClick:()=>P(!X),children:X?r("APPS.MESSAGES.DONE"):r("APPS.MESSAGES.EDIT")}),e(Je,{"data-disabled":X,onClick:()=>G(!0)})]}),e("div",{className:"title",children:r("APPS.MESSAGES.TITLE")})]}),e(Oe,{placeholder:r("SEARCH"),onChange:M=>J(M.target.value)}),e("div",{className:"users-list",children:O.filter(M=>{var N;return M.deleted?!1:(M.isGroup?M.members.find(v=>{var g;return((g=v.name)==null?void 0:g.toLowerCase().includes(p.toLowerCase()))||v.number.includes(p)}):((N=M.name)==null?void 0:N.toLowerCase().includes(p.toLowerCase()))||M.number.includes(p))||M.lastMessage.toLowerCase().includes(p.toLowerCase())}).sort((M,N)=>N.timestamp-M.timestamp).map((M,N)=>e(St,{user:M,editMode:X,onClick:()=>{if(d(M),A("messages"),M.unread){L("Messages",{action:"markRead",id:M.id}),R(g=>g-1);let v=H.APPS.MESSAGES.messages.value;H.APPS.MESSAGES.messages.set(v.map(g=>(g.id===M.id&&(g.unread=!1),g)))}}},N))}),X&&o("div",{className:"messages-footer",children:[e("div",{className:"button","data-disabled":!0,children:r("APPS.MESSAGES.READ")}),e("div",{className:"button",onClick:()=>{if(w.length===0)return q("info","No messages selected, can't delete");F.PopUp.set({title:r("APPS.MESSAGES.DELETE_CONVERSATION.TITLE"),description:r("APPS.MESSAGES.DELETE_CONVERSATION.DESCRIPTION"),buttons:[{title:r("APPS.MESSAGES.CANCEL")},{title:r("APPS.MESSAGES.DELETE"),cb:()=>{L("Messages",{action:"deleteConversations",channels:w}).then(M=>{if(!M)return q("error","Failed to delete conversations");P(!1),Q.set(O.filter(N=>!w.includes(N.id))),H.APPS.MESSAGES.messages.set([...H.APPS.MESSAGES.messages.value.map(N=>(w.includes(N.id)&&(N.deleted=!0),N))]),W.set([])})}}]})},children:r("APPS.MESSAGES.DELETE")})]})]})]})}const St=({user:t,editMode:n,onClick:S})=>{const b=k(te),h=k(Q);k(W);const[a,l]=m.useState(!1);let c;const u=be(d=>{F.ContextMenu.set({buttons:[{title:r("APPS.MESSAGES.MARK_AS_READ"),cb:()=>{L("Messages",{action:"markRead",id:t.id}).then(i=>{if(!i)return q("error","Failed to mark message as read");Q.set(h.map(C=>(C.id===t.id&&(C.unread=!1),C)));let A=H.APPS.MESSAGES.messages.value;H.APPS.MESSAGES.messages.set(A.map(C=>(C.id===t.id&&(C.unread=!1),C)))})}},{title:r("APPS.MESSAGES.DELETE_CONVERSATION.TITLE"),color:"red",cb:()=>{F.PopUp.set({title:r("APPS.MESSAGES.DELETE_CONVERSATION.TITLE"),description:r("APPS.MESSAGES.DELETE_CONVERSATION.DESCRIPTION"),buttons:[{title:r("APPS.MESSAGES.CANCEL")},{title:r("APPS.MESSAGES.DELETE"),cb:()=>{L("Messages",{action:"deleteConversations",channels:[t.id]}).then(i=>{if(!i)return q("error","Failed to delete conversations");Q.set(h.filter(A=>A.id!==t.id)),H.APPS.MESSAGES.messages.set([...H.APPS.MESSAGES.messages.value.map(A=>(A.id===t.id&&(A.deleted=!0),A))]),W.set([])})}}]})}}]})});if(t.isGroup?t.name?c=t.name:c=t.members.sort((d,i)=>d.name&&!i.name?-1:!d.name&&i.name?1:d.name<i.name?-1:d.name>i.name?1:0).map((d,i)=>{if(i<2)return d.name?d.name:j(d.number);if(i===2)return`+${t.members.length-2} ${r("APPS.MESSAGES.OTHER").toLowerCase()}`}).join(" "):c=t.name,t.lastMessage==="Attachment"&&(t.lastMessage=r("APPS.MESSAGES.SENT_A_PHOTO")),/<!SENT-PAYMENT-(\d*)!>/.test(t.lastMessage)){let d=t.lastMessage.match(/\d/g).join("");t.lastMessage=`${r("APPS.MESSAGES.SENT")} ${b.CurrencyFormat.replace("%s",d)}`}else if(/<!REQUESTED-PAYMENT-(\d*)!>/.test(t.lastMessage)){let d=t.lastMessage.match(/\d/g).join("");t.lastMessage=`${r("APPS.MESSAGES.REQUESTED")} $${d}`}else if(/<!SENT-LOCATION-X=(-?\d*\.?\d*)Y=(-?\d*\.?\d*)!>/.test(t.lastMessage))t.lastMessage=`${r("APPS.MESSAGES.SENT_LOCATION_SHORT")}`;else if(t.lastMessage.startsWith('<!AUDIO-MESSAGE-IMAGE="'))t.lastMessage=r("APPS.MESSAGES.SENT_AUDIO_MESSAGE");else if(t.lastMessage==="<!CALL-NO-ANSWER!>")t.lastMessage=r("APPS.MESSAGES.TRIED_TO_CALL").format({number:j(t.number)});else if(t.lastMessage==="")return;return m.useEffect(()=>{a?W.set([...W.value,t.id]):W.set(W.value.filter(d=>d!==t.id))},[a]),o("div",{className:"user",...u,onClick:()=>{n?l(!a):S()},children:[o("div",{className:"items",children:[n&&e("div",{className:"check","data-checked":a,onClick:d=>{d.stopPropagation(),l(!a)},children:a&&e(Ze,{})}),t.unread?e("div",{className:"unread"}):""]}),t.isGroup?e("div",{className:"avatar group",children:t.members.map((d,i)=>{if(i<=4)return d.avatar?e("div",{style:{backgroundImage:`url(${d.avatar})`}},i):d.name?e("div",{children:d.name.charAt(0)},i):e("div",{className:"unknown"},i)})}):e("img",{className:"avatar",src:t.avatar??"assets/img/no-pfp.png"}),o("div",{className:"user-body",children:[o("div",{className:"user-header",children:[e("div",{className:"name",children:c??j(t.number)}),o("div",{className:"right",children:[e("div",{className:"time",children:et(t.timestamp)}),e(tt,{})]})]}),e("div",{className:"content",children:t.lastMessage.length>40?t.lastMessage.substring(0,40)+"...":t.lastMessage})]})]})};const se=m.createContext(null);function At(){const[t,n]=m.useState(null),[S,b]=m.useState("userlist"),[h,a]=m.useState(null),[l,c]=m.useState(0),[u,d]=m.useState(!1);return e("div",{className:"messages-container",children:e(se.Provider,{value:{User:[t,n],View:[S,b],Newmessage:[u,d],ImportedUser:[h,a],UnreadMessages:[l,c]},children:S=="userlist"?e(ut,{}):e(at,{})})})}export{se as MessagesContext,At as default};
