let time = document.querySelector("#time")
let start = document.querySelector("#start")
let stop = document.querySelector("#stop")
let interval
let isOn = false

stop.style.display = 'none'
function enter(e) {
    if (e.key == 'Enter') {
        if (isOn == false) {
            getTime()
            isOn = true
        } else {
            stopTime()
            isOn = false
        }
    }
}
function getTime() {
    interval = setInterval(()=>{
        x = new Date().toLocaleTimeString()
        time.innerText = x
    }, 1000)
    start.style.display = 'none'
    stop.style.display = 'initial'
    isOn = true
}
function stopTime() {
    clearInterval(interval)
    time.innerText = "Press Start to get Current Time or hit 'Enter'"
    start.style.display = 'initial'
    stop.style.display = 'none'
    isOn = false
}

document.addEventListener("keypress", enter)
xyz = start.addEventListener("click", getTime)
stop.addEventListener("click", stopTime)
