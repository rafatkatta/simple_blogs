# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('blogers', [])

app.controller 'CategoryCtrl', ['$scope','$http',($scope, $http) ->
  $http.get('/home/categories.json').then((response) ->
    data = response.data
    status = response.status
    statusText = response.statusText
    headers = response.headers
    config = response.config

    $scope.categories = data
    console.log data
    return)
   
  $scope.callBlogs = (category_id) ->
    $http.get("/home/blogs/" + category_id).then((response) ->
       console.log response.data
       data = response.data
       $scope.blogs= data
       return)
    return
    
  return]
