import{r as n,a,j as i,F as O}from"./jsx-runtime-f40812bf.js";import{b as H,f as P,J as v,L as e,ba as A,bj as u,ab as h,C as d,bf as S,ap as C,bk as M,bl as p,S as f}from"./Phone-4e9b2e8a.js";import"./number-28525126.js";const T=n.createContext(null);function U(){const[r,t]=n.useState([]),o=H(f.Unlocked),[c,l]=n.useState(null),[m,E]=n.useState(1);return n.useEffect(()=>{E(Math.floor(Math.random()*5)+1)},[o]),n.useEffect(()=>{P("Home",{action:"getHomes"}).then(s=>{s&&t(s)})},[]),a("div",{className:"home-container",style:{backgroundImage:`url(./assets/img/backgrounds/default/apps/home/${m}.png)`},children:[i(v.div,{animate:{backdropFilter:"blur(10px) brightness(0.75)"},exit:{backdropFilter:"inherit"},transition:{duration:1},className:"blur-overlay"}),i("div",{className:"home-header",children:c?a(O,{children:[i("div",{className:"title",children:e("APPS.HOME.MY_HOME")}),i(A,{className:"close",onClick:()=>l(null)})]}):i(O,{children:a("div",{className:"title",children:[i(u,{})," ",e("APPS.HOME.MY_HOMES")]})})}),i("div",{className:"home-wrapper",children:c?i(_,{data:c}):i("div",{className:"items",children:r.map((s,N)=>a("div",{className:"item small",onClick:()=>l(s),children:[i("div",{className:"icon blue",children:i(u,{})}),a("div",{className:"info",children:[i("div",{className:"title",children:s.label}),s.id&&a("div",{className:"value",children:["#",s.id]})]})]},N))})})]})}const _=({data:r})=>{const[t,o]=n.useState(r),c=n.useRef(null);return a(O,{children:[a("div",{className:"title",children:[e("APPS.HOME.ACTIONS"),i(h,{})]}),a("div",{className:"category",children:[a("div",{className:"item",onClick:()=>{d.PopUp.set({title:e("APPS.HOME.WAYPOINT_POPUP.TITLE"),description:e("APPS.HOME.WAYPOINT_POPUP.TEXT").format({home:t.label}),buttons:[{title:e("APPS.HOME.WAYPOINT_POPUP.CANCEL")},{title:e("APPS.HOME.WAYPOINT_POPUP.PROCEED"),cb:()=>{P("Home",{action:"setWaypoint",id:t.id,houseData:t})}}]})},children:[i("div",{className:"icon blue",children:i(S,{})}),a("div",{className:"info",children:[i("div",{className:"title",children:e("APPS.HOME.LOCATION")}),i("div",{className:"value",children:e("APPS.HOME.SET_WAYPOINT")})]})]}),t.locked!==void 0&&a("div",{className:`item ${t.locked?"active":""}`,onClick:()=>{d.PopUp.set({title:e("APPS.HOME.LOCK_POPUP.TITLE").format({toggle:t.locked?e("APPS.HOME.UNLOCK"):e("APPS.HOME.LOCK")}),description:e("APPS.HOME.LOCK_POPUP.TEXT").format({toggle:(t.locked?e("APPS.HOME.UNLOCK"):e("APPS.HOME.LOCK")).toLowerCase()}),buttons:[{title:e("APPS.HOME.LOCK_POPUP.CANCEL")},{title:e("APPS.HOME.LOCK_POPUP.PROCEED"),cb:()=>{P("Home",{action:"toggleLocked",id:t.id,uniqueId:t.uniqueId,houseData:t}).then(l=>{l!==void 0&&o({...t,locked:l})})}}]})},children:[i("div",{className:"icon blue",children:i(C,{})}),a("div",{className:"info",children:[i("div",{className:"title",children:e("APPS.HOME.FRONT_DOOR")}),i("div",{className:"value",children:t.locked?e("APPS.HOME.LOCKED"):e("APPS.HOME.UNLOCKED")})]})]}),a("div",{className:"item",onClick:()=>{d.PopUp.set({title:e("APPS.HOME.GIVE_KEY_POPUP.TITLE"),description:e("APPS.HOME.GIVE_KEY_POPUP.TEXT"),input:{placeholder:"0",type:"text",minCharacters:1,onChange:l=>c.current=l},buttons:[{title:e("APPS.HOME.GIVE_KEY_POPUP.CANCEL")},{title:e("APPS.HOME.GIVE_KEY_POPUP.PROCEED"),cb:()=>{c&&P("Home",{action:"addKeyholder",id:t.id,source:c.current,houseData:t}).then(l=>{l&&(c.current=null,o({...t,keyholders:l}))})}}]})},children:[i("div",{className:"icon yellow",children:i(M,{})}),a("div",{className:"info",children:[i("div",{className:"title",children:e("APPS.HOME.GIVE_KEY")}),i("div",{className:"value",children:e("APPS.HOME.MANAGE")})]})]})]}),a("div",{className:"title",children:[e("APPS.HOME.KEY_ACCESS"),i(h,{})]}),i("div",{className:"category scroll",children:t==null?void 0:t.keyholders.map((l,m)=>a("div",{className:"item small full",onClick:()=>{d.PopUp.set({title:e("APPS.HOME.REMOVE_KEY_POPUP.TITLE"),description:e("APPS.HOME.REMOVE_KEY_POPUP.TEXT").format({name:l.name}),buttons:[{title:e("APPS.HOME.REMOVE_KEY_POPUP.CANCEL")},{title:e("APPS.HOME.REMOVE_KEY_POPUP.PROCEED"),cb:()=>{P("Home",{action:"removeKeyholder",id:t.id,identifier:l.identifier,houseData:t}).then(E=>{E&&o({...t,keyholders:t.keyholders.filter(s=>s!==l)})})}}]})},children:[i("div",{className:"icon blue",children:i(p,{})}),a("div",{className:"info",children:[i("div",{className:"title",children:l.name}),i("div",{className:"value",children:e("APPS.HOME.MANAGE")})]})]},m))})]})};export{T as HomeContext,U as default};
