const get = document.querySelector("#get");
let h2 = document.querySelector("h2");
let h3 = document.querySelector("h3");

const URL = "https://official-joke-api.appspot.com/jokes/random";

let idList = [];
const availableJokes = 451;
let count = 0;
async function getJoke() {
  let res = await fetch(URL);
  let data = await res.json();
  let q = data["setup"];
  let a = data["punchline"];
  let id = data["id"];
  if (!idList.includes(id)) {
    idList.push(id);
    h2.innerText = q;
    h3.innerText = a;
    count++;
  } else {
    if (count < availableJokes) {
      getJoke();
    } else {
      h2.innerText = "!! SURPRISE !!";
      h3.innerText = "All Jokes are OVER, Thanks for Staying with Us";
      get.style.display = "none";
    }
  }
}

get.addEventListener("click", getJoke);
