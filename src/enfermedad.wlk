/*1)Ante una nueva enfermedad podriamos o instanciar un objeto nuevo o tambien hacer una nueva 
 * clase de enfermedad. En ambos casos seria necesario conocer la cantidad de celulas
 * amenazadas de la misma primero.
 * 2)Si todas las enfermedades destruyeran las celulas que amenazan, le quitarian a la persona que 
 * afectan la misma cantidad de celulas que amenazan pero del cuerpo de la persona en si. Si
 * las autoinmunes tuvieran otro efecto adicional, se puede agregar un nuevo metodo en la clase
 * EnfermedadAutoinmune para que cumpla lo deseado.
 * 3)Para este caso, podemos heredar uno de los 2 tipos de enfermedades y sobreescribirlo,
 * utilizando un super y agregando ademas las acciones del otro tipo de enfermedad. Tambien se 
 * podria crear otra clase nueva con sus propios metodos y acciones.
 */

class Enfermedad{
	var celulasAmenazadas
	
	method obtenerCelulasAmenazadas() = celulasAmenazadas
	
	method atenuar(valor){
		celulasAmenazadas = 0.max(celulasAmenazadas - valor)
	}
}

class EnfermedadInfecciosa inherits Enfermedad{
	method producirEfectoEn(persona){
		persona.aumentarTemperatura(celulasAmenazadas / 1000)
	}
	
	method reproducirse(){
		celulasAmenazadas = celulasAmenazadas * 2
	}
	
	method esAgresivaEn(persona) = celulasAmenazadas > (persona.obtenerCelulas() * 0.10)
}

class EnfermedadAutoinmune inherits Enfermedad{
	var dias = 0
	
	method producirEfectoEn(persona){
		persona.destruirCelulas(celulasAmenazadas)
		dias = dias + 1
	}
	
	method esAgresivaEn(persona) = dias > 30
}

class Muerte inherits Enfermedad{
	method producirEfectoEn(persona){
		persona.disminuirTemperatura(persona.obtenerTemperatura())
	}
	
	method esAgresivaEn(persona) = true
}
