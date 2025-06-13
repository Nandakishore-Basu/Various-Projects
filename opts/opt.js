function add(...args) {
    let x = 0
    for (const num of args) {
        x+=num
    }
    console.log(x)
    return x
}

add(5,6,7)