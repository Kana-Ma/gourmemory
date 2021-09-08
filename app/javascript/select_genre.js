if (location.pathname.match("shops/new")){
  document.addEventListener('DOMContentLoaded',() => {
    const selectedGenre = document.getElementById("selected_genre");
    selectedGenre.addEventListener('change', () => {
      const genreId = document.getElementById("selected_genre").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?genre_id=${genreId}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const point = XHR.response.point[0];
        document.getElementById("genre_id").value = point['genre_id'];
        document.getElementById("point_id").value = point['id'];
        const point1 = document.getElementById("point1");
        point1.innerHTML = point['point1'];
        const point2 = document.getElementById("point2");
        point2.innerHTML = point['point2'];
        const point3 = document.getElementById("point3");
        point3.innerHTML = point['point3'];
      };
    });
  });
};