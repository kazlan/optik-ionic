angular
	.module('optikApp')
	.controller('listadoController',listadoController);
	
listadoController.$inject=['$scope','dataFactory'];

function listadoController($scope,dataFactory){
	$scope.clientes = dataFactory.clientesArray;
};