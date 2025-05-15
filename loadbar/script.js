let loader = document.querySelector('#color')
let btn = document.querySelector('#btn')
const load = () => {
    loader.classList.add('loading')
}
btn.addEventListener('click', load)
let btn2 = document.querySelector('#btn2')
const reset = () => {
    loader.classList.remove('loading')
}
btn2.addEventListener('click', reset)
