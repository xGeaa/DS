from abc import ABC, abstractmethod
import requests
import json
import os

class LLM(ABC):
    @abstractmethod
    def generate_summary(self, text: str) -> str:
        pass

class BasicLLM(LLM):
    def __init__(self, llm_model: str, token: str):
        self.model = llm_model
        self.token = token
        self.api_url = f"https://router.huggingface.co/hf-inference/models/{llm_model}"

    def generate_summary(self, text: str):
        payload = {"inputs": text, "options": {"wait_for_model": True}}
        headers = {"Authorization": f"Bearer {self.token}"}
        response = requests.post(self.api_url, headers=headers, json=payload)
        response.raise_for_status()
        data = response.json()
        
        try:
            resumen = data[0]["generated_text"]
        except (TypeError, KeyError, IndexError):
            resumen = str(data)
        return resumen


class Decorator(LLM):
    def __init__(self, llm: LLM, token: str):
        self.llm_decorador = llm
        self.token = token

    def generate_summary(self, text: str):
        return self.llm_decorador.generate_summary(text)


class TranslationDecorator(Decorator):
    def __init__(self, llm: LLM, model_translation: str, token: str):
        super().__init__(llm, token)
        self.model = model_translation
        self.api_url = f"https://router.huggingface.co/hf-inference/models/{model_translation}"

    def generate_summary(self, text: str):
        resumen = super().generate_summary(text)
        payload = {"inputs": resumen, "options": {"wait_for_model": True}}
        headers = {"Authorization": f"Bearer {self.token}"}
        response = requests.post(self.api_url, headers=headers, json=payload)
        response.raise_for_status()
        data = response.json()
        try:
            traduccion = data[0]["translation_text"]
        except (TypeError, KeyError, IndexError):
            traduccion = str(data)
        return traduccion


class SentimentDecorator(Decorator):
    def __init__(self, llm: LLM, model_sentiment: str, token: str):
        super().__init__(llm, token)
        self.model = model_sentiment
        self.api_url = f"https://router.huggingface.co/hf-inference/models/{model_sentiment}"

    def generate_summary(self, text: str):
        resumen = super().generate_summary(text)
        payload = {"inputs": resumen, "options": {"wait_for_model": True}}
        headers = {"Authorization": f"Bearer {self.token}"}
        response = requests.post(self.api_url, headers=headers, json=payload)
        response.raise_for_status()
        data = response.json()

        try:
            resultados = data[0]  
            mejor = max(resultados, key=lambda x: x["score"])
            sentimiento = mejor['label']
        except (TypeError, KeyError, IndexError):
            sentimiento = str(data)

        return sentimiento


if __name__ == "__main__":

    with open("info.json") as f:
        config = json.load(f)

    texto = config["texto"]
    model_llm = config["model_llm"]
    model_translation = config["model_translation"]
    model_sentiment = config["model_sentiment"]
    token = config["huggingface_api_token"]


    llm = BasicLLM(model_llm, token)
    llm_tranlation = TranslationDecorator(llm, model_translation, token)
    llm_sentiment = SentimentDecorator(llm, model_sentiment, token)
    llmfinal= SentimentDecorator(llm_tranlation,model_sentiment,token)
   
    resultadocombinado = llmfinal.generate_summary(texto)
    resultadobasico = llm.generate_summary(texto)
    resultadotraducido = llm_tranlation.generate_summary(texto)
    resultadosentiment = llm_sentiment.generate_summary(texto)
    print("RESUMEN BASICO")
    print(resultadobasico)
    print("\nRESUMEN TRADUCIDO")
    print(resultadotraducido)
    print("\nRESUMEN SENTIMIENTO")
    print(resultadosentiment)
    print("\nRESUMEN COMBINADO")
    print(resultadocombinado)