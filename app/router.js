angular
	.module('optikApp')
	.config( function($stateProvider, $urlRouterProvider){
		$urlRouterProvider.otherwise('/listado');
		$stateProvider
			.state('dashboard', {
				url: '/dashboard',
				templateUrl: 'dashboard/dashboard.html'
			})
			.state('login',{
				url: '/login',
				templateUrl: 'templates/login.html'	
			})
			.state('listado',{
				url: '/listado',
				templateUrl: 'listado/listado.html'
			})
		
	});