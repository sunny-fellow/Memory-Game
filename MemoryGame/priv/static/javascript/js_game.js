// CARD IMG PATHS
const cards_img = [
    "/static/assets/images/clubsblock.png",
    "/static/assets/images/clubsclover.png",
    "/static/assets/images/diamondsblock.png",
    "/static/assets/images/diamondsclover.png",
    "/static/assets/images/heartsblock.png",
    "/static/assets/images/heartsclover.png",
    "/static/assets/images/spadesblock.png",
    "/static/assets/images/spadesclover.png"
]

// Inicializando deck
let deck = null;
async function fetchDeck() {
    if (deck != null){return deck;}
    fetch("http://localhost:4000/api/playing")
    .then(response => response.json())
    .then(data => {
        deck = data.deck;
        return deck; // Retorna `deck` atualizado para encadeamento
    });
}
fetchDeck().then((data) => console.log(data))

// Sleep func
function sleep(ms){return new Promise(resolve => setTimeout(resolve, ms));}


// NON-CARD BUTTONS
const botao_back_main = document.getElementById("to-main-bd");
const btn_new_game = document.getElementById("newgame-board")

// CARD BUTTONS
const allButtons = document.querySelectorAll('.block-but');
allButtons.forEach(botao => {
    botao.addEventListener("click", () => upturn(botao.id))
})

const zona_game = document.getElementById("game");

// window.addEventListener("load", function(){
//     zona_game.style.display = "flex";

//     this.fetch("http://localhost:4000/api/playing")
//     .then((response)=>response.json())
//     .then((data)=> {
//     // Setando todos os quadrados pra unturned
//         const deck_aleatorio = data.deck;// Array de objetos
//         const letter_keys = ['a', 'b', 'c', 'd']

//         for( let i = 0; i < deck_aleatorio.length; i++){
//             let chave_num = Math.floor(i/4) + 1;
//             let chave_string = chave_num.toString();
//             const id = "block-" + chave_string;

//             for (let x in letter_keys){
//                 let termo = this.document.getElementById(id + letter_keys[x])
//                 termo.src = "static/assets/images/unturned.png"
//             }
//         }
//     });
// })

botao_back_main.addEventListener("click", ()=>{
    window.location.href = "http://localhost:4000/teste";
})

btn_new_game.addEventListener("click", ()=>{
    window.location.href = "http://localhost:4000/game";
})

function id_to_index(e){
    const letra = e.at(e.length - 1);
    const letraint = parseInt(letra, 36) - 10;
    const num = e.at(e.length - 2);
    const numint = parseInt(num) - 1;

    let indice = 4 * numint + letraint;
    return indice;
}

function index_to_id(num){
    let part_num = Math.floor((num / 4)) + 1;
    let part_char;
    let resto = num % 4;

    switch (resto) {
        case 0:
            part_char = 'a'
            break;
    
        case 1:
            part_char = 'b'
            break;

        case 2:
            part_char = 'c'
            break;

        case 3:
            part_char = 'd'
            break;
        default:
            break;
    }

    return part_num.toString() + part_char;

}

function upturn(e){
    console.log(e);
    const letra = e.at(e.length - 1);
    const letraint = parseInt(letra, 36) - 10;
    const num = e.at(e.length - 2);
    const numint = parseInt(num) - 1;

    let indice = 4 * numint + letraint;
    fetchDeck().then((deck) => {
        if(deck[indice].upturn == true) { return; }
    
    deck[indice].upturned = true
    let termo = document.getElementById("block-" + num + letra);
    termo.src = cards_img[deck[indice].id - 1];

    // e.classList.add("selected-block");
    // e.disabled = true;
    // lock[numint].lockval[letraint] = 1;

    check_upturned();
    check_state();
    })

    // e.classList.add("selected-block");
    // e.disabled = true;
    // lock[numint].lockval[letraint] = 1;
}

function check_state() {
    fetchDeck().then((deck) => {
        for (let i in deck){
            if (deck[i].locked == false){return;}
        }
        console.log(deck);
        const endgame = document.getElementById("endgame");
        endgame.innerHTML = "Fim de Jogo!";
    })
}

function check_upturned(){
    let num = 0;
    let cartas_viradas = []
    fetchDeck().then((deck) => {
        for (let i in deck){
            if (deck[i].upturned == true){
                num += 1;
                cartas_viradas.push(i);
            }
        }
    
        if (num == 2){check_ids(cartas_viradas)}
    });
}

function check_ids(turned_cards){
    fetchDeck().then((deck) => {
        deck[turned_cards[0]].upturned = false
        deck[turned_cards[1]].upturned = false

        let id_btn_one = index_to_id(turned_cards[0]);
        let id_btn_two = index_to_id(turned_cards[1]);

        if (deck[turned_cards[0]].id == deck[turned_cards[1]].id){
            deck[turned_cards[0]].locked = true
            deck[turned_cards[1]].locked = true

            const botao_one = document.getElementById("but-" + id_btn_one);
            const botao_two = document.getElementById("but-" + id_btn_two);
            botao_one.disabled = true;
            botao_two.disabled = true;
        }
        else{
            const img_one = document.getElementById("block-" + id_btn_one);
            const img_two = document.getElementById("block-" + id_btn_two);

            sleep(1000).then(() => {
                img_one.src = "static/assets/images/unturned.png";
                img_two.src = "static/assets/images/unturned.png";
            })
        }
    })
}

/*Flow chart geral:
    1. Clica no botão, evento ativa
        1.1. Obtém o indice equivalente daquele botão
        1.2. Checa se o obj no indice obtido em deck tem upturned true. Se sim, ignorar, se não, passo 1.3.
        1.3. Seta upturned pra true e muda a imagem do img daquele botão
    2. Checa se há mais de um upturned
        2.1. Varre pelo deck, se acusar mais de dois upturned, significa que há uma dupla. Se não acusar, ignorar
        2.2. Pega os dois objetos no array de cartas viradas, se ambos tiverem id igual, setar locked de ambos pra true, upturned pra false
        e desabilitar o botão.
    3. Checar estado do jogo: Varre pelo deck e se encontrar um locked = false, continuar jogo
*/