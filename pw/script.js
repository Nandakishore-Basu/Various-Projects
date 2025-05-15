let PASS = "xyz123";
let now = "p";
let see = document.querySelector(".see");
let sub = document.querySelector("#sub");
let pw = document.querySelector("#newP");
let msg = document.querySelector("#msg");
let a = document.createElement('a')

function setPassword(x) {
  PASS = x
}

a.setAttribute('id', 'a1')
a.href = '../stone_paper_scissor/index.html'
a.innerText = 'Link : Stone Paper Scissor'
const check = () => {
  let input = pw.value;
  if (input == PASS) {
    msg.innerText = "Success";
    msg.after(a)
    sub.disabled = true
    pw.disabled = true
    see.disabled = true
  } else {
    msg.innerText = "Failure, Try Again";
  }
  pw.value = "";
};
const seeP = () => {
  if (now == "p") {
    pw.type = "text";
    see.innerText = "Hide Password";
    now = "t";
  } else if (now == "t") {
    pw.type = "password";
    see.innerText = 'See Password'
    now = "p";
  }
};

sub.addEventListener("click", (e) => {
  e.preventDefault();
  check();
});
see.addEventListener("click", (e) => {
  e.preventDefault();
  seeP();
});
