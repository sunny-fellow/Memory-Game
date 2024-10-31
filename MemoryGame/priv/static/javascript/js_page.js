// BOTÕES
const botao_start_main = document.getElementById("newgame-main");
const botao_back_main = document.getElementById("to-main-bd");

// ZONAS
botao_start_main.addEventListener("click", () => {
        // fetch("http://localhost:4000/api/playing")
        //   .then((response) => response.json())
        //   .then((data) => {
        //    console.log(data) ;
        //   });
        zona_game.display = "flex";
        window.location.href = "http://localhost:4000/game"
        
      });
