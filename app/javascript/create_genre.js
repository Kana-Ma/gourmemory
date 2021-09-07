if (location.pathname.match("points/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("points_genre_genre_name");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("points_genre_genre_name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const genreName = XHR.response.keyword;
          genreName.forEach((genre) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", genre.id);
            childElement.innerHTML = genre.genre_name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(genre.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("points_genre_genre_name").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};