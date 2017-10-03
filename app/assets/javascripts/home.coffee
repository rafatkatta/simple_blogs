# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('blogers', [])

app.controller 'MainCtrl', ['$scope','$http','$sce',($scope, $http,$sce) ->

  $scope.callBlogs = (category_id) ->
    $http.get("/home/blogs/" + category_id + '.json').then((response) ->
      $scope.blogs= response.data
      return) 
  
  $scope.callBlog = (blog_id) ->
    $http.get("/home/blog/" + blog_id + '.json').then((response) ->
      $scope.blog= response.data['blog']
      $scope.bloger= response.data['bloger']
      $scope.messages = response.data['messages']
      $scope.$sce = $sce
      return)       
      
  return]
app.controller 'CategoryCtrl', ['$scope','$http',($scope, $http) ->
  $http.get('/home/categories.json').then((response) ->
    $scope.categories = response.data
    return)
  
  return]
app.controller 'BlogCtrl', ['$scope','$http',($scope, $http) ->

  
  return]

