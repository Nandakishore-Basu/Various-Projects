class Person {
    constructor(uid, name, post, bdrClr, txtClr) {
        this.name = name
        this.post = post
        this.bdrClr = bdrClr
        this.txtClr = txtClr
        this.uid = uid
    }
    
}

function addData(Person) {
    if (Person.name && Person.post) {
        newD = document.createElement('section')
        newD.classList.add('dataOther')
        newD.innerHTML = `<h3>You Are</h3>
            <marquee><h1>${Person.name}</h1></marquee>
            <h4>${Person.post}</h4>`
        if (Person.bdrClr) {
            newD.style.borderColor = Person.bdrClr
        }
        if (Person.txtClr) {
            newD.style.color = Person.txtClr
        }
        newD.id = Person.uid
        document.body.appendChild(newD)
    }
}
function modifyData(Person) {
    let dataId = Person.uid
    let x = document.querySelector(`#${dataId}`)
    x.innerHTML = `<h3>You Are</h3>
            <marquee><h1>${Person.name}</h1></marquee>
            <h4>${Person.post}</h4>`
    if (Person.bdrClr) {
        x.style.borderColor = Person.bdrClr
    }
    if (Person.txtClr) {
        x.style.color = Person.txtClr
    }
}
function removeData(Person) {
    let dataId = Person.uid
    document.querySelector(`#${dataId}`).remove()
}
function nClr(Person, clr) {
    if (clr) {
        document.querySelector(`#${Person.uid}`).querySelector('h1').style.color = clr
    }
}
function pClr(Person, clr) {
    if (clr) {
        document.querySelector(`#${Person.uid}`).querySelector('h4').style.color = clr
    }
}
function intro(Person, clr, txt) {
    if (clr) {
        document.querySelector(`#${Person.uid}`).querySelector('h3').style.color = clr
    }
    if (txt) {
        document.querySelector(`#${Person.uid}`).querySelector('h3').innerText = txt
    }
}

for (let i = 1; i <= 500; i++) {
    addData(new Person(`a${i}`, `Person ${i}`, 'Post'))
}