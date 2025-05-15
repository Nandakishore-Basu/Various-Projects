let boxes = document.querySelectorAll(".box");
let turnX = true;
let reset_btn = document.querySelector("#reset");
let newG = document.querySelector("#newG");
let msgCon = document.querySelector(".msg-con");
let msg = document.querySelector("#msg");
const win = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
];
let count = 0;
boxes.forEach((box) => {
  box.addEventListener("click", () => {
    if (turnX) {
      box.innerText = "X";
      box.classList.add("x");
      box.classList.remove("o");
      turnX = false;
      count++;
    } else {
      box.innerText = "O";
      box.classList.add("o");
      box.classList.remove("x");
      turnX = true;
      count++;
    }
    box.disabled = true;
    winner();
  });
});
const showWinner = (win) => {
  msg.innerText = `Congaratulations!! Winner Is ${win}`;
  msgCon.classList.remove("hide");
};
const draw = () => {
  msg.innerText = `Alas!! The Game Is A Draw!! Play Again...`;
  msgCon.classList.remove("hide");
};
const winner = () => {
  for (pattern of win) {
    let pos1 = boxes[pattern[0]].innerText;
    let pos2 = boxes[pattern[1]].innerText;
    let pos3 = boxes[pattern[2]].innerText;
    if (pos1 != "" && pos2 != "" && pos3 != "") {
      if (pos1 === pos2 && pos2 === pos3) {
        boxes.forEach((box) => {
          box.disabled = true;
        });
        showWinner(pos1);
      }
      if (count === 9) {
        draw();
      }
    }
  }
};
const reset = () => {
  turnX = true;
  msgCon.classList.add("hide");
  boxes.forEach((box) => {
    box.disabled = false;
    box.innerText = "";
  });
  count = 0;
};
newG.addEventListener("click", reset);
reset_btn.addEventListener("click", reset);
