defmodule JogosMemoria.Cards do
  # id: Refere-se a carta em especifico. Numero int
  # img: string pro path da imagem quando está virada
  # current_img: Imagem atualmente mostrada
  # upturned: booleano pra determinar se está virado para cima ou não
  # locked: Se o par foi encontrado, deixa ambos trancados para viragens futuras
  @derive Jason.Encoder
  defstruct [:id, :img, :upturned, :locked]

  @upturned_img "priv/static/assets/images/unturned.png"

  def all() do
    [
      struct(__MODULE__, %{
        id: 1,
        img: @upturned_img,
        upturned: false,
        locked: false
      }),
      struct(__MODULE__, %{
        id: 1,
        img: @upturned_img,
        upturned: false,
        locked: false
      }),
      struct(__MODULE__, %{
        id: 2,
        img: @upturned_img,
        upturned: false,
        locked: false
      }),
      struct(__MODULE__, %{
        id: 2,
        img: @upturned_img,
        upturned: false,
        locked: false
      }),
      struct(__MODULE__, %{
        id: 3,
        img: @upturned_img,
        upturned: false,
        locked: false
      }),
      struct(__MODULE__, %{id: 3, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 4, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 4, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 5, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 5, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 6, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 6, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 7, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 7, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 8, img: @upturned_img, upturned: false, locked: false}),
      struct(__MODULE__, %{id: 8, img: @upturned_img, upturned: false, locked: false})
    ]
  end

  def embaralhar do
    Enum.shuffle(all())
  end
end
