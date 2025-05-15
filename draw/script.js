const canvas = document.querySelector("canvas")
const ctx = canvas.getContext("2d")
const rect = canvas.getBoundingClientRect()

canvas.addEventListener("mousemove", (e) => {
    const a = Math.floor(Math.random()*256)
    const b = Math.floor(Math.random()*256)
    const c = Math.floor(Math.random()*256)
    const x = e.clientX - rect.left
    const y = e.clientY - rect.top
    ctx.fillStyle = `rgb(${a}, ${b}, ${c})`
    ctx.fillRect(x,y,2,2)
})