function l(x) {
    console.log(x)
}
function bln(x) {
    for (let i = 0; i < x; i++) {
       l('')
    }
}

let names = ["SR", "NKB", "MRB", "NR", "BR"]

for (const idx in names) {
    l(idx)
}
bln(1)
for (const idx in names) {
    l(names[idx])
}
bln(2)
for (const name of names) {
    l(name)
}
bln(2)
names.forEach(name => l(name))
bln(5)

let nums = [5,6,8,7,45,5,8,8,9]
l(`Original : ${nums}`)
let a = nums.forEach(num => num*num)
l(`forEach does NOT return anything - ${a}`)
bln(2)

let b = nums.map(num => num*num)
l(`New Squared (map) - ${b}`)
bln(2)

let even = nums.filter(num => num%2 == 0)
l(`Even - ${even}`)
bln(1)
let odd = nums.filter(num => num%2 != 0)
l(`Odd - ${odd}`)
bln(2)

let c = nums.reduce((prev, curr) => prev+=curr)
l(`Reduced - ${c} (sum, as array contains numbers)`)
bln(1)
let d = names.reduce((prev, curr) => prev+=curr)
l(`Reduced - ${d}`)