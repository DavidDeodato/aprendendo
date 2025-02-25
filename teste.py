import fastapi
from pydantic import BaseModel

# =criando um app fastapi

app = fastapi.FastAPI()

# - criando uma classe para receber os dados

class Dados(BaseModel):
    nome: str
    genero_filme: str
    idade: int

# - criando uma rota fastapi para conseguir enviar esses dados

@app.post('/enviar_dados')
# criando a funcao para tratar os dados e enviar um response
def enviar_dados(request: Dados):
    # lógica para tratar os dados
    nome = request.nome
    genero_filme = request.genero_filme
    idade = request.idade


    #  - logica para enviar um response
    return {
        'mensagem': f'Olá {nome}, então você gosta de filmes de {genero_filme}? Que legal, acho que isso tá ligado com o fato de você ter {idade} anos!'
    }