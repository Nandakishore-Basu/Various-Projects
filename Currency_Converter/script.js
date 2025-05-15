const baseUrl =
  "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies";
const selects = document.querySelectorAll(".dropdown select");
const btn = document.querySelector("form button");
const msg = document.querySelector(".msg");

const updateFlag = (el) => {
  let currCode = el.value;
  let country = countryList[currCode];
  let newSrc = `https://flagsapi.com/${country}/shiny/64.png`;
  let img = el.parentElement.querySelector("img");
  img.src = newSrc;
};
btn.addEventListener("click", async (e) => {
  e.preventDefault();
  let amount = document.querySelector("input");
  let aVal = amount.value;
  if (aVal === "" || aVal < 0) {
    aVal = 1;
    amount.value = "1";
  }
  let fromCurr = document.querySelector(".from select").value;
  let toCurr = document.querySelector(".to select").value;
  const url = `${baseUrl}/${fromCurr.toLowerCase()}.json`;
  let response = await fetch(url);
  let data = await response.json();
  let rate = data[fromCurr.toLowerCase()][toCurr.toLowerCase()];
  let finalAmount = aVal * rate;
  msg.innerText = `${aVal} ${fromCurr} = ${finalAmount} ${toCurr}`;
});
for (let select of selects) {
  for (currCode in countryList) {
    let newOp = document.createElement("option");
    newOp.innerText = currCode;
    newOp.value = currCode;
    select.append(newOp);
  }
  select.addEventListener("change", (e) => {
    updateFlag(e.target);
  });
}
