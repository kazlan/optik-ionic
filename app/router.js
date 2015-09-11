angular
	.module('optikApp')
	.config( function($stateProvider, $urlRouterProvider){
		$urlRouterProvider.otherwise('/dashboard');
		$stateProvider
			.state('dashboard', {
				url: '/dashboard',
				templateUrl: 'dashboard/dashboard.html'
			})
			.state('login',{
				url: '/login',
				templateUrl: 'templates/login.html'	
			})
		
	});