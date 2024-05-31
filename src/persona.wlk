class Persona{
	const enfermedades = []
	var temperatura
	var celulas
	var estaSano = true
	
	method contraerEnfermedad(enfermedad){
		estaSano = false
		if(enfermedades.size() < 5){
			enfermedades.add(enfermedad)
		}
	} 
	
	method producirEfectos() = enfermedades.forEach({e => e.producirEfectoEn(self)})
	
	method aumentarTemperatura(valor){
		temperatura = 45.min(temperatura + valor)
	}
		
	method disminuirTemperatura(valor){
		temperatura = 0.max(temperatura - valor)
	}
	
	method obtenerTemperatura() = temperatura
	
	method obtenerEnfermedades() = enfermedades
	
	method destruirCelulas(valor){
		celulas = 0.max(celulas - valor)
	}
	
	method obtenerCelulas() = celulas
	
	method vivirUnDia() = self.producirEfectos()
	
	method celulasAmenazadasPorEnfAgresivas() = enfermedades.filter
	({e => e.esAgresivaEn(self)}).sum({e => e.obtenerCelulasAmenazadas()})
	
	method enfermedadQueMasCelAfecta() = enfermedades.max({e => e.obtenerCelulasAmenazadas()})
	
	method estaEnComa() = temperatura == 45 or celulas < 1000000
	
	method estaEnfermo() = !(enfermedades.isEmpty())
	
	method recibirMedicamento(valor){
		enfermedades.forEach({e => e.atenuar(valor)})
		if(enfermedades.sum({e => e.obtenerCelulasAmenazadas()}) == 0){
			estaSano = true
		}
	} 
	
	method estaCurado() = estaSano
	
	method estaVivo() = !(temperatura == 0)
}

class Medico inherits Persona{
	var dosis
	
	method atenderA(persona){
		if(persona.estaEnfermo()){
			persona.recibirMedicamento(dosis * 15)
		}else if(!(enfermedades.isEmpty())){
			self.atenderA(self)
		}
	}
	
	method esMedico() = true	
}

class JefeMedico inherits Medico{
	/*override method atenderA(persona){	
		if(persona.esMedico()){
			persona.atenderA(self)
		}else{
			super(persona)
		}
	}*/
	method atenderA(paciente,subordinado){	
		if(paciente.esMedico()){
			paciente.atenderA(paciente)
		}else{
			subordinado.atenderA(paciente)
		}
	}
}
