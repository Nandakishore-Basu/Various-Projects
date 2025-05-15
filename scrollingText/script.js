function color() {
    r = Math.floor(Math.random()*256)
    g = Math.floor(Math.random()*256)
    b = Math.floor(Math.random()*256)
    x = `rgb(${r},${g},${b})`
    document.body.style.background = x
}
document.addEventListener("mousemove", color)