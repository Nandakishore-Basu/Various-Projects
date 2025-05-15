let btn = document.querySelector("#btn");
let p = document.querySelector("p");
let body = document.body;
let btn2 = document.querySelector("#rand");


async function getShlok(e) {
  e.preventDefault();
  let ch = document.querySelector("#ch").value;
  let sh = document.querySelector("#sh").value;
  if (ch === "") {
    ch = 1;
    document.querySelector("#ch").value = 1;
  }
  if (sh === "") {
    sh = 1;
    document.querySelector("#sh").value = 1;
  }
  if (ch >= 1 && ch <= 18) {
    let urlC = `https://vedicscriptures.github.io/chapter/${ch}`;
    let resp = await fetch(urlC);
    let about = await resp.json();
    let total = about["verses_count"];
    let chName = about["name"];
    let chNameEn = about["translation"];
    if (sh >= 1 && sh <= total + 1) {
      let urlS = `https://vedicscriptures.github.io/slok/${ch}/${sh}`;
      let res = await fetch(urlS);
      let data = await res.json();
      let shlok = data["slok"];
      let inEn = data["transliteration"];
      p.innerText = `${chName} || ${chNameEn} \n\n ${shlok} \n\n ${inEn}`;
    } else {
      p.innerText = `Invalid Number Of Shlok \n\n It Should Be Between 1 and ${
        total + 1
      } \n Shlok Number ${total + 1} Is The Closing Shlok`;
    }
  } else {
    p.innerText =
      "Chapter Number Is Not Valid \n\n It Must Be Between 1 and 18";
  }
}

async function getRandomShlok(e){
  e.preventDefault()
  let ch = document.querySelector("#ch").value;
  let sh = document.querySelector("#sh").value;
  ch = Math.ceil(Math.random() * 18);
  let urlC = `https://vedicscriptures.github.io/chapter/${ch}`;
  let resp = await fetch(urlC);
  let about = await resp.json();
  let total = about["verses_count"];
  sh = Math.ceil(Math.random() * (total + 1));
  let urlS = `https://vedicscriptures.github.io/slok/${ch}/${sh}`;
  let res = await fetch(urlS);
  let data = await res.json();
  let shlok = data["slok"];
  let inEn = data["transliteration"];
  let chName = about["name"];
  let chNameEn = about["translation"];
  p.innerText = `${chName} || ${chNameEn} \n\n ${shlok} \n\n ${inEn}`;
  document.querySelector("#ch").value = ch;
  document.querySelector("#sh").value = sh;
}


btn.addEventListener("click", getShlok);
btn2.addEventListener("click", getRandomShlok);
document.addEventListener("keydown", (e) => {
  if (e.key === "Enter") {
    getShlok(e);
  }
});
