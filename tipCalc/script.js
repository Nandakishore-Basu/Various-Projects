let btn = document.querySelector('#sub')
let val = document.querySelector('#val')
let pcent = document.querySelector('#tip')
let res = document.querySelector('#res')
btn.addEventListener('click', (e)=>{
    e.preventDefault()
    calc()
})
function calc() {
    val.value == ''? val.value = 0:false
    pcent.value == ''? pcent.value = 0:false
    let money = Number(val.value)
    let percent = Number(pcent.value)
    let final = money + (money*(percent/100))
    res.innerText = final
}