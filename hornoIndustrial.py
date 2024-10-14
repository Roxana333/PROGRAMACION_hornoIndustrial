class hornoIndustrial():
    # inicia el horno con la temperatura objetivo y limite de seguridad
    def __init__(self , temperatura_objetivo, limite_seguridad):
        self.temperatura_objetivo = temperatura_objetivo
        self.limite_seguridad = limite_seguridad
        #self.temperatura_actual = 30     # temperatura inicial
        #self.calentador_encendido = False
        #self.sistema_en_falla = False
      
    def controlar_temperatura(self , temperatura_actual):
        #controla temperatura encendido o apagado en el calentador 
        self.temperatura_actual = temperatura_actual
        tiempo = 20 
        if temperatura_actual < self.temperatura_objetivo - tiempo:
            self.calentador_encendida = True
        elif temperatura_actual > self.temperatura_objetivo + tiempo:
            self.calentador_encendida = False
            
    def calentar(self , minutos , calentamiento=10):
        # aumento de temperatura hasta alcanzar la coccion
        aumento = calentamiento * minutos
        if self.temperatura_actual + aumento <= self.temperatura_objetivo:
            self.temperatura_actual += aumento
        else:
            self.temperatura_actual = self.temperatura_objetivo
            
    def descongelar(self , minutos , descongelar=5):
        #reduce la temperatura
        reduce = descongelar * minutos
        if self.temperatura_actual - reduce > 5: # menos no de puede bajar la temperatura
            self.temperatura_actual -= reduce
        else:
            self.temperatura_actual = 5
            
    def verificacion_sistema(self , temperatura_actual , sensore_activo):
        #verificacion de fallos en sesor y sobrecalentamiento
        self.temperatura_actual = temperatura_actual
        if not sensore_activo:
            self.sistema_en_falla = True
            self.apagar()
            print("Error : senor no reponde.modo seguro.")
            return
        
        
        if temperatura_actual > self.limite_seguridad:
            self.apagar()
            print (f"Alerta: sobrecalentamiento a {temperatura_actual}°C. sistema apagado.")
            
            
    def apagar (self):
       #apagar en caso de fallo o sobrecalentamiento
       self.calentador_encendida = False
       print("calentador apagado.")
       
       
    
                
                
        
        
        
            
      
      