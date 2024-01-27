import "../styles/styles.css";
import brokenHandcuffs from "../images/broken-handcuffs.png";

const img = document.createElement("img");
img.className = "quote__img2";
img.setAttribute("src", brokenHandcuffs);
img.setAttribute("alt", "Someone's upraised arms bound to the pieces of a handcuff that has just been broken.");
img.setAttribute("width", "817");
img.setAttribute("height", "460");

const imgContainer = document.querySelector(".quote");
imgContainer.appendChild(img);
