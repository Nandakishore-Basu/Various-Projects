let uS = 0;
let bS = 0;
let rnd = 0;
let rnd_b = document.querySelector("#round");
rnd_b.innerText = rnd;
let uS_B = document.querySelector("#userS");
let bS_B = document.querySelector("#botS");
let msg = document.querySelector(".msg");
let btn_reset = document.querySelector(".btn");
const bChoice = () => {
  const opt = ["Stone", "Paper", "Scissor"];
  const idx = Math.floor(Math.random() * 3);
  return opt[idx];
};
const draw = (x) => {
  msg.innerText = `! DRAW ! BOTH CHOSE '${x}' ! PLAY AGAIN !`;
  msg.style.backgroundColor = "rgb(0,0,34)";
};
const winner = (win, user, bot) => {
  if (win) {
    uS++;
    uS_B.innerText = uS;
    msg.innerText = `YOUR '${user}' BEATS '${bot}' ! PLAY AGAIN !`;
    msg.style.backgroundColor = "green";
  } else {
    bS++;
    bS_B.innerText = bS;
    msg.innerText = `BOT'S '${bot}' BEATS '${user}' ! PLAY AGAIN !`;
    msg.style.backgroundColor = "red";
  }
};
const game = (choice) => {
  rnd++;
  rnd_b.innerText = rnd;
  let auto = bChoice();
  if (choice === auto) {
    draw(choice);
  } else {
    let uWin = true;
    if (choice === "Stone") {
      uWin = auto === "Paper" ? false : true;
    } else if (choice === "Paper") {
      uWin = auto === "Scissor" ? false : true;
    } else {
      uWin = auto === "Stone" ? false : true;
    }
    winner(uWin, choice, auto);
  }
};
const choices = document.querySelectorAll(".choice");
choices.forEach((choice) => {
  choice.addEventListener("click", () => {
    const uChoice = choice.getAttribute("id");
    game(uChoice);
  });
});
const reset = () => {
  uS = 0;
  bS = 0;
  rnd = 0
  rnd_b.innerText = rnd
  uS_B.innerText = uS;
  bS_B.innerText = bS;
  msg.innerText = "PLAY YOUR MOVE";
  msg.style.backgroundColor = "rgb(0,0,34)";
};
btn_reset.addEventListener("click", reset);
