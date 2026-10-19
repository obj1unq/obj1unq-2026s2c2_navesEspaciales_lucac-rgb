
class Nave {

	var property velocidad = 0 

	method velocidadMaxima() = 300000

	method aumentarVelocidad(cantidad){
		velocidad =  (velocidad + cantidad).min(self.velocidadMaxima())
	}

	method propulsar(){
		self.aumentarVelocidad(20000)
	}

	method prepararParaViajar(){
		self.aumentarVelocidad(15000)
		self.prepararNave()
	}

	method prepararNave() {}

	method encontrarEnemigo(){
		self.recibirAmenaza()
		self.propulsar()
	}

	method recibirAmenaza() 

}

class NaveDeCarga inherits Nave {

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
	
	method enFalta() = self.sobrecargada() and self.excedidaDeVelocidad()
	
	method acercamientoDeControl() {
		if (self.enFalta()) {
			self.recibirAmenaza()
		}
	}

}

class NaveDeCargaRadiactiva inherits NaveDeCarga{

	var property estaSellada = false

	method sellar(){
		estaSellada = true
	}

	override method recibirAmenaza(){
		velocidad = 0
	}

}

class NaveDePasajeros inherits Nave {

	
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaPermitida() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaPermitida() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave {
	
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		self.emitirMensaje(modo.mensajeAmenaza())
	}

	override method prepararNave(){ 
		modo.prepararViaje(self)
	}



}

object reposo {

	method invisible() = false

	method mensajeAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararViaje(nave){
		nave.emitirMensaje("Saliendo en mision")
	}

}

object ataque {

	method invisible() = true

	method mensajeAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method mensajeAmenaza(){

	}

	method prepararViaje(nave){
		nave.emitirMensaje("Volviendo a la base")
	}
 
}

