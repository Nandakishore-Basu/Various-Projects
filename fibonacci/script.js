function fib(x) {
    if (x<=1) {
        if (x===1) {return 1}
        else {return 0}
    }
    return fib(x-1) + fib(x-2)
}
function get(e) {
    e.preventDefault()
    let val = document.querySelector("#uptoTerm").value
    if (val<0 || val=='') {
        val = 2
        document.querySelector("#uptoTerm").value = 2
    }
    let fibArr = []
    for (let i = 0; i < val; i++) {
        fibArr[i] = fib(i)
    }
    series.innerText = fibArr
}
function upto() {
    let val = document.querySelector("#uptoTerm").value
    if (val<=0) {
        p1.innerText = "Upto - Invalid"
    }
    else {
        p1.innerText = `Upto - ${fib(val-1)}`
    }
}

const btn1 = document.querySelector("#btn1")
let input = document.querySelector("#uptoTerm")
let p1 = document.querySelector("#p1")
let series = document.querySelector("#series")

input.addEventListener("change", upto)
btn1.addEventListener("click", get)
document.addEventListener("keypress", (e) => {
    if (e.key == 'enter') {
        get(e)
    }
})