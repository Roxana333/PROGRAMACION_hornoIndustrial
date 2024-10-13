import unittest
#from test_horno_industrial import hornoIndustrial
import hornoIndustrial

class TestHornoIndustril(unittest.TestCase):
    
    
    
    def controlar_temperatura(self):
        horno = hornoIndustrial(200 , 250)
        
        
        #se enciende el calentador si la temperatura es minima
        horno.controlar_temperatura(190)
        self.assertTrue(horno.calentador_encendido)
        
        #se debe apagar la calefaccion si la temperatura es maxima
        horno.controlar_temperatura(250)
        self.assertFalse(horno.calentador_encendido)
        
        
    def  test_calentar(self):
        horno = hornoIndustrial(200 , 250)
        
        #la temperatura inicial 25°C (ambiente)
        horno.calentar(5 , calentamiento=10)
        self.assertEqual(horno.temperatura_actual, 75) 
        
        
        #no debe exeder la temperatura objetivo
        horno.temperatura_actual = 190
        horno.calentar(5 , calentamiento=10 )
        self.assertEqual(horno.temperatura_actual, 200) #no debe pasar de 200°C
        
        #descongelamiento
        horno.descongelar(5 , descongelar=10 )
        self.assertEqual(horno.temperatura_actual ,150)
        
    def test_sobrecalentamiento(self):
        horno = hornoIndustrial (200 , 250)
        
        
        #simular una temperatura superior al limite de seguridad
        horno.verificar_sistema(260 , True)
        self.assertFalse(horno.calentador_encendido) #apagado por seguridad
        
    def test_fallo_sensor(self):
        horno = hornoIndustrial(200 , 250)
        
        #simulador de fallo de sensor
        horno.verificar_sistema(200 , False)
        self.assertTrue(horno.sistema_en_falla) # sistema en modo de falla
        self.assertFalse(horno.calentador_encendido) # calentador apagar
        
        
            
            
            
        
        
        
        
        
        
        
        
        



