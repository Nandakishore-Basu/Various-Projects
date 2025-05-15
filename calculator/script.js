let str = ''
let p1 = document.querySelector("#p1")
let eq = document.getElementById("=")
let ac = document.getElementById("ac")
let del = document.getElementById("del")
let btns = document.querySelectorAll('button')

function r1() {
    str = str.slice(0, str.length-1)
    p1.value = str
}
function ent() {
    str = eval(str)
    p1.value = str
}
function acF() {
    str = ''
    p1.value = str
}

btns.forEach((btn)=>{
    if (btn == eq || btn == ac || btn == del){
        ac.addEventListener('click',acF)
        eq.addEventListener('click',ent)    
    }
    else{
        btn.addEventListener('click', ()=>{
            str += btn.innerText
            p1.value = str
        })

    }
})
del.addEventListener('click', r1)
document.addEventListener('keydown', (e)=>{
    e.preventDefault()
    e.key == 1? str += 1:false
    e.key == 2? str += 2:false
    e.key == 3? str += 3:false
    e.key == 4? str += 4:false
    e.key == 5? str += 5:false
    e.key == 6? str += 6:false
    e.key == 7? str += 7:false
    e.key == 8? str += 8:false
    e.key == 9? str += 9:false
    e.key == 0? str += 0:false
    e.key == '+'? str += '+':false
    e.key == '-'? str += '-':false
    e.key == '/'? str += '/':false
    e.key == '*'? str += '*':false
    e.key == '.'? str += '0.':false
    e.key == 'Enter'? ent():false
    e.key == 'Backspace'? r1():false
    e.key == (e.shiftKey && 'Backspace')? acF():false
    e.key == '^'? str+='**':false
    
    p1.value = str
})